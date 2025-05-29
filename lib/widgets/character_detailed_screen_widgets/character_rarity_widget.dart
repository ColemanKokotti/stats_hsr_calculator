import 'package:flutter/material.dart';
import '../../themes/firefly_theme.dart';

class CharacterRarityWidget extends StatelessWidget {
  final int rarity;
  final double starSize;

  const CharacterRarityWidget({
    super.key,
    required this.rarity,
    this.starSize = 24,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          index < rarity ? Icons.star : Icons.star_border,
          color: _getRarityColor(rarity),
          size: starSize,
        );
      }),
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
