import 'package:flutter/material.dart';
import '../../themes/firefly_theme.dart';

class SettingsHeader extends StatelessWidget {
  const SettingsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FireflyTheme.gradientText(
        'Settings',
        gradient: FireflyTheme.eyesGradient,
        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}