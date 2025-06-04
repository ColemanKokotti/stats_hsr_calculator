import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../data/character_model.dart';


class FirebaseUploadService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static const String _collectionName = 'characters';

  /// Carica tutti i personaggi dal JSON locale a Firebase
  static Future<void> uploadCharactersToFirebase() async {
    try {
      if (kDebugMode) {
        print('🚀 Inizio caricamento personaggi su Firebase...');
      }

      // Carica e parsa il JSON locale
      final List<Character> characters = await _loadCharactersFromJson();

      if (characters.isEmpty) {
        throw Exception('Nessun personaggio trovato nel JSON');
      }

      if (kDebugMode) {
        print('📄 Trovati ${characters.length} personaggi nel JSON');
      }

      // Carica ogni personaggio su Firebase
      int uploadedCount = 0;
      int failedCount = 0;

      for (Character character in characters) {
        try {
          await _uploadSingleCharacter(character);
          uploadedCount++;

          if (kDebugMode) {
            print('✅ Caricato: ${character.name} (${character.id})');
          }
        } catch (e) {
          failedCount++;
          if (kDebugMode) {
            print('❌ Errore caricando ${character.name}: $e');
          }
        }
      }

      if (kDebugMode) {
        print('🎉 Caricamento completato!');
        print('✅ Caricati con successo: $uploadedCount');
        print('❌ Falliti: $failedCount');
      }

    } catch (e) {
      if (kDebugMode) {
        print('💥 Errore durante il caricamento su Firebase: $e');
      }
      rethrow;
    }
  }

  /// Carica un singolo personaggio su Firebase
  static Future<void> _uploadSingleCharacter(Character character) async {
    try {
      await _firestore
          .collection(_collectionName)
          .doc(character.id)
          .set(character.toJson(), SetOptions(merge: true));
    } catch (e) {
      throw Exception('Errore caricando ${character.name}: $e');
    }
  }

  /// Carica i personaggi dal JSON locale
  static Future<List<Character>> _loadCharactersFromJson() async {
    try {
      final String response = await rootBundle.loadString('assets/json/hsr_characters.json');
      final data = json.decode(response);

      List<Character> characters = [];

      if (data is Map<String, dynamic> && data.containsKey('characters')) {
        for (var item in data['characters']) {
          if (item is Map<String, dynamic>) {
            try {
              characters.add(Character.fromJson(item));
            } catch (e) {
              if (kDebugMode) {
                print('⚠️ Errore parsing personaggio: $e');
                print('📋 Dati personaggio: $item');
              }
            }
          }
        }
      } else if (data is List) {
        for (var item in data) {
          if (item is Map<String, dynamic>) {
            try {
              characters.add(Character.fromJson(item));
            } catch (e) {
              if (kDebugMode) {
                print('⚠️ Errore parsing personaggio: $e');
                print('📋 Dati personaggio: $item');
              }
            }
          }
        }
      } else {
        throw Exception('Formato JSON non valido');
      }

      return characters;
    } catch (e) {
      throw Exception('Errore caricando JSON locale: $e');
    }
  }

  /// Verifica se un personaggio esiste già su Firebase
  static Future<bool> characterExists(String characterId) async {
    try {
      final doc = await _firestore
          .collection(_collectionName)
          .doc(characterId)
          .get();
      return doc.exists;
    } catch (e) {
      if (kDebugMode) {
        print('Errore verificando esistenza personaggio $characterId: $e');
      }
      return false;
    }
  }

  /// Carica solo i personaggi che non esistono già su Firebase
  static Future<void> uploadNewCharactersOnly() async {
    try {
      if (kDebugMode) {
        print('🔍 Caricamento solo nuovi personaggi...');
      }

      final List<Character> characters = await _loadCharactersFromJson();

      int newCount = 0;
      int existingCount = 0;
      int failedCount = 0;

      for (Character character in characters) {
        try {
          final exists = await characterExists(character.id);

          if (!exists) {
            await _uploadSingleCharacter(character);
            newCount++;
            if (kDebugMode) {
              print('✅ Nuovo personaggio caricato: ${character.name}');
            }
          } else {
            existingCount++;
            if (kDebugMode) {
              print('⏭️ Personaggio già esistente: ${character.name}');
            }
          }
        } catch (e) {
          failedCount++;
          if (kDebugMode) {
            print('❌ Errore con ${character.name}: $e');
          }
        }
      }

      if (kDebugMode) {
        print('📊 Risultati:');
        print('🆕 Nuovi personaggi caricati: $newCount');
        print('📋 Personaggi già esistenti: $existingCount');
        print('❌ Errori: $failedCount');
      }

    } catch (e) {
      if (kDebugMode) {
        print('💥 Errore durante il caricamento selettivo: $e');
      }
      rethrow;
    }
  }

  /// Elimina tutti i personaggi da Firebase (usa con cautela!)
  static Future<void> deleteAllCharacters() async {
    try {
      if (kDebugMode) {
        print('🗑️ ATTENZIONE: Eliminazione di tutti i personaggi da Firebase...');
      }

      final batch = _firestore.batch();
      final snapshot = await _firestore.collection(_collectionName).get();

      for (var doc in snapshot.docs) {
        batch.delete(doc.reference);
      }

      await batch.commit();

      if (kDebugMode) {
        print('🗑️ Eliminati ${snapshot.docs.length} personaggi da Firebase');
      }

    } catch (e) {
      if (kDebugMode) {
        print('💥 Errore durante l\'eliminazione: $e');
      }
      rethrow;
    }
  }

  /// Ottieni tutti i personaggi da Firebase
  static Future<List<Character>> getCharactersFromFirebase() async {
    try {
      final snapshot = await _firestore
          .collection(_collectionName)
          .orderBy('rarity', descending: true)
          .orderBy('name')
          .get();

      return snapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id; // Assicurati che l'ID sia incluso
        return Character.fromJson(data);
      }).toList();

    } catch (e) {
      if (kDebugMode) {
        print('💥 Errore caricando personaggi da Firebase: $e');
      }
      rethrow;
    }
  }

  /// Conta i personaggi su Firebase
  static Future<int> getCharacterCount() async {
    try {
      final snapshot = await _firestore.collection(_collectionName).count().get();
      return snapshot.count ?? 0;
    } catch (e) {
      if (kDebugMode) {
        print('💥 Errore contando personaggi: $e');
      }
      return 0;
    }
  }

  /// Aggiorna un singolo personaggio su Firebase
  static Future<void> updateCharacter(Character character) async {
    try {
      await _firestore
          .collection(_collectionName)
          .doc(character.id)
          .update(character.toJson());

      if (kDebugMode) {
        print('✅ Personaggio aggiornato: ${character.name}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Errore aggiornando ${character.name}: $e');
      }
      rethrow;
    }
  }
}