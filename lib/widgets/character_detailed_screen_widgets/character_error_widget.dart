import 'package:flutter/material.dart';
import '../../themes/firefly_theme.dart';

class CharacterErrorWidget extends StatelessWidget {
  final String errorMessage;

  const CharacterErrorWidget({
    super.key,
    required this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 64,
            color: Colors.red.withOpacity(0.7),
          ),
          const SizedBox(height: 16),
          Text(
            'Error loading character details',
            style: TextStyle(
              color: FireflyTheme.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            errorMessage,
            style: TextStyle(
              color: FireflyTheme.white.withOpacity(0.7),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            style: ElevatedButton.styleFrom(
              backgroundColor: FireflyTheme.turquoise,
              foregroundColor: FireflyTheme.jacket,
            ),
            child: const Text('Go Back'),
          ),
        ],
      ),
    );
  }
}