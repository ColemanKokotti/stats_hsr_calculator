import 'package:flutter/material.dart';
import '../../../data/character_feature.dart';
import '../../../data/character_rarity.dart';

class CharacterFactionWidget extends StatelessWidget {
  final String faction;

  const CharacterFactionWidget({
    super.key,
    required this.faction,
  });

  @override
  Widget build(BuildContext context) {
    final factionColor = ChararcterAssets.getFactionColor(faction);

    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: factionColor.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: factionColor.withOpacity(0.5),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(width: 6),
          Text(
            faction.isNotEmpty
                ? CharacterUtils.capitalizeFirst(faction)
                : 'Unknown',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: factionColor,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}