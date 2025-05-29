import '../../data/character_model.dart';
import 'package:flutter/material.dart';

import '../../themes/firefly_theme.dart';
import 'character_element_widget.dart';
import 'character_path_widget.dart';
import 'character_rarity_widget.dart';

class CharacterInfoContainerWidget extends StatelessWidget {
  final Character character;

  const CharacterInfoContainerWidget({
    super.key,
    required this.character,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: FireflyTheme.cardDecoration.copyWith(
        boxShadow: [
          BoxShadow(
            color: FireflyTheme.turquoise.withOpacity(0.1),
            blurRadius: 20,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        children: [
          // Rarità
          Row(
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
              CharacterRarityWidget(rarity: character.rarity),
            ],
          ),
          const SizedBox(height: 20),
          // Elemento e Path
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text(
                    'Element',
                    style: TextStyle(
                      color: FireflyTheme.white.withOpacity(0.8),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  CharacterElementWidget(element: character.element),
                ],
              ),
              Column(
                children: [
                  Text(
                    'Path',
                    style: TextStyle(
                      color: FireflyTheme.white.withOpacity(0.8),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  CharacterPathWidget(character: character),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}