import 'package:flutter/material.dart';
import '../../themes/firefly_theme.dart';
import 'profile_picture_grid.dart';

class ProfilePictureSection extends StatelessWidget {
  const ProfilePictureSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Choose a Profile Picture',
          style: TextStyle(
            color: FireflyTheme.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        
        // Grid of profile pictures with pagination
        const ProfilePictureGrid(),
      ],
    );
  }
}