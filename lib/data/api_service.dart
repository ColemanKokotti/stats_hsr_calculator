import 'dart:convert';
import 'package:http/http.dart' as http;
import 'character_model.dart';


class ApiService {
  static const String baseUrl = 'https://api.hakush.in/hsr';
  static const Duration timeout = Duration(seconds: 10);

  static Future<List<Character>> getCharacters() async {
    try {
      final response = await http
          .get(
        Uri.parse('$baseUrl/character'),
        headers: {'Content-Type': 'application/json'},
      )
          .timeout(timeout);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // L'API restituisce un oggetto con chiavi che sono gli ID dei personaggi
        if (data is Map<String, dynamic>) {
          List<Character> characters = [];

          data.forEach((key, value) {
            if (value is Map<String, dynamic>) {
              try {
                // Aggiungiamo l'id dal key se non è presente nei dati
                value['id'] = key;
                characters.add(Character.fromJson(value));
              } catch (e) {
                print('Error parsing character $key: $e');
              }
            }
          });

          // Ordiniamo per rarità (decrescente) e poi per nome
          characters.sort((a, b) {
            int rarityComparison = b.rarity.compareTo(a.rarity);
            if (rarityComparison != 0) return rarityComparison;
            return a.name.compareTo(b.name);
          });

          return characters;
        }
      }

      throw ApiException('Failed to load characters: ${response.statusCode}');
    } on http.ClientException catch (e) {
      throw ApiException('Network error: ${e.message}');
    } catch (e) {
      throw ApiException('Unexpected error: $e');
    }
  }

  static Future<Character> getCharacterById(String id) async {
    try {
      final response = await http
          .get(
        Uri.parse('$baseUrl/character/$id'),
        headers: {'Content-Type': 'application/json'},
      )
          .timeout(timeout);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        data['id'] = id;
        return Character.fromJson(data);
      }

      throw ApiException('Failed to load character: ${response.statusCode}');
    } on http.ClientException catch (e) {
      throw ApiException('Network error: ${e.message}');
    } catch (e) {
      throw ApiException('Unexpected error: $e');
    }
  }
}

class ApiException implements Exception {
  final String message;

  const ApiException(this.message);

  @override
  String toString() => 'ApiException: $message';
}