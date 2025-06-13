import 'package:flutter/material.dart';
import '../../data/character_model.dart';
import '../../data/character_feature.dart';
import '../../themes/firefly_theme.dart';
import '../../themes/responsive_utils.dart';

class CharacterFeaturesInfoContainer extends StatelessWidget {
  final Character character;

  const CharacterFeaturesInfoContainer({
    super.key,
    required this.character,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: ResponsiveUtils.getStandardCardPadding(context),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            FireflyTheme.jacket.withOpacity(0.4),
            FireflyTheme.jacket.withOpacity(0.2),
          ],
        ),
        borderRadius: ResponsiveUtils.getResponsiveBorderRadius(
          context,
          mobileRadius: 10,
          tabletRadius: 12,
          desktopRadius: 16,
        ),
        border: Border.all(
          color: FireflyTheme.turquoise.withOpacity(0.4),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: ResponsiveUtils.getResponsiveValue(
              context,
              mobileValue: 6,
              tabletValue: 8,
              desktopValue: 10,
            ),
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Path Info
          _buildFeatureInfo(
            context,
            label: 'Path',
            value: character.pathName,
            color: ChararcterAssets.getPathColor(character.pathName),
          ),
          
          ResponsiveUtils.responsiveVerticalSpace(
            context,
            mobileHeight: 10,
            tabletHeight: 14,
            desktopHeight: 18,
          ),
          
          // Element Info
          _buildFeatureInfo(
            context,
            label: 'Element',
            value: character.element,
            color: ChararcterAssets.getElementColor(character.element),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureInfo(
    BuildContext context, {
    required String label,
    required String value,
    required Color color,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: ResponsiveTextUtils.getLabelMediumStyle(
            context,
            color: FireflyTheme.white.withOpacity(0.8),
          ).copyWith(fontWeight: FontWeight.w500),
        ),
        ResponsiveUtils.responsiveVerticalSpace(
          context,
          mobileHeight: 2,
          tabletHeight: 3,
          desktopHeight: 4,
        ),
        SizedBox(
          width: double.infinity,
          child: Text(
            _capitalizeValue(value),
            style: ResponsiveTextUtils.getTitleMediumStyle(
              context,
              color: color,
            ).copyWith(fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  String _capitalizeValue(String value) {
    return value.split(' ').map((word) => 
      word.isNotEmpty ? word[0].toUpperCase() + word.substring(1).toLowerCase() : ''
    ).join(' ');
  }
}