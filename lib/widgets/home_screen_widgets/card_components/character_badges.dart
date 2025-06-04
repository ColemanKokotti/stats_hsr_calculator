import 'package:flutter/material.dart';
import '../../../data/character_model.dart';
import 'path_badge.dart';
import 'element_badge.dart';

class CharacterBadges extends StatelessWidget {
  final Character character;

  const CharacterBadges({
    super.key,
    required this.character,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          PathBadge(
            pathName: character.pathName,
          ),
          const SizedBox(width: 6),
          ElementBadge(
            element: character.element,
          ),
        ],
      ),
    );
  }
}