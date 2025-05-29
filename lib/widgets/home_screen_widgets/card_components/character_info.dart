import 'package:flutter/material.dart';
import '../../../data/character_model.dart';
import '../../../themes/firefly_theme.dart';
import 'favorite_button.dart';
import 'rarity_stars.dart';

class CharacterInfo extends StatelessWidget {
  final Character character;

  const CharacterInfo({
    super.key,
    required this.character,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                character.name,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: FireflyTheme.white,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              RarityStars(rarity: character.rarity),
            ],
          ),
        ),
        FavoriteButton(character: character),
      ],
    );
  }
}