import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/Profile_Cubit/profile_cubit.dart';
import '../../bloc/Profile_Cubit/profile_state.dart';
import '../../themes/firefly_theme.dart';

class ProfileInfo extends StatelessWidget {
  final User user;
  final bool isGuest;

  const ProfileInfo({
    super.key,
    required this.user,
    required this.isGuest,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return Column(
          children: [
            Text(
              _getUsername(state),
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: FireflyTheme.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              isGuest ? 'Anonymous Account' : (user.email ?? 'No email provided'),
              style: TextStyle(
                fontSize: 16,
                color: FireflyTheme.white.withOpacity(0.8),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isGuest ? Colors.amber.withOpacity(0.2) : Colors.green.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isGuest ? Colors.amber.withOpacity(0.5) : Colors.green.withOpacity(0.5),
                ),
              ),
              child: Text(
                isGuest ? 'Guest Account' : 'Registered User',
                style: TextStyle(
                  color: isGuest ? Colors.amber : Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
  
  String _getUsername(ProfileState state) {
    // If profile is loaded, use the username from Firestore
    if (state is ProfileLoaded && 
        state.profile.username != null && 
        state.profile.username!.isNotEmpty) {
      print('Using username from Firestore: ${state.profile.username}');
      return state.profile.username!;
    }
    
    // If user has a display name from Firebase Auth, use it
    if (user.displayName != null && user.displayName!.isNotEmpty) {
      print('Using displayName from Firebase Auth: ${user.displayName}');
      return user.displayName!;
    }
    
    // Otherwise, show default or guest name
    print('Using default username. isGuest: $isGuest');
    return isGuest ? 'Guest User' : 'User';
  }
}