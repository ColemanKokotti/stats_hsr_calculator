import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../themes/firefly_theme.dart';
import 'profile_image.dart';
import 'profile_info.dart';
import 'edit_profile_button.dart';
import 'my_characters_button.dart';

class ProfileCard extends StatelessWidget {
  final User user;
  final bool isGuest;

  const ProfileCard({
    super.key,
    required this.user,
    required this.isGuest,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: FireflyTheme.cardGradient,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: FireflyTheme.jacket.withOpacity(0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            // Buttons row (only for non-guest users)
            if (!isGuest)
              const Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // My Characters button on the left
                    MyCharactersButton(),
                    // Edit Profile button on the right
                    EditProfileButton(),
                  ],
                ),
              ),
            ProfileImage(user: user),
            const SizedBox(height: 24),
            ProfileInfo(user: user, isGuest: isGuest),
          ],
        ),
      ),
    );
  }
}