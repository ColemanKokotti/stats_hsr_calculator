import 'package:flutter/material.dart';
import '../../themes/firefly_theme.dart';
import 'character_faction_widget.dart';

class CharacterFactionSection extends StatelessWidget {
  final String faction;

  const CharacterFactionSection({
    super.key,
    required this.faction,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            'Faction',
            style: TextStyle(
              color: FireflyTheme.white.withOpacity(0.8),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          CharacterFactionWidget(faction: faction)
        ],
      ),
    );
  }
}