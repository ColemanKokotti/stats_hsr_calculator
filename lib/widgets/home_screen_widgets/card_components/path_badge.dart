import 'package:flutter/material.dart';
import '../../../data/character_feature.dart';
import '../../../data/character_rarity.dart';
import '../../../themes/firefly_theme.dart';


class PathBadge extends StatelessWidget {
  final String pathName;

  const PathBadge({
    super.key,
    required this.pathName,
  });

  @override
  Widget build(BuildContext context) {
    final hasIcon = ChararcterAssets.hasPathIcon(pathName);
    final pathColor = hasIcon
        ? ChararcterAssets.getPathColor(pathName)
        : FireflyTheme.turquoise;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: pathColor.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: pathColor.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 16,
            height: 16,
            child: _buildPathIcon(pathColor, hasIcon),
          ),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              pathName.isNotEmpty
                  ? CharacterUtils.capitalizeFirst(pathName)
                  : 'Unknown Path',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: pathColor,
                fontWeight: FontWeight.w600,
                fontSize: 11,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPathIcon(Color pathColor, bool hasIcon) {
    if (hasIcon) {
      return Image.asset(
        ChararcterAssets.getPathIcon(pathName),
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          return Icon(
            Icons.category,
            color: pathColor,
            size: 16,
          );
        },
      );
    } else {
      return Icon(
        Icons.category,
        color: pathColor,
        size: 16,
      );
    }
  }
}