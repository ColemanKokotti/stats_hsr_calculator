import 'package:flutter/material.dart';
import '../../data/character_model.dart';
import '../../themes/firefly_theme.dart';

class CharacterIconWidget extends StatelessWidget {
  final Character character;
  final double size;

  const CharacterIconWidget({
    super.key,
    required this.character,
    this.size = 40,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: _getRarityColor(character.rarity),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: _getRarityColor(character.rarity),
            blurRadius: 8,
            spreadRadius: 1,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: character.imageUrl.isNotEmpty
            ? Image.network(
          character.imageUrl,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: FireflyTheme.jacket,
              child: Icon(
                Icons.person,
                color: FireflyTheme.white,
                size: size * 0.6,
              ),
            );
          },
        )
            : Container(
          color: FireflyTheme.jacket,
          child: Icon(
            Icons.person,
            color: FireflyTheme.white,
            size: size * 0.6,
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