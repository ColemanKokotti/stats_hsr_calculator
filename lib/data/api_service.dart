import '../firebase_service/fireabese_service.dart';
import 'character_model.dart';

class ApiService {
  // Redirect all methods to Firebase service
  static Future<List<Character>> getCharacters() async {
    return await FirebaseService.getCharacters();
  }

  static Future<Character> getCharacterById(String characterId) async {
    return await FirebaseService.getCharacterById(characterId);
  }

  // Stream method for real-time updates
  static Stream<List<Character>> getCharactersStream() {
    return FirebaseService.getCharactersStream();
  }

  // Additional utility methods
  static Future<List<Character>> searchCharacters(String query) async {
    final characters = await getCharacters();
    return characters.where((character) =>
        character.name.toLowerCase().contains(query.toLowerCase())
    ).toList();
  }

  static Future<List<Character>> getCharactersByElement(String element) async {
    final characters = await getCharacters();
    return characters.where((character) =>
    character.element.toLowerCase() == element.toLowerCase()
    ).toList();
  }

  static Future<List<Character>> getCharactersByPath(String path) async {
    final characters = await getCharacters();
    return characters.where((character) =>
    character.pathName.toLowerCase() == path.toLowerCase()
    ).toList();
  }

  static Future<List<Character>> getCharactersByRarity(int rarity) async {
    final characters = await getCharacters();
    return characters.where((character) =>
    character.rarity == rarity
    ).toList();
  }

  static Future<List<Character>> getCharactersByFaction(String faction) async {
    final characters = await getCharacters();
    return characters.where((character) =>
        character.faction.toLowerCase().contains(faction.toLowerCase())
    ).toList();
  }

  static Future<List<Character>> getFavoriteCharacters() async {
    final characters = await getCharacters();
    return characters.where((character) => character.isFavorite).toList();
  }
}