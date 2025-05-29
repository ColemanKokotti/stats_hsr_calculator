import 'package:flutter/material.dart';
import '../../data/character_model.dart';
import '../../themes/firefly_theme.dart';
import 'card_components/character_badges.dart';
import 'card_components/character_image.dart';
import 'card_components/character_info.dart';

class CharacterCard extends StatelessWidget {
  final Character character;
  final VoidCallback? onTap;

  const CharacterCard({
    super.key,
    required this.character,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Container(
        decoration: FireflyTheme.cardDecoration,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header con immagine, info e pulsante favorito
                Row(
                  children: [
                    CharacterImage(character: character),
                    const SizedBox(width: 12),
                    Expanded(
                      child: CharacterInfo(character: character),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // Badge Path ed Elemento - con spazio flessibile
                CharacterBadges(character: character),
                const SizedBox(height: 8), // Spazio extra per evitare sovrapposizioni
              ],
            ),
          ),
        ),
      ),
    );
  }
}