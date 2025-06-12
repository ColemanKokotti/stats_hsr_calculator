import 'package:flutter/material.dart';
import '../../themes/firefly_theme.dart';

class ProfileSetupHeader extends StatelessWidget {
  const ProfileSetupHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FireflyTheme.gradientText(
        'Complete Your Profile',
        gradient: FireflyTheme.eyesGradient,
        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}