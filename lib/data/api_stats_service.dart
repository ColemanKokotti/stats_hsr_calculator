import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'character_stats.dart';

class ApiStatsService {
  static Future<List<CharacterStats>> getCharacterStats() async {
    try {
      // Load the JSON file from assets
      final String response = await rootBundle.loadString('assets/json/hsr_characters_stats.json');
      final data = json.decode(response);

      List<CharacterStats> characterStats = [];

      // Handle different JSON structures
      if (data is List) {
        // If the JSON is directly an array of character stats
        for (var item in data) {
          if (item is Map<String, dynamic>) {
            try {
              characterStats.add(CharacterStats.fromJson(item));
            } catch (e) {
              if (kDebugMode) {
                print('Error parsing character stats: $e');
              }
              if (kDebugMode) {
                print('Character stats data: $item');
              }
            }
          }
        }
      } else if (data is Map<String, dynamic> && data.containsKey('characters')) {
        // If the JSON has a "characters" key that holds the list
        for (var item in data['characters']) {
          if (item is Map<String, dynamic>) {
            try {
              characterStats.add(CharacterStats.fromJson(item));
            } catch (e) {
              if (kDebugMode) {
                print('Error parsing character stats: $e');
              }
              if (kDebugMode) {
                print('Character stats data: $item');
              }
            }
          }
        }
      } else {
        throw Exception('Invalid JSON format: Expected array or object with "characters" key.');
      }

      if (characterStats.isEmpty) {
        throw Exception('No character stats found in JSON file.');
      }

      // Sort by id for consistent ordering
      characterStats.sort((a, b) => a.id.compareTo(b.id));

      if (kDebugMode) {
        print('Successfully loaded ${characterStats.length} character stats');
      }
      return characterStats;
    } catch (e) {
      if (kDebugMode) {
        print('Error loading or parsing character stats from local JSON: $e');
      }
      rethrow;
    }
  }

  static Future<CharacterStats?> getCharacterStatsById(String characterId) async {
    try {
      // Get all character stats first
      final characterStats = await getCharacterStats();

      // Find the character stats with the matching ID
      try {
        final stats = characterStats.firstWhere(
              (stats) => stats.id == characterId,
        );
        return stats;
      } catch (e) {
        // Character not found, return null instead of throwing
        if (kDebugMode) {
          print('Character stats with ID $characterId not found');
        }
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error getting character stats by ID: $e');
      }
      rethrow;
    }
  }

  static Future<CharacterStats?> getCharacterStatsByName(String characterName) async {
    try {
      // Get all character stats first
      final characterStats = await getCharacterStats();

      // Find the character stats with the matching name (case insensitive)
      try {
        final stats = characterStats.firstWhere(
              (stats) => stats.name.toLowerCase() == characterName.toLowerCase(),
        );
        return stats;
      } catch (e) {
        // Character not found, return null instead of throwing
        if (kDebugMode) {
          print('Character stats with name $characterName not found');
        }
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error getting character stats by name: $e');
      }
      rethrow;
    }
  }

  // Metodo per ottenere le statistiche di più personaggi in una sola chiamata
  static Future<Map<String, CharacterStats>> getCharacterStatsMap() async {
    try {
      final characterStats = await getCharacterStats();

      // Crea una mappa con ID come chiave per accesso rapido
      final Map<String, CharacterStats> statsMap = {};
      for (var stats in characterStats) {
        statsMap[stats.id] = stats;
      }

      return statsMap;
    } catch (e) {
      if (kDebugMode) {
        print('Error creating character stats map: $e');
      }
      rethrow;
    }
  }

  // Metodo per verificare se esistono statistiche per un personaggio
  static Future<bool> hasStatsForCharacter(String characterId) async {
    try {
      final stats = await getCharacterStatsById(characterId);
      return stats != null;
    } catch (e) {
      if (kDebugMode) {
        print('Error checking if stats exist for character $characterId: $e');
      }
      return false;
    }
  }

  // Metodo per ottenere statistiche filtrate per criterio
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
    try {
      final allStats = await getCharacterStats();

      return allStats.where((stats) {
        // Filtra per HP
        if (minHp != null && stats.hp < minHp) return false;
        if (maxHp != null && stats.hp > maxHp) return false;

        // Filtra per ATK
        if (minAtk != null && stats.atk < minAtk) return false;
        if (maxAtk != null && stats.atk > maxAtk) return false;

        // Filtra per DEF
        if (minDef != null && stats.def < minDef) return false;
        if (maxDef != null && stats.def > maxDef) return false;

        // Filtra per SPD
        if (minSpd != null && stats.spd < minSpd) return false;
        if (maxSpd != null && stats.spd > maxSpd) return false;

        // Filtra per Ultimate Cost
        if (minUltCost != null && stats.ultCost != null && stats.ultCost! < minUltCost) return false;
        if (maxUltCost != null && stats.ultCost != null && stats.ultCost! > maxUltCost) return false;

        return true;
      }).toList();
    } catch (e) {
      if (kDebugMode) {
        print('Error filtering character stats: $e');
      }
      rethrow;
    }
  }
}