import 'package:flutter/material.dart';
import '../../../data/character_feature.dart';
import '../../../data/character_rarity.dart';

class ElementBadge extends StatelessWidget {
  final String element;

  const ElementBadge({
    super.key,
    required this.element,
  });

  @override
  Widget build(BuildContext context) {
    final elementColor = ChararcterAssets.getElementColor(element);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: elementColor.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: elementColor.withOpacity(0.5),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 20,
            height: 20,
            child: _buildElementIcon(elementColor),
          ),
          const SizedBox(width: 6),
          Text(
            element.isNotEmpty
                ? CharacterUtils.capitalizeFirst(element)
                : 'Unknown',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: elementColor,
              fontWeight: FontWeight.w600,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildElementIcon(Color elementColor) {
    if (ChararcterAssets.hasElementIcon(element)) {
      return Image.asset(
        ChararcterAssets.getElementIcon(element),
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: elementColor,
              shape: BoxShape.circle,
            ),
          );
        },
      );
    } else {
      return Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          color: elementColor,
          shape: BoxShape.circle,
        ),
      );
    }
  }
}