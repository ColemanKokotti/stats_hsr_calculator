import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:cloud_firestore/cloud_firestore.dart';

class JsonToFirebaseMigrator {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static const String _collectionName = 'characters';

  /// Migra i dati dai file JSON a Firebase
  static Future<void> migrateJsonToFirebase() async {
    try {
      print('Starting migration from JSON to Firebase...');

      // Carica il file JSON dei personaggi
      final String charactersResponse = await rootBundle.loadString('assets/json/hsr_characters.json');
      final charactersData = json.decode(charactersResponse);

      // Carica il file JSON delle statistiche (se esiste)
      Map<String, dynamic>? statsData;
      try {
        final String statsResponse = await rootBundle.loadString('assets/json/hsr_characters_stats.json');
        statsData = json.decode(statsResponse);
      } catch (e) {
        print('Stats file not found or error reading it: $e');
      }

      List<Map<String, dynamic>> characters = [];
      List<Map<String, dynamic>> stats = [];

      // Processa i dati dei personaggi
      if (charactersData is Map<String, dynamic> && charactersData.containsKey('characters')) {
        characters = List<Map<String, dynamic>>.from(charactersData['characters']);
      } else if (charactersData is List) {
        characters = List<Map<String, dynamic>>.from(charactersData);
      }

      // Processa i dati delle statistiche
      if (statsData != null) {
        if (statsData.containsKey('characters')) {
          stats = List<Map<String, dynamic>>.from(statsData['characters']);
        } else if (statsData is List) {
          stats = List<Map<String, dynamic>>.from(statsData['characters']);
        }
      }

      // Crea una mappa delle statistiche per ID per facile accesso
      Map<String, Map<String, dynamic>> statsMap = {};
      for (var stat in stats) {
        String id = stat['id']?.toString() ?? '';
        if (id.isNotEmpty) {
          statsMap[id] = stat;
        }
      }

      print('Found ${characters.length} characters and ${stats.length} stat entries');

      // Batch write per efficienza
      WriteBatch batch = _firestore.batch();
      int batchCount = 0;
      const int batchLimit = 500; // Firestore batch limit

      for (var character in characters) {
        String characterId = character['id']?.toString() ?? '';

        if (characterId.isEmpty) {
          print('Skipping character with no ID: ${character['name']}');
          continue;
        }

        // Combina i dati del personaggio con le sue statistiche
        Map<String, dynamic> combinedData = Map<String, dynamic>.from(character);

        if (statsMap.containsKey(characterId)) {
          final characterStats = statsMap[characterId]!;
          // Aggiungi i dati delle statistiche ai dati del personaggio
          combinedData.addAll({
            'hp': characterStats['hp'],
            'atk': characterStats['atk'],
            'def': characterStats['def'],
            'spd': characterStats['spd'],
            'crit_rate': characterStats['crit_rate'],
            'crit_dmg': characterStats['crit_dmg'],
            'ult_cost': characterStats['ult_cost'],
          });
        }

        // Aggiungi al batch
        DocumentReference docRef = _firestore.collection(_collectionName).doc(characterId);
        batch.set(docRef, combinedData);
        batchCount++;

        // Commit batch se raggiungiamo il limite
        if (batchCount >= batchLimit) {
          await batch.commit();
          batch = _firestore.batch();
          batchCount = 0;
          print('Committed batch of $batchLimit documents');
        }
      }

      // Commit l'ultimo batch se contiene documenti
      if (batchCount > 0) {
        await batch.commit();
        print('Committed final batch of $batchCount documents');
      }

      print('Migration completed successfully!');

    } catch (e) {
      print('Error during migration: $e');
      rethrow;
    }
  }

  /// Verifica i dati in Firebase dopo la migrazione
  static Future<void> verifyMigration() async {
    try {
      final QuerySnapshot snapshot = await _firestore.collection(_collectionName).get();
      print('Found ${snapshot.docs.length} documents in Firebase');

      // Mostra alcuni esempi
      for (int i = 0; i < 3 && i < snapshot.docs.length; i++) {
        final doc = snapshot.docs[i];
        print('Sample document ${i + 1}: ${doc.id} - ${doc.data()}');
      }

    } catch (e) {
      print('Error verifying migration: $e');
    }
  }

  /// Pulisce la collection (usa con attenzione!)
  static Future<void> clearCollection() async {
    try {
      print('WARNING: This will delete all documents in the collection!');

      final QuerySnapshot snapshot = await _firestore.collection(_collectionName).get();

      WriteBatch batch = _firestore.batch();
      for (var doc in snapshot.docs) {
        batch.delete(doc.reference);
      }

      await batch.commit();
      print('Collection cleared successfully');

    } catch (e) {
      print('Error clearing collection: $e');
      rethrow;
    }
  }

  /// Aggiunge un singolo personaggio per test
  static Future<void> addTestCharacter() async {
    try {
      Map<String, dynamic> testCharacter = {
        'id': 'test001',
        'name': 'Test Character',
        'rarity': 5,
        'element': 'Fire',
        'path': 'Destruction',
        'faction': 'Test Faction',
        'icon': 'https://example.com/icon.png',
        'portrait': 'https://example.com/portrait.png',
        'hp': '1500',
        'atk': '800',
        'def': '600',
        'spd': '105',
        'crit_rate': '75.0',
        'crit_dmg': '150.0',
        'ult_cost': '130',
      };

      await _firestore.collection(_collectionName).doc('test001').set(testCharacter);
      print('Test character added successfully');

    } catch (e) {
      print('Error adding test character: $e');
      rethrow;
    }
  }
}