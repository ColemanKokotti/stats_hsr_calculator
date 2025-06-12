import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../data/user_profile.dart';
import '../../firebase_service/fireabese_service.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final FirebaseAuth _auth;
  StreamSubscription? _profileSubscription;

  ProfileCubit({FirebaseAuth? auth}) 
      : _auth = auth ?? FirebaseAuth.instance,
        super(ProfileInitial()) {
    // Initialize profile when the cubit is created
    _initProfile();
  }

  // Initialize profile from Firestore
  Future<void> _initProfile() async {
    try {
      final user = _auth.currentUser;
      
      if (user == null) {
        emit(ProfileUnauthenticated());
        return;
      }
      
      emit(ProfileLoading());
      
      // Subscribe to real-time updates for profile
      _subscribeToProfile(user.uid);
    } catch (e) {
      print('Error initializing profile: $e');
      emit(ProfileError('Failed to load profile: $e'));
    }
  }

  // Subscribe to real-time updates for profile
  void _subscribeToProfile(String userId) {
    // Cancel any existing subscription
    _profileSubscription?.cancel();
    
    print('ProfileCubit: Subscribing to profile updates for user $userId');
    
    // Subscribe to profile stream
    _profileSubscription = FirebaseService.userProfileStream(userId)
        .listen((snapshot) {
      print('ProfileCubit: Received profile update from stream');
      
      if (!snapshot.exists) {
        print('ProfileCubit: Document does not exist, emitting ProfileIncomplete');
        emit(ProfileIncomplete());
        return;
      }
      
      try {
        final data = snapshot.data() as Map<String, dynamic>;
        print('ProfileCubit: Profile data from Firestore: $data');
        final profile = UserProfile.fromJson(data);
        
        print('ProfileCubit: Profile after parsing: username=${profile.username}, profilePicture=${profile.profilePicture}');
        print('ProfileCubit: Is profile complete: ${profile.isProfileComplete}');
        
        if (profile.isProfileComplete) {
          print('ProfileCubit: Emitting ProfileLoaded with profile: $profile');
          // Force a new instance to ensure state change is detected
          emit(ProfileLoaded(profile: profile.copyWith()));
        } else {
          print('ProfileCubit: Emitting ProfileIncomplete');
          emit(ProfileIncomplete());
        }
      } catch (e) {
        print('ProfileCubit: Error parsing profile data: $e');
        emit(ProfileError('Error parsing profile data: $e'));
      }
    }, onError: (error) {
      print('ProfileCubit: Error in profile stream: $error');
      emit(ProfileError('Error loading profile: $error'));
    });
  }

  // Update user profile
  Future<void> updateProfile({
    required String username,
    required String profilePicture,
  }) async {
    try {
      final user = _auth.currentUser;
      
      if (user == null) {
        emit(ProfileError('You must be logged in to update your profile'));
        return;
      }
      
      emit(ProfileUpdating());
      
      await FirebaseService.updateUserProfile(
        username: username,
        profilePicture: profilePicture,
      );
      
      // The profile will be updated automatically via the stream subscription
    } catch (e) {
      print('Error updating profile: $e');
      emit(ProfileError('Failed to update profile: $e'));
    }
  }

  // Check if profile is complete
  Future<bool> isProfileComplete() async {
    try {
      return await FirebaseService.hasCompletedProfileSetup();
    } catch (e) {
      print('Error checking if profile is complete: $e');
      return false;
    }
  }

  // Handle user authentication changes
  void onUserChanged(User? user) {
    if (user == null) {
      // User logged out, clear profile
      _profileSubscription?.cancel();
      emit(ProfileUnauthenticated());
    } else {
      // User logged in, load their profile
      _subscribeToProfile(user.uid);
    }
  }

  @override
  Future<void> close() {
    _profileSubscription?.cancel();
    return super.close();
  }
}