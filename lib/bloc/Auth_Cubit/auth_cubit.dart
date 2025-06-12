// lib/bloc/Auth_Cubit/auth_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuth _firebaseAuth;

  AuthCubit({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        super(AuthInitial()) {
    // Use Future.microtask to avoid blocking the UI thread
    Future.microtask(() => _checkAuthStatus());
  }

  Future<void> _checkAuthStatus() async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user != null) {
        // Add a short delay to ensure Firebase has time to initialize properly
        await Future.delayed(const Duration(milliseconds: 300));
        emit(AuthAuthenticated(user: user));
      } else {
        emit(AuthUnauthenticated());
      }
    } catch (e) {
      print('Error in _checkAuthStatus: $e');
      emit(AuthUnauthenticated());
    }
  }

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());
    try {
      // Validate inputs before attempting to sign in
      if (email.isEmpty || password.isEmpty) {
        emit(const AuthError('Email and password cannot be empty'));
        return;
      }
      
      // Trim whitespace from email
      final trimmedEmail = email.trim();
      
      // Add a delay to ensure Firebase has time to process
      await Future.delayed(const Duration(milliseconds: 300));
      
      // Sign in with Firebase
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: trimmedEmail,
        password: password,
      );

      // Check if user is not null
      if (userCredential.user != null) {
        // Add a short delay to ensure Firebase has time to process
        await Future.delayed(const Duration(milliseconds: 500));
        emit(AuthAuthenticated(user: userCredential.user!));
      } else {
        emit(const AuthError('Login failed'));
      }
    } on FirebaseAuthException catch (e) {
      print('FirebaseAuthException during login: ${e.code} - ${e.message}');
      emit(AuthError(_getErrorMessage(e)));
    } catch (e) {
      // More detailed error message
      print('Login error: ${e.toString()}');
      emit(AuthError('Login failed: ${e.toString()}'));
    }
  }

  Future<void> registerWithEmailAndPassword({
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    if (password != confirmPassword) {
      emit(const AuthError('Passwords do not match'));
      return;
    }

    if (email.isEmpty) {
      emit(const AuthError('Email cannot be empty'));
      return;
    }

    if (password.isEmpty) {
      emit(const AuthError('Password cannot be empty'));
      return;
    }

    emit(AuthLoading());
    try {
      // Trim whitespace from email
      final trimmedEmail = email.trim();
      
      // Add a delay to ensure Firebase has time to process
      await Future.delayed(const Duration(milliseconds: 300));
      
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: trimmedEmail,
        password: password,
      );

      if (userCredential.user != null) {
        print('Registration successful - UID: ${userCredential.user!.uid}');
        
        // Show registration success message
        emit(const AuthRegistrationSuccess('Registration successful! You are now logged in.'));
        
        // After a short delay, emit AuthAuthenticated to trigger navigation
        await Future.delayed(const Duration(milliseconds: 1000));
        emit(AuthAuthenticated(user: userCredential.user!));
      } else {
        emit(const AuthError('Registration failed'));
      }
    } on FirebaseAuthException catch (e) {
      print('FirebaseAuthException during registration: ${e.code} - ${e.message}');
      emit(AuthError(_getErrorMessage(e)));
    } catch (e) {
      print('Error during registration: ${e.toString()}');
      emit(AuthError('An unexpected error occurred: ${e.toString()}'));
    }
  }

  Future<void> signInAsGuest() async {
    emit(AuthLoading());
    try {
      print('Attempting anonymous sign in...');
      
      // Ensure anonymous auth is enabled in Firebase console
      final userCredential = await _firebaseAuth.signInAnonymously();

      if (userCredential.user != null) {
        print('Anonymous sign in successful - UID: ${userCredential.user!.uid}');
        
        // Add a short delay to ensure Firebase has time to process
        await Future.delayed(const Duration(milliseconds: 500));
        
        // Emit authenticated state with guest flag
        emit(AuthAuthenticated(user: userCredential.user!, isGuest: true));
      } else {
        print('Anonymous sign in failed - user is null');
        emit(const AuthError('Guest login failed. Please try again.'));
      }
    } on FirebaseAuthException catch (e) {
      print('FirebaseAuthException during anonymous sign in: ${e.code} - ${e.message}');
      
      // Special handling for common anonymous auth errors
      if (e.code == 'operation-not-allowed') {
        emit(const AuthError('Guest login is not enabled. Please sign in with email and password.'));
      } else {
        emit(AuthError(_getErrorMessage(e)));
      }
    } catch (e) {
      print('Error during anonymous sign in: ${e.toString()}');
      emit(AuthError('Guest login failed: ${e.toString()}'));
    }
  }

  Future<void> signOut({bool deleteGuestAccount = false}) async {
    emit(AuthLoading());
    try {
      final user = _firebaseAuth.currentUser;
      
      // Check if we need to delete a guest account
      if (deleteGuestAccount && user != null && user.isAnonymous) {
        print('Deleting guest account: ${user.uid}');
        
        try {
          // Delete user data from Firestore first
          await _deleteUserData(user.uid);
          
          // Then delete the user account
          await user.delete();
          print('Guest account and data successfully deleted');
        } catch (e) {
          print('Error deleting guest account: $e');
          // Continue with sign out even if deletion fails
        }
      }
      
      // Sign out regardless of whether deletion succeeded
      await _firebaseAuth.signOut();
      emit(AuthUnauthenticated());
    } catch (e) {
      print('Sign out error: $e');
      emit(AuthError('Sign out failed: ${e.toString()}'));
    }
  }
  
  // Helper method to delete user data from Firestore
  Future<void> _deleteUserData(String userId) async {
    try {
      // Get Firestore instance
      final firestore = FirebaseFirestore.instance;
      
      // Delete user document
      await firestore.collection('users').doc(userId).delete();
      print('Deleted user document for $userId');
      
      // Delete other related collections
      // For example, if you have subcollections or other documents related to this user
      
      // Delete favorites
      final favoritesQuery = await firestore.collection('favorites').where('userId', isEqualTo: userId).get();
      for (var doc in favoritesQuery.docs) {
        await doc.reference.delete();
      }
      print('Deleted ${favoritesQuery.docs.length} favorites documents');
      
      // Add more collections as needed
      
    } catch (e) {
      print('Error deleting user data: $e');
      rethrow;
    }
  }

  String _getErrorMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'No user found for that email.';
      case 'wrong-password':
        return 'Wrong password provided.';
      case 'email-already-in-use':
        return 'The account already exists for that email.';
      case 'weak-password':
        return 'The password provided is too weak.';
      case 'invalid-email':
        return 'The email address is badly formatted.';
      case 'user-disabled':
        return 'This user account has been disabled.';
      case 'too-many-requests':
        return 'Too many requests. Try again later.';
      case 'operation-not-allowed':
        return 'Operation not allowed. Please contact support.';
      default:
        return e.message ?? 'An unknown error occurred.';
    }
  }
}