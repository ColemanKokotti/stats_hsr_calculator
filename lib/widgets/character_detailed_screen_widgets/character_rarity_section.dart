import 'package:flutter/material.dart';
import '../../themes/firefly_theme.dart';
import 'character_rarity_widget.dart';

class CharacterRaritySection extends StatelessWidget {
  final int rarity;

  const CharacterRaritySection({
    super.key,
    required this.rarity,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Rarity: ',
          style: TextStyle(
            color: FireflyTheme.white.withOpacity(0.8),
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        CharacterRarityWidget(rarity: rarity),
      ],
    );
  }
}