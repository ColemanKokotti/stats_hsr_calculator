import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../data/character_model.dart';

class FirebaseMyCharactersService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  
  // Collection references
  static const String _usersCollection = 'users';
  static const String _myCharactersCollection = 'mycharacters';
  
  // Get user's selected characters
  static Future<List<String>> getUserMyCharacters(String userId) async {
    try {
      final DocumentSnapshot doc = await _firestore
          .collection(_usersCollection)
          .doc(userId)
          .collection(_myCharactersCollection)
          .doc('selected')
          .get();

      if (!doc.exists) {
        return [];
      }

      final data = doc.data() as Map<String, dynamic>;
      final List<dynamic> charactersList = data['characterIds'] ?? [];
      
      return charactersList.map((id) => id.toString()).toList();
    } catch (e) {
      print('Error getting user my characters from Firebase: $e');
      return [];
    }
  }

  // Save user's selected characters
  static Future<void> saveMyCharacters(String userId, List<String> characterIds) async {
    try {
      final DocumentReference docRef = _firestore
          .collection(_usersCollection)
          .doc(userId)
          .collection(_myCharactersCollection)
          .doc('selected');
          
      await docRef.set({
        'characterIds': characterIds,
        'updatedAt': FieldValue.serverTimestamp(),
      });
      
      print('My characters saved successfully');
    } catch (e) {
      print('Error saving my characters: $e');
      rethrow;
    }
  }

  // Add a character to my characters
  static Future<void> addToMyCharacters(String userId, String characterId) async {
    try {
      final DocumentReference docRef = _firestore
          .collection(_usersCollection)
          .doc(userId)
          .collection(_myCharactersCollection)
          .doc('selected');
          
      // Get current my characters
      final DocumentSnapshot doc = await docRef.get();
      
      if (!doc.exists) {
        // Create new document if it doesn't exist
        await docRef.set({
          'characterIds': [characterId],
          'updatedAt': FieldValue.serverTimestamp(),
        });
      } else {
        // Update existing document
        await docRef.update({
          'characterIds': FieldValue.arrayUnion([characterId]),
          'updatedAt': FieldValue.serverTimestamp(),
        });
      }
      
      print('Character added to my characters successfully');
    } catch (e) {
      print('Error adding character to my characters: $e');
      rethrow;
    }
  }

  // Remove a character from my characters
  static Future<void> removeFromMyCharacters(String userId, String characterId) async {
    try {
      final DocumentReference docRef = _firestore
          .collection(_usersCollection)
          .doc(userId)
          .collection(_myCharactersCollection)
          .doc('selected');
          
      // Get current my characters
      final DocumentSnapshot doc = await docRef.get();
      
      if (doc.exists) {
        await docRef.update({
          'characterIds': FieldValue.arrayRemove([characterId]),
          'updatedAt': FieldValue.serverTimestamp(),
        });
      }
      
      print('Character removed from my characters successfully');
    } catch (e) {
      print('Error removing character from my characters: $e');
      rethrow;
    }
  }

  // Check if user has visited my characters screen before
  static Future<bool> hasVisitedMyCharactersScreen(String userId) async {
    try {
      final DocumentSnapshot doc = await _firestore
          .collection(_usersCollection)
          .doc(userId)
          .collection(_myCharactersCollection)
          .doc('metadata')
          .get();

      if (!doc.exists) {
        return false;
      }

      final data = doc.data() as Map<String, dynamic>;
      return data['hasVisited'] == true;
    } catch (e) {
      print('Error checking if user has visited my characters screen: $e');
      return false;
    }
  }

  // Mark my characters screen as visited
  static Future<void> markMyCharactersScreenAsVisited(String userId) async {
    try {
      final DocumentReference docRef = _firestore
          .collection(_usersCollection)
          .doc(userId)
          .collection(_myCharactersCollection)
          .doc('metadata');
          
      await docRef.set({
        'hasVisited': true,
        'updatedAt': FieldValue.serverTimestamp(),
      });
      
      print('My characters screen marked as visited');
    } catch (e) {
      print('Error marking my characters screen as visited: $e');
      rethrow;
    }
  }

  // Get current user's my characters
  static Future<List<String>> getCurrentUserMyCharacters() async {
    final user = _auth.currentUser;
    
    if (user == null) {
      return [];
    }
    
    return await getUserMyCharacters(user.uid);
  }

  // Get current user's my characters as Character objects
  static Future<List<Character>> getCurrentUserMyCharactersAsObjects() async {
    final user = _auth.currentUser;
    
    if (user == null) {
      return [];
    }
    
    final characterIds = await getUserMyCharacters(user.uid);
    List<Character> characters = [];
    
    for (String id in characterIds) {
      try {
        Character character = await getCharacterById(id);
        characters.add(character);
      } catch (e) {
        print('Error getting character $id: $e');
      }
    }
    
    return characters;
  }

  // Helper method to get a character by ID
  static Future<Character> getCharacterById(String characterId) async {
    try {
      final DocumentSnapshot doc = await _firestore
          .collection('characters')
          .doc(characterId)
          .get();

      if (!doc.exists) {
        // Try to find by ID in document data
        final QuerySnapshot querySnapshot = await _firestore
            .collection('characters')
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

  // Real-time stream for current user's my characters
  static Stream<List<String>> get currentUserMyCharactersStream {
    final user = _auth.currentUser;
    
    if (user == null) {
      return Stream.value([]);
    }
    
    return _firestore
        .collection(_usersCollection)
        .doc(user.uid)
        .collection(_myCharactersCollection)
        .doc('selected')
        .snapshots()
        .map((snapshot) {
      if (!snapshot.exists) {
        return [];
      }
      
      final data = snapshot.data() as Map<String, dynamic>;
      final List<dynamic> charactersList = data['characterIds'] ?? [];
      
      return charactersList.map((id) => id.toString()).toList();
    });
  }

  // Check if current user has visited my characters screen
  static Future<bool> hasCurrentUserVisitedMyCharactersScreen() async {
    final user = _auth.currentUser;
    
    if (user == null) {
      return false;
    }
    
    return await hasVisitedMyCharactersScreen(user.uid);
  }

  // Mark current user's my characters screen as visited
  static Future<void> markCurrentUserMyCharactersScreenAsVisited() async {
    final user = _auth.currentUser;
    
    if (user == null) {
      return;
    }
    
    await markMyCharactersScreenAsVisited(user.uid);
  }
}