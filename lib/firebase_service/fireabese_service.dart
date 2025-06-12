import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../data/character_model.dart';
import '../data/character_stats.dart';

class FirebaseService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  // Collection references
  static const String _charactersCollection = 'characters';
  static const String _usersCollection = 'users';
  static const String _favoritesCollection = 'favorites';

  // AUTH METHODS

  // Get current user
  static User? get currentUser => _auth.currentUser;
  
  // Sign in with email and password
  static Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      print('Error signing in with email and password: $e');
      rethrow;
    }
  }
  
  // Register with email and password
  static Future<UserCredential> registerWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      // Create user document in Firestore
      await _createUserDocument(userCredential.user!);
      
      return userCredential;
    } catch (e) {
      print('Error registering with email and password: $e');
      rethrow;
    }
  }
  
  // Create user document in Firestore
  static Future<void> _createUserDocument(User user) async {
    try {
      // Check if user document already exists
      final docRef = _firestore.collection(_usersCollection).doc(user.uid);
      final doc = await docRef.get();
      
      if (!doc.exists) {
        // Create new user document with explicit empty strings for username and profilePicture
        // This ensures these fields exist in the document
        await docRef.set({
          'uid': user.uid,
          'email': user.email,
          'username': '',  // Initialize as empty string instead of null
          'profilePicture': '',  // Initialize as empty string instead of null
          'createdAt': FieldValue.serverTimestamp(),
          'updatedAt': FieldValue.serverTimestamp(),
        });
        
        print('User document created successfully with initialized fields');
      }
    } catch (e) {
      print('Error creating user document: $e');
      rethrow;
    }
  }
  
  // Update user profile
  static Future<void> updateUserProfile({
    required String username,
    required String profilePicture,
  }) async {
    try {
      final user = _auth.currentUser;
      
      if (user == null) {
        throw Exception('No user is currently signed in');
      }
      
      print('Updating profile for user ${user.uid}');
      print('Username: $username');
      print('Profile Picture: $profilePicture');
      
      // Check if user document exists
      final docRef = _firestore.collection(_usersCollection).doc(user.uid);
      final doc = await docRef.get();
      
      if (!doc.exists) {
        // Create new user document with all required fields
        final userData = {
          'uid': user.uid,
          'email': user.email,
          'username': username,
          'profilePicture': profilePicture,
          'createdAt': FieldValue.serverTimestamp(),
          'updatedAt': FieldValue.serverTimestamp(),
        };
        
        print('Creating new user document with data: $userData');
        await docRef.set(userData);
        print('User document created with profile data');
      } else {
        // Use set with merge to ensure fields are created if they don't exist
        final updateData = {
          'username': username,
          'profilePicture': profilePicture,
          'updatedAt': FieldValue.serverTimestamp(),
        };
        
        print('Updating existing user document with data: $updateData');
        await docRef.set(updateData, SetOptions(merge: true));
        
        // Verify the update
        final updatedDoc = await docRef.get();
        final updatedData = updatedDoc.data() as Map<String, dynamic>;
        print('Updated document data: $updatedData');
        
        print('User profile updated with merge option');
      }
      
      print('User profile updated successfully');
    } catch (e) {
      print('Error updating user profile: $e');
      rethrow;
    }
  }
  
  // Get user profile
  static Future<Map<String, dynamic>?> getUserProfile(String userId) async {
    try {
      final doc = await _firestore.collection(_usersCollection).doc(userId).get();
      
      if (!doc.exists) {
        return null;
      }
      
      return doc.data();
    } catch (e) {
      print('Error getting user profile: $e');
      rethrow;
    }
  }
  
  // Get current user profile
  static Future<Map<String, dynamic>?> getCurrentUserProfile() async {
    try {
      final user = _auth.currentUser;
      
      if (user == null) {
        return null;
      }
      
      return await getUserProfile(user.uid);
    } catch (e) {
      print('Error getting current user profile: $e');
      rethrow;
    }
  }
  
  // Check if user has completed profile setup
  static Future<bool> hasCompletedProfileSetup() async {
    try {
      final user = _auth.currentUser;
      
      if (user == null) {
        return false;
      }
      
      final profile = await getUserProfile(user.uid);
      
      if (profile == null) {
        return false;
      }
      
      // Check if username and profilePicture exist and are not empty strings
      final username = profile['username'] as String?;
      final profilePicture = profile['profilePicture'] as String?;
      
      return username != null && username.isNotEmpty && 
             profilePicture != null && profilePicture.isNotEmpty;
    } catch (e) {
      print('Error checking if user has completed profile setup: $e');
      return false;
    }
  }
  
  // Sign out
  static Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print('Error signing out: $e');
      rethrow;
    }
  }
  
  // Sign in anonymously
  static Future<UserCredential> signInAnonymously() async {
    try {
      return await _auth.signInAnonymously();
    } catch (e) {
      print('Error signing in anonymously: $e');
      rethrow;
    }
  }
  
  // Stream of auth state changes
  static Stream<User?> get authStateChanges => _auth.authStateChanges();
  
  // Stream of user profile changes
  static Stream<DocumentSnapshot> userProfileStream(String userId) {
    print('Subscribing to profile stream for user $userId');
    return _firestore.collection(_usersCollection).doc(userId).snapshots()
      .map((snapshot) {
        print('Received profile update from Firestore: ${snapshot.data()}');
        return snapshot;
      });
  }
  
  // Stream of current user profile changes
  static Stream<DocumentSnapshot?> get currentUserProfileStream {
    final user = _auth.currentUser;
    
    if (user == null) {
      print('No current user, returning null stream');
      return Stream.value(null);
    }
    
    print('Subscribing to current user profile stream for user ${user.uid}');
    return _firestore.collection(_usersCollection).doc(user.uid).snapshots()
      .map((snapshot) {
        print('Received current user profile update from Firestore: ${snapshot.data()}');
        return snapshot;
      });
  }

  // FAVORITES METHODS

  // Get user favorites
  static Future<Set<String>> getUserFavorites(String userId) async {
    try {
      final DocumentSnapshot doc = await _firestore
          .collection(_usersCollection)
          .doc(userId)
          .collection(_favoritesCollection)
          .doc('characters')
          .get();

      if (!doc.exists) {
        return <String>{};
      }

      final data = doc.data() as Map<String, dynamic>;
      final List<dynamic> favoritesList = data['characterIds'] ?? [];
      
      return favoritesList.map((id) => id.toString()).toSet();
    } catch (e) {
      print('Error getting user favorites from Firebase: $e');
      return <String>{};
    }
  }

  // Add character to favorites
  static Future<void> addToFavorites(String userId, String characterId) async {
    try {
      final DocumentReference docRef = _firestore
          .collection(_usersCollection)
          .doc(userId)
          .collection(_favoritesCollection)
          .doc('characters');
          
      // Get current favorites
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
      
      print('Character added to favorites successfully');
    } catch (e) {
      print('Error adding character to favorites: $e');
      rethrow;
    }
  }

  // Remove character from favorites
  static Future<void> removeFromFavorites(String userId, String characterId) async {
    try {
      final DocumentReference docRef = _firestore
          .collection(_usersCollection)
          .doc(userId)
          .collection(_favoritesCollection)
          .doc('characters');
          
      // Get current favorites
      final DocumentSnapshot doc = await docRef.get();
      
      if (doc.exists) {
        await docRef.update({
          'characterIds': FieldValue.arrayRemove([characterId]),
          'updatedAt': FieldValue.serverTimestamp(),
        });
      }
      
      print('Character removed from favorites successfully');
    } catch (e) {
      print('Error removing character from favorites: $e');
      rethrow;
    }
  }

  // Toggle favorite status
  static Future<bool> toggleFavorite(String userId, String characterId) async {
    try {
      final DocumentReference docRef = _firestore
          .collection(_usersCollection)
          .doc(userId)
          .collection(_favoritesCollection)
          .doc('characters');
          
      // Get current favorites
      final DocumentSnapshot doc = await docRef.get();
      
      if (!doc.exists) {
        // Create new document with this character as favorite
        await docRef.set({
          'characterIds': [characterId],
          'updatedAt': FieldValue.serverTimestamp(),
        });
        return true; // Added to favorites
      } else {
        // Check if character is already in favorites
        final data = doc.data() as Map<String, dynamic>;
        final List<dynamic> favoritesList = data['characterIds'] ?? [];
        
        if (favoritesList.contains(characterId)) {
          // Remove from favorites
          await docRef.update({
            'characterIds': FieldValue.arrayRemove([characterId]),
            'updatedAt': FieldValue.serverTimestamp(),
          });
          return false; // Removed from favorites
        } else {
          // Add to favorites
          await docRef.update({
            'characterIds': FieldValue.arrayUnion([characterId]),
            'updatedAt': FieldValue.serverTimestamp(),
          });
          return true; // Added to favorites
        }
      }
    } catch (e) {
      print('Error toggling favorite status: $e');
      rethrow;
    }
  }

  // Real-time stream for user favorites
  static Stream<Set<String>> getUserFavoritesStream(String userId) {
    return _firestore
        .collection(_usersCollection)
        .doc(userId)
        .collection(_favoritesCollection)
        .doc('characters')
        .snapshots()
        .map((snapshot) {
      if (!snapshot.exists) {
        return <String>{};
      }
      
      final data = snapshot.data() as Map<String, dynamic>;
      final List<dynamic> favoritesList = data['characterIds'] ?? [];
      
      return favoritesList.map((id) => id.toString()).toSet();
    });
  }

  // CHARACTERS METHODS

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