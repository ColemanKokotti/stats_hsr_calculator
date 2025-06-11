import '../firebase_service/fireabese_service.dart';
import 'character_stats.dart';

class ApiStatsService {
  static Future<List<CharacterStats>> getCharacterStats() async {
    return await FirebaseService.getCharacterStats();
  }

  static Future<CharacterStats?> getCharacterStatsById(String characterId) async {
    return await FirebaseService.getCharacterStatsById(characterId);
  }

  static Future<CharacterStats?> getCharacterStatsByName(String characterName) async {
    return await FirebaseService.getCharacterStatsByName(characterName);
  }

  static Future<Map<String, CharacterStats>> getCharacterStatsMap() async {
    return await FirebaseService.getCharacterStatsMap();
  }

  static Future<bool> hasStatsForCharacter(String characterId) async {
    return await FirebaseService.hasStatsForCharacter(characterId);
  }

  static Future<List<CharacterStats>> getFilteredStats({
    int? minHp,
    int? maxHp,
    int? minAtk,
    int? maxAtk,
    int? minDef,
    int? maxDef,
    int? minSpd,
    int? maxSpd,
    int? minUltCost,
    int? maxUltCost,
  }) async {
    return await FirebaseService.getFilteredStats(
      minHp: minHp,
      maxHp: maxHp,
      minAtk: minAtk,
      maxAtk: maxAtk,
      minDef: minDef,
      maxDef: maxDef,
      minSpd: minSpd,
      maxSpd: maxSpd,
      minUltCost: minUltCost,
      maxUltCost: maxUltCost,
    );
  }

  // Additional utility methods for stats analysis
  static Future<List<CharacterStats>> getTopStatsByCategory({
    required String category, // 'hp', 'atk', 'def', 'spd'
    int limit = 10,
  }) async {
    final allStats = await getCharacterStats();

    allStats.sort((a, b) {
      switch (category.toLowerCase()) {
        case 'hp':
          return (b.hp ?? 0).compareTo(a.hp ?? 0);
        case 'atk':
          return (b.atk ?? 0).compareTo(a.atk ?? 0);
        case 'def':
          return (b.def ?? 0).compareTo(a.def ?? 0);
        case 'spd':
          return (b.spd ?? 0).compareTo(a.spd ?? 0);
        default:
          return 0;
      }
    });

    return allStats.take(limit).toList();
  }

  static Future<Map<String, dynamic>> getStatsAverages() async {
    final allStats = await getCharacterStats();
    if (allStats.isEmpty) return {};

    int totalHp = 0, totalAtk = 0, totalDef = 0, totalSpd = 0;
    int count = allStats.length;

    for (var stats in allStats) {
      totalHp += stats.hp ?? 0;
      totalAtk += stats.atk ?? 0;
      totalDef += stats.def ?? 0;
      totalSpd += stats.spd ?? 0;
    }

    return {
      'avgHp': totalHp / count,
      'avgAtk': totalAtk / count,
      'avgDef': totalDef / count,
      'avgSpd': totalSpd / count,
      'totalCharacters': count,
    };
  }
}