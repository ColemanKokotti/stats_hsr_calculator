import 'package:flutter/material.dart';
import '../../data/character_model.dart';
import '../../data/character_feature.dart';
import '../../themes/firefly_theme.dart';
import '../../themes/responsive_utils.dart';

class CharacterFeaturesIconsRow extends StatelessWidget {
  final Character character;

  const CharacterFeaturesIconsRow({
    super.key,
    required this.character,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: ResponsiveUtils.getResponsiveEdgeInsets(
        context,
        mobileInsets: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        tabletInsets: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        desktopInsets: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      ),
      decoration: BoxDecoration(
        color: FireflyTheme.jacket.withOpacity(0.3),
        borderRadius: ResponsiveUtils.getResponsiveBorderRadius(
          context,
          mobileRadius: 10,
          tabletRadius: 12,
          desktopRadius: 16,
        ),
        border: Border.all(
          color: FireflyTheme.turquoise.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Path Icon
          _buildFeatureIcon(
            context,
            iconPath: ChararcterAssets.getPathIcon(character.pathName),
            color: ChararcterAssets.getPathColor(character.pathName),
            label: 'Path',
          ),
          
          ResponsiveUtils.responsiveHorizontalSpace(
            context,
            mobileWidth: 12,
            tabletWidth: 18,
            desktopWidth: 24,
          ),
          
          // Element Icon
          _buildFeatureIcon(
            context,
            iconPath: ChararcterAssets.getElementIcon(character.element),
            color: ChararcterAssets.getElementColor(character.element),
            label: 'Element',
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureIcon(
    BuildContext context, {
    required String iconPath,
    required Color color,
    required String label,
  }) {
    final iconSize = ResponsiveImageUtils.getResponsiveSize(
      context,
      mobileSize: 36,
      tabletSize: 44,
      desktopSize: 52,
    );
    final imageSize = ResponsiveImageUtils.getResponsiveSize(
      context,
      mobileSize: 20,
      tabletSize: 26,
      desktopSize: 32,
    );
    
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: iconSize,
          height: iconSize,
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius: ResponsiveUtils.getResponsiveBorderRadius(
              context,
              mobileRadius: 6,
              tabletRadius: 8,
              desktopRadius: 10,
            ),
            border: Border.all(
              color: color,
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.3),
                blurRadius: ResponsiveUtils.getResponsiveValue(
                  context,
                  mobileValue: 4,
                  tabletValue: 6,
                  desktopValue: 8,
                ),
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Center(
            child: Image.asset(
              iconPath,
              width: imageSize,
              height: imageSize,
              errorBuilder: (context, error, stackTrace) {
                return Icon(
                  label == 'Path' ? Icons.alt_route : Icons.auto_awesome,
                  color: color,
                  size: imageSize,
                );
              },
            ),
          ),
        ),
        ResponsiveUtils.responsiveVerticalSpace(
          context,
          mobileHeight: 3,
          tabletHeight: 5,
          desktopHeight: 7,
        ),
        Text(
          label,
          style: ResponsiveTextUtils.getLabelSmallStyle(
            context,
            color: FireflyTheme.white.withOpacity(0.7),
          ).copyWith(fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}