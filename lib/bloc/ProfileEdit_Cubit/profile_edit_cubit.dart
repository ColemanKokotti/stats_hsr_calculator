import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../firebase_service/fireabese_service.dart';
import 'profile_edit_state.dart';

class ProfileEditCubit extends Cubit<ProfileEditState> {
  final FirebaseAuth _auth;

  ProfileEditCubit({FirebaseAuth? auth}) 
      : _auth = auth ?? FirebaseAuth.instance,
        super(ProfileEditInitial());

  // Update username
  Future<void> updateUsername(String username) async {
    try {
      final user = _auth.currentUser;
      
      if (user == null) {
        emit(ProfileEditError('You must be logged in to update your profile'));
        return;
      }
      
      emit(ProfileEditLoading());
      
      // Get current profile to preserve existing profile picture
      final profileData = await FirebaseService.getCurrentUserProfile();
      final currentProfilePicture = profileData?['profilePicture'] as String? ?? '';
      
      await FirebaseService.updateUserProfile(
        username: username,
        profilePicture: currentProfilePicture,
      );
      
      emit(ProfileEditSuccess('Username updated successfully'));
    } catch (e) {
      print('Error updating username: $e');
      emit(ProfileEditError('Failed to update username: $e'));
    }
  }

  // Update profile picture
  Future<void> updateProfilePicture(String profilePicture) async {
    try {
      final user = _auth.currentUser;
      
      if (user == null) {
        emit(ProfileEditError('You must be logged in to update your profile'));
        return;
      }
      
      emit(ProfileEditLoading());
      
      // Get current profile to preserve existing username
      final profileData = await FirebaseService.getCurrentUserProfile();
      final currentUsername = profileData?['username'] as String? ?? '';
      
      await FirebaseService.updateUserProfile(
        username: currentUsername,
        profilePicture: profilePicture,
      );
      
      emit(ProfileEditSuccess('Profile picture updated successfully'));
    } catch (e) {
      print('Error updating profile picture: $e');
      emit(ProfileEditError('Failed to update profile picture: $e'));
    }
  }

  // Update password
  Future<void> updatePassword(String currentPassword, String newPassword) async {
    try {
      final user = _auth.currentUser;
      
      if (user == null) {
        emit(ProfileEditError('You must be logged in to update your password'));
        return;
      }
      
      // Guest users (anonymous) cannot update password
      if (user.isAnonymous) {
        emit(ProfileEditError('Guest users cannot update password'));
        return;
      }
      
      emit(ProfileEditLoading());
      
      // For email/password users, we need to reauthenticate before changing password
      if (user.email != null) {
        // Create credential
        AuthCredential credential = EmailAuthProvider.credential(
          email: user.email!,
          password: currentPassword,
        );
        
        // Reauthenticate
        try {
          await user.reauthenticateWithCredential(credential);
        } catch (e) {
          emit(ProfileEditError('Current password is incorrect'));
          return;
        }
      }
      
      // Update password
      await user.updatePassword(newPassword);
      
      emit(ProfileEditSuccess('Password updated successfully'));
    } catch (e) {
      print('Error updating password: $e');
      emit(ProfileEditError('Failed to update password: $e'));
    }
  }

  // Delete account
  Future<void> deleteAccount(String password) async {
    try {
      final user = _auth.currentUser;
      
      if (user == null) {
        emit(ProfileEditError('You must be logged in to delete your account'));
        return;
      }
      
      // Guest users (anonymous) can be deleted directly
      if (user.isAnonymous) {
        emit(ProfileEditLoading());
        await user.delete();
        emit(ProfileEditSuccess('Account deleted successfully'));
        return;
      }
      
      // For email/password users, we need to reauthenticate before deleting
      if (user.email != null) {
        emit(ProfileEditLoading());
        
        // Create credential
        AuthCredential credential = EmailAuthProvider.credential(
          email: user.email!,
          password: password,
        );
        
        // Reauthenticate
        try {
          await user.reauthenticateWithCredential(credential);
        } catch (e) {
          emit(ProfileEditError('Current password is incorrect'));
          return;
        }
        
        // Delete user document from Firestore first
        try {
          await FirebaseFirestore.instance.collection('users').doc(user.uid).delete();
          print('User document deleted from Firestore');
        } catch (e) {
          print('Error deleting user document from Firestore: $e');
          // Continue with account deletion even if Firestore deletion fails
        }
        
        // Delete user account
        await user.delete();
        emit(ProfileEditSuccess('Account deleted successfully'));
      }
    } catch (e) {
      print('Error deleting account: $e');
      emit(ProfileEditError('Failed to delete account: $e'));
    }
  }

  // Reset state
  void resetState() {
    emit(ProfileEditInitial());
  }
}