import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'character_model.dart';

class ApiService {
  static Future<List<Character>> getCharacters() async {
    try {
      // Load the JSON file from assets
      final String response = await rootBundle.loadString('assets/json/hsr_characters.json');
      final data = json.decode(response);

      List<Character> characters = [];

      // Handle different JSON structures
      if (data is List) {
        // If the JSON is directly an array of characters
        for (var item in data) {
          if (item is Map<String, dynamic>) {
            try {
              characters.add(Character.fromJson(item));
            } catch (e) {
              print('Error parsing character: $e');
              print('Character data: $item');
            }
          }
        }
      } else if (data is Map<String, dynamic> && data.containsKey('characters')) {
        // If the JSON has a "characters" key that holds the list
        for (var item in data['characters']) {
          if (item is Map<String, dynamic>) {
            try {
              characters.add(Character.fromJson(item));
            } catch (e) {
              print('Error parsing character: $e');
              print('Character data: $item');
            }
          }
        }
      } else {
        throw Exception('Invalid JSON format: Expected array or object with "characters" key.');
      }

      if (characters.isEmpty) {
        throw Exception('No characters found in JSON file.');
      }

      // Sort by rarity (descending) and then by name
      characters.sort((a, b) {
        int rarityComparison = b.rarity.compareTo(a.rarity);
        if (rarityComparison != 0) {
          return rarityComparison;
        }
        return a.name.compareTo(b.name);
      });

      print('Successfully loaded ${characters.length} characters');
      return characters;
    } catch (e) {
      print('Error loading or parsing characters from local JSON: $e');
      rethrow;
    }
  }

  static Future<Character> getCharacterById(String characterId) async {
    try {
      // Get all characters first
      final characters = await getCharacters();

      // Find the character with the matching ID
      final character = characters.firstWhere(
            (char) => char.id == characterId,
        orElse: () => throw Exception('Character with ID $characterId not found'),
      );

      return character;
    } catch (e) {
      print('Error getting character by ID: $e');
      rethrow;
    }
  }
}