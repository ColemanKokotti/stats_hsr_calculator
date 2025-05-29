import 'package:flutter/material.dart';

import '../../data/character_model.dart';
import '../../themes/firefly_theme.dart';

class CharacterPortraitWidget extends StatelessWidget {
  final Character character;
  final double size;

  const CharacterPortraitWidget({
    super.key,
    required this.character,
    this.size = 200,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: _getRarityColor(character.rarity),
          width: 3,
        ),
        boxShadow: [
          BoxShadow(
            color: _getRarityColor(character.rarity),
            blurRadius: 20,
            spreadRadius: 2,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(13),
        child: character.portrait.isNotEmpty  // Cambiato da imageUrl a portrait
            ? Image.network(
          character.portrait,  // Cambiato da imageUrl a portrait
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: FireflyTheme.jacket,
              child: Icon(
                Icons.person,
                color: FireflyTheme.white,
                size: size * 0.4,
              ),
            );
          },
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Container(
              color: FireflyTheme.jacket,
              child: Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!
                      : null,
                  color: FireflyTheme.turquoise,
                  strokeWidth: 3,
                ),
              ),
            );
          },
        )
            : Container(
          color: FireflyTheme.jacket,
          child: Icon(
            Icons.person,
            color: FireflyTheme.white,
            size: size * 0.4,
          ),
        ),
      ),
    );
  }

  Color _getRarityColor(int rarity) {
    switch (rarity) {
      case 5:
        return const Color(0xFFFFD700); // Gold
      case 4:
        return const Color(0xFFB19CD9); // Purple
      case 3:
        return const Color(0xFF4FC3F7); // Blue
      default:
        return FireflyTheme.white;
    }
  }
}