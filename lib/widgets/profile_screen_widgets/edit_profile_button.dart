import 'package:flutter/material.dart';
import '../../screens/profile_edit_screen.dart';
import '../../themes/firefly_theme.dart';


class EditProfileButton extends StatelessWidget {
  const EditProfileButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: FireflyTheme.goldGradient,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _navigateToEditProfile(context),
          customBorder: const CircleBorder(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.edit,
              color: FireflyTheme.jacket,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToEditProfile(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ProfileEditScreen(),
      ),
    );
  }
}