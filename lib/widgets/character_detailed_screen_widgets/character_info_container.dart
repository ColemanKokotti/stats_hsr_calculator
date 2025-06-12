import 'package:flutter/material.dart';
import '../../data/character_model.dart';
import '../../themes/firefly_theme.dart';
import 'character_attributes_section.dart';
import 'character_faction_section.dart';
import 'character_rarity_section.dart';

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
          CharacterRaritySection(rarity: character.rarity),
          const SizedBox(height: 20),
          
          // Elemento e Path
          CharacterAttributesSection(character: character),
          const SizedBox(height: 30),
          
          // Faction
          CharacterFactionSection(faction: character.faction),
        ],
      ),
    );
  }
}