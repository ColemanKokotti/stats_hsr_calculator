import 'package:flutter/material.dart';
import 'package:help_project/screens/character_detailed_screen.dart';
import '../../data/character_model.dart';
import '../../themes/firefly_theme.dart';


class CharacterStatsIcon extends StatelessWidget {
  final Character character;
  final double size;
  final VoidCallback? onTap; // Callback opzionale per personalizzare l'azione

  const CharacterStatsIcon({
    super.key,
    required this.character,
    this.size = 40,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () {
        Navigator.pop(
          context,
          MaterialPageRoute(
            builder: (context) => CharacterDetailScreen(character: character),
          ),
        );
      },
      child: Container(
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
          child: character.portrait.isNotEmpty
              ? Image.network(
            character.portrait,
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
