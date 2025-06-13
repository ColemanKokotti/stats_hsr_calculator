import 'package:flutter/material.dart';
import '../../themes/firefly_theme.dart';

class CharacterCollectionHeader extends StatelessWidget {
  const CharacterCollectionHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.auto_stories,
            color: FireflyTheme.turquoise,
            size: 24,
          ),
          const SizedBox(width: 8),
          Text(
            'Character Collection',
            style: TextStyle(
              color: FireflyTheme.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}