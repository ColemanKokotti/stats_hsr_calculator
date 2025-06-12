import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/Profile_Cubit/profile_cubit.dart';
import '../../bloc/Profile_Cubit/profile_state.dart';
import '../../themes/firefly_theme.dart';

class ProfileImage extends StatelessWidget {
  final User user;

  const ProfileImage({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: FireflyTheme.eyesGradient,
            boxShadow: [
              BoxShadow(
                color: FireflyTheme.gold.withOpacity(0.5),
                blurRadius: 15,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(3.0), // Border width
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: ClipOval(
                child: _getProfileImage(state),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _getProfileImage(ProfileState state) {
    // If profile is loaded, use the profile picture from Firestore
    if (state is ProfileLoaded && 
        state.profile.profilePicture != null && 
        state.profile.profilePicture!.isNotEmpty) {
      
      print('Loading profile image: ${state.profile.profilePicture}');
      
      // Check if the profile picture is a full path or just a filename
      String imagePath;
      if (state.profile.profilePicture!.contains('assets/')) {
        imagePath = state.profile.profilePicture!;
        print('Using full path: $imagePath');
      } else {
        imagePath = 'assets/profile_images/${state.profile.profilePicture}';
        print('Using constructed path: $imagePath');
      }
      
      // Use a key to force the image to reload
      return Image.asset(
        imagePath,
        key: ValueKey(imagePath), // Add a key to force rebuild
        fit: BoxFit.cover,
        // Add cacheWidth and cacheHeight to improve performance
        cacheWidth: 240, // 2x the display size for high-res screens
        cacheHeight: 240,
        errorBuilder: (context, error, stackTrace) {
          print('Error loading profile image: $error');
          print('Attempted path: $imagePath');
          return _buildDefaultAvatar();
        },
      );
    }
    
    // If user has a photo URL from Firebase Auth, use it
    if (user.photoURL != null) {
      print('Using photo URL from Firebase Auth: ${user.photoURL}');
      return Image.network(
        user.photoURL!,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          print('Error loading network image: $error');
          return _buildDefaultAvatar();
        },
      );
    }
    
    // Otherwise, show default avatar
    print('Using default avatar');
    return _buildDefaultAvatar();
  }

  Widget _buildDefaultAvatar() {
    return Container(
      color: FireflyTheme.jacket.withOpacity(0.8),
      child: Icon(
        Icons.person,
        size: 80,
        color: FireflyTheme.white.withOpacity(0.9),
      ),
    );
  }
}