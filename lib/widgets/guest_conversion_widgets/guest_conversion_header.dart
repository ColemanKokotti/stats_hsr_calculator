import 'package:flutter/material.dart';
import '../../themes/firefly_theme.dart';

class GuestConversionHeader extends StatelessWidget {
  const GuestConversionHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header
        Center(
          child: FireflyTheme.gradientText(
            'Create Your Account',
            gradient: FireflyTheme.eyesGradient,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
        ),
        const SizedBox(height: 16),
        
        // Description
        Text(
          'Convert your guest account to a permanent account to save your progress and settings.',
          style: TextStyle(
            color: FireflyTheme.white,
            fontSize: 16,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}