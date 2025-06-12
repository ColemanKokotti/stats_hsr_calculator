import 'package:cloud_firestore/cloud_firestore.dart';
import '../data/character_model.dart';
import '../data/character_stats.dart';

class FirebaseCharactersService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Collection references
  static const String _charactersCollection = 'characters';

  // Get all characters
  static Future<List<Character>> getCharacters() async {
    try {
      final QuerySnapshot querySnapshot = await _firestore
          .collection(_charactersCollection)
          .get();

      List<Character> characters = [];

      for (var doc in querySnapshot.docs) {
        try {
          final data = doc.data() as Map<String, dynamic>;
          data['id'] = data['id'] ?? doc.id;

          characters.add(Character.fromJson(data));
        } catch (e) {
          print('Error parsing character ${doc.id}: $e');
          continue;
        }
      }

      if (characters.isEmpty) {
        throw Exception('No characters found in Firestore.');
      }

      // Sort by rarity (descending) and then by name
      characters.sort((a, b) {
        int rarityComparison = b.rarity.compareTo(a.rarity);
        if (rarityComparison != 0) {
          return rarityComparison;
        }
        return a.name.compareTo(b.name);
      });

      print('Successfully loaded ${characters.length} characters from Firebase');
      return characters;
    } catch (e) {
      print('Error loading characters from Firebase: $e');
      rethrow;
    }
  }

  // Get character by ID
  static Future<Character> getCharacterById(String characterId) async {
    try {
      final DocumentSnapshot doc = await _firestore
          .collection(_charactersCollection)
          .doc(characterId)
          .get();

      if (!doc.exists) {
        // Prova a cercare per ID nei dati del documento
        final QuerySnapshot querySnapshot = await _firestore
            .collection(_charactersCollection)
            .where('id', isEqualTo: characterId)
            .limit(1)
            .get();

        if (querySnapshot.docs.isEmpty) {
          throw Exception('Character with ID $characterId not found');
        }

        final data = querySnapshot.docs.first.data() as Map<String, dynamic>;
        data['id'] = data['id'] ?? querySnapshot.docs.first.id;
        return Character.fromJson(data);
      }

      final data = doc.data() as Map<String, dynamic>;
      data['id'] = data['id'] ?? doc.id;
      return Character.fromJson(data);
    } catch (e) {
      print('Error getting character by ID from Firebase: $e');
      rethrow;
    }
  }

  // Get character stats
  static Future<List<CharacterStats>> getCharacterStats() async {
    try {
      final QuerySnapshot querySnapshot = await _firestore
          .collection(_charactersCollection)
          .get();

      List<CharacterStats> characterStats = [];

      for (var doc in querySnapshot.docs) {
        try {
          final data = doc.data() as Map<String, dynamic>;

          // Verifica se il documento ha dati di statistiche
          if (data.containsKey('hp') || data.containsKey('atk') ||
              data.containsKey('def') || data.containsKey('spd')) {
            data['id'] = data['id'] ?? doc.id;
            characterStats.add(CharacterStats.fromJson(data));
          }
        } catch (e) {
          print('Error parsing character stats ${doc.id}: $e');
          continue; // Salta questo documento e continua con il prossimo
        }
      }

      // Sort by id for consistent ordering
      characterStats.sort((a, b) => a.id.compareTo(b.id));

      print('Successfully loaded ${characterStats.length} character stats from Firebase');
      return characterStats;
    } catch (e) {
      print('Error loading character stats from Firebase: $e');
      rethrow;
    }
  }

  // Get character stats by ID
  static Future<CharacterStats?> getCharacterStatsById(String characterId) async {
    try {
      final DocumentSnapshot doc = await _firestore
          .collection(_charactersCollection)
          .doc(characterId)
          .get();

      if (!doc.exists) {
        // Prova a cercare per ID nei dati del documento
        final QuerySnapshot querySnapshot = await _firestore
            .collection(_charactersCollection)
            .where('id', isEqualTo: characterId)
            .limit(1)
            .get();

        if (querySnapshot.docs.isEmpty) {
          print('Character stats with ID $characterId not found');
          return null;
        }

        final data = querySnapshot.docs.first.data() as Map<String, dynamic>;

        // Verifica se ha dati di statistiche
        if (!data.containsKey('hp') && !data.containsKey('atk') &&
            !data.containsKey('def') && !data.containsKey('spd')) {
          return null;
        }

        data['id'] = data['id'] ?? querySnapshot.docs.first.id;
        return CharacterStats.fromJson(data);
      }

      final data = doc.data() as Map<String, dynamic>;

      // Verifica se ha dati di statistiche
      if (!data.containsKey('hp') && !data.containsKey('atk') &&
          !data.containsKey('def') && !data.containsKey('spd')) {
        return null;
      }

      data['id'] = data['id'] ?? doc.id;
      return CharacterStats.fromJson(data);
    } catch (e) {
      print('Error getting character stats by ID from Firebase: $e');
      return null;
    }
  }

  // Get character stats by name
  static Future<CharacterStats?> getCharacterStatsByName(String characterName) async {
    try {
      final QuerySnapshot querySnapshot = await _firestore
          .collection(_charactersCollection)
          .where('name', isEqualTo: characterName)
          .limit(1)
          .get();

      if (querySnapshot.docs.isEmpty) {
        print('Character stats with name $characterName not found');
        return null;
      }

      final data = querySnapshot.docs.first.data() as Map<String, dynamic>;

      // Verifica se ha dati di statistiche
      if (!data.containsKey('hp') && !data.containsKey('atk') &&
          !data.containsKey('def') && !data.containsKey('spd')) {
        return null;
      }

      data['id'] = data['id'] ?? querySnapshot.docs.first.id;
      return CharacterStats.fromJson(data);
    } catch (e) {
      print('Error getting character stats by name from Firebase: $e');
      return null;
    }
  }

  // Get character stats map for quick access
  static Future<Map<String, CharacterStats>> getCharacterStatsMap() async {
    try {
      final characterStats = await getCharacterStats();

      final Map<String, CharacterStats> statsMap = {};
      for (var stats in characterStats) {
        statsMap[stats.id] = stats;
      }

      return statsMap;
    } catch (e) {
      print('Error creating character stats map from Firebase: $e');
      rethrow;
    }
  }

  // Check if stats exist for character
  static Future<bool> hasStatsForCharacter(String characterId) async {
    try {
      final stats = await getCharacterStatsById(characterId);
      return stats != null;
    } catch (e) {
      print('Error checking if stats exist for character $characterId: $e');
      return false;
    }
  }

  // Get filtered stats
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
      Query query = _firestore.collection(_charactersCollection);

      // Applica filtri se specificati
      if (minHp != null) {
        query = query.where('hp', isGreaterThanOrEqualTo: minHp.toString());
      }
      if (maxHp != null) {
        query = query.where('hp', isLessThanOrEqualTo: maxHp.toString());
      }

      final QuerySnapshot querySnapshot = await query.get();

      List<CharacterStats> characterStats = [];

      for (var doc in querySnapshot.docs) {
        try {
          final data = doc.data() as Map<String, dynamic>;

          // Verifica se ha dati di statistiche
          if (data.containsKey('hp') || data.containsKey('atk') ||
              data.containsKey('def') || data.containsKey('spd')) {
            data['id'] = data['id'] ?? doc.id;
            final stats = CharacterStats.fromJson(data);

            // Applica filtri aggiuntivi che non possono essere applicati direttamente in Firestore
            bool passesFilter = true;

            if (minAtk != null && stats.atk < minAtk) passesFilter = false;
            if (maxAtk != null && stats.atk > maxAtk) passesFilter = false;
            if (minDef != null && stats.def < minDef) passesFilter = false;
            if (maxDef != null && stats.def > maxDef) passesFilter = false;
            if (minSpd != null && stats.spd < minSpd) passesFilter = false;
            if (maxSpd != null && stats.spd > maxSpd) passesFilter = false;
            if (minUltCost != null && (stats.ultCost == null || stats.ultCost! < minUltCost)) passesFilter = false;
            if (maxUltCost != null && (stats.ultCost == null || stats.ultCost! > maxUltCost)) passesFilter = false;

            if (passesFilter) {
              characterStats.add(stats);
            }
          }
        } catch (e) {
          print('Error parsing filtered character stats ${doc.id}: $e');
          continue;
        }
      }

      return characterStats;
    } catch (e) {
      print('Error filtering character stats from Firebase: $e');
      rethrow;
    }
  }

  // Method to add a character (for admin purposes)
  static Future<void> addCharacter(Map<String, dynamic> characterData) async {
    try {
      await _firestore.collection(_charactersCollection).add(characterData);
      print('Character added successfully');
    } catch (e) {
      print('Error adding character: $e');
      rethrow;
    }
  }

  // Method to update a character
  static Future<void> updateCharacter(String characterId, Map<String, dynamic> characterData) async {
    try {
      await _firestore.collection(_charactersCollection).doc(characterId).update(characterData);
      print('Character updated successfully');
    } catch (e) {
      print('Error updating character: $e');
      rethrow;
    }
  }

  // Method to delete a character
  static Future<void> deleteCharacter(String characterId) async {
    try {
      await _firestore.collection(_charactersCollection).doc(characterId).delete();
      print('Character deleted successfully');
    } catch (e) {
      print('Error deleting character: $e');
      rethrow;
    }
  }

  // Real-time stream for characters
  static Stream<List<Character>> getCharactersStream() {
    return _firestore
        .collection(_charactersCollection)
        .snapshots()
        .map((snapshot) {
      List<Character> characters = [];

      for (var doc in snapshot.docs) {
        try {
          // Esegui il cast esplicito a Map<String, dynamic>
          final data = doc.data();
          data['id'] = data['id'] ?? doc.id;
          characters.add(Character.fromJson(data));
        } catch (e) {
          print('Error parsing character ${doc.id} in stream: $e');
          continue;
        }
      }

      // Sort by rarity (descending) and then by name
      characters.sort((a, b) {
        int rarityComparison = b.rarity.compareTo(a.rarity);
        if (rarityComparison != 0) {
          return rarityComparison;
        }
        return a.name.compareTo(b.name);
      });

      return characters;
    });
  }
}