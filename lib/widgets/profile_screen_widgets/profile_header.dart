import 'package:flutter/material.dart';
import '../../themes/firefly_theme.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FireflyTheme.gradientText(
        'Your Profile',
        gradient: FireflyTheme.eyesGradient,
        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}