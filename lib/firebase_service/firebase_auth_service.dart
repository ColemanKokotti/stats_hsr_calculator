import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  // Collection references
  static const String _usersCollection = 'users';
  
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
        // Create new user document
        await docRef.set({
          'uid': user.uid,
          'email': user.email,
          'username': null,
          'profilePicture': null,
          'createdAt': FieldValue.serverTimestamp(),
          'updatedAt': FieldValue.serverTimestamp(),
        });
        
        print('User document created successfully');
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
      
      // Update user document in Firestore
      await _firestore.collection(_usersCollection).doc(user.uid).update({
        'username': username,
        'profilePicture': profilePicture,
        'updatedAt': FieldValue.serverTimestamp(),
      });
      
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
      
      return profile['username'] != null && profile['profilePicture'] != null;
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
    return _firestore.collection(_usersCollection).doc(userId).snapshots();
  }
  
  // Stream of current user profile changes
  static Stream<DocumentSnapshot?> get currentUserProfileStream {
    final user = _auth.currentUser;
    
    if (user == null) {
      return Stream.value(null);
    }
    
    return _firestore.collection(_usersCollection).doc(user.uid).snapshots();
  }
}