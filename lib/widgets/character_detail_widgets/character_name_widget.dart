import 'package:flutter/material.dart';
import '../../themes/firefly_theme.dart';
import '../../themes/responsive_utils.dart';

class CharacterNameWidget extends StatelessWidget {
  final String name;

  const CharacterNameWidget({
    super.key,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: ResponsiveUtils.getResponsiveEdgeInsets(
        context,
        mobileInsets: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        tabletInsets: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        desktopInsets: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      ),
      decoration: BoxDecoration(
        gradient: FireflyTheme.turquoiseGradient,
        borderRadius: ResponsiveUtils.getResponsiveBorderRadius(
          context,
          mobileRadius: 10,
          tabletRadius: 12,
          desktopRadius: 16,
        ),
        boxShadow: [
          BoxShadow(
            color: FireflyTheme.turquoise.withOpacity(0.3),
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
      child: FireflyTheme.gradientText(
        name,
        gradient: FireflyTheme.goldGradient,
        style: ResponsiveTextUtils.getHeadlineSmallStyle(context).copyWith(
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}