import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseFavoritesService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  
  // Collection references
  static const String _usersCollection = 'users';
  static const String _favoritesCollection = 'favorites';
  
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
  
  // Get current user favorites
  static Future<Set<String>> getCurrentUserFavorites() async {
    final user = _auth.currentUser;
    
    if (user == null) {
      return <String>{};
    }
    
    return await getUserFavorites(user.uid);
  }
  
  // Real-time stream for current user favorites
  static Stream<Set<String>> get currentUserFavoritesStream {
    final user = _auth.currentUser;
    
    if (user == null) {
      return Stream.value(<String>{});
    }
    
    return getUserFavoritesStream(user.uid);
  }
}