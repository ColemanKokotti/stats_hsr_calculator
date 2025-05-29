import 'package:flutter/material.dart';
import '../../../data/character_rarity.dart';


class RarityStars extends StatelessWidget {
  final int rarity;

  const RarityStars({
    super.key,
    required this.rarity,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          index < rarity ? Icons.star : Icons.star_border,
          color: CharacterUtils.getRarityColor(rarity),
          size: 16,
        );
      }),
    );
  }
}