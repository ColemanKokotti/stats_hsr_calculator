import 'package:flutter/material.dart';
import '../../themes/firefly_theme.dart';

class UnauthenticatedContent extends StatelessWidget {
  const UnauthenticatedContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.lock_outline,
            size: 64,
            color: FireflyTheme.turquoise,
          ),
          const SizedBox(height: 16),
          Text(
            'Please sign in to view your favorites',
            style: TextStyle(
              color: FireflyTheme.white,
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              // Navigate to auth screen
              Navigator.pushNamed(context, '/auth');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: FireflyTheme.turquoise,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 12,
              ),
            ),
            child: const Text('Sign In'),
          ),
        ],
      ),
    );
  }
}