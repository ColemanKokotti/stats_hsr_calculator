import 'package:flutter/material.dart';
import '../../data/character_feature.dart';
import '../../data/character_model.dart';
import '../../themes/firefly_theme.dart';

class CharacterPathWidget extends StatelessWidget {
  final Character character;
  final bool showLabel;
  final double iconSize;

  const CharacterPathWidget({
    super.key,
    required this.character,
    this.showLabel = true,
    this.iconSize = 24,
  });

  @override
  Widget build(BuildContext context) {
    final pathColor = ChararcterAssets.hasPathIcon(character.pathName)
        ? ChararcterAssets.getPathColor(character.pathName)
        : FireflyTheme.turquoise;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: pathColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: pathColor.withOpacity(0.3),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: pathColor.withOpacity(0.3),
            blurRadius: 8,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: iconSize,
            height: iconSize,
            child: ChararcterAssets.hasPathIcon(character.pathName)
                ? Image.asset(
              ChararcterAssets.getPathIcon(character.pathName),
              width: iconSize,
              height: iconSize,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return Icon(
                  Icons.category,
                  color: pathColor,
                  size: iconSize,
                );
              },
            )
                : Icon(
              Icons.category,
              color: pathColor,
              size: iconSize,
            ),
          ),
          if (showLabel) ...[
            const SizedBox(width: 8),
            Text(
              character.pathName.isNotEmpty
                  ? _capitalizeFirst(character.pathName)
                  : 'Unknown Path',
              style: TextStyle(
                color: pathColor,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ],
        ],
      ),
    );
  }

  String _capitalizeFirst(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }
}