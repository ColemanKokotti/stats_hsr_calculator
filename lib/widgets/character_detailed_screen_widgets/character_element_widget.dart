import 'package:flutter/material.dart';
import '../../data/character_feature.dart';

class CharacterElementWidget extends StatelessWidget {
  final String element;
  final bool showLabel;
  final double iconSize;

  const CharacterElementWidget({
    super.key,
    required this.element,
    this.showLabel = true,
    this.iconSize = 20,
  });

  @override
  Widget build(BuildContext context) {
    final elementColor = ChararcterAssets.getFactionColor(element);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: elementColor.withOpacity(0.3),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: elementColor.withOpacity(0.3),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: elementColor.withOpacity(0.3),
            blurRadius: 8,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: iconSize,
            height: iconSize,
            child: ChararcterAssets.hasElementIcon(element)
                ? Image.asset(
              ChararcterAssets.getElementIcon(element),
              width: iconSize,
              height: iconSize,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: iconSize,
                  height: iconSize,
                  decoration: BoxDecoration(
                    color: elementColor,
                    shape: BoxShape.circle,
                  ),
                );
              },
            )
                : Container(
              width: iconSize,
              height: iconSize,
              decoration: BoxDecoration(
                color: elementColor.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
            ),
          ),
          if (showLabel) ...[
            const SizedBox(width: 8),
            Text(
              element.isNotEmpty ? _capitalizeFirst(element) : 'Unknown',
              style: TextStyle(
                color: elementColor,
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