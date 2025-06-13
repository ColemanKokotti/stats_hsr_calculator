import 'package:flutter/material.dart';
import '../../data/character_model.dart';
import '../../themes/firefly_theme.dart';
import '../../themes/responsive_utils.dart';
import 'character_portrait_section.dart';
import 'character_info_section.dart';

class CharacterDetailContainer extends StatelessWidget {
  final Character character;

  const CharacterDetailContainer({
    super.key,
    required this.character,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: FireflyTheme.jacket,
        borderRadius: ResponsiveUtils.getResponsiveBorderRadius(
          context,
          mobileRadius: 12,
          tabletRadius: 16,
          desktopRadius: 20,
        ),
      ),
      child: Padding(
        padding: ResponsiveUtils.getStandardContainerPadding(context),
        child: Column(
          children: [
            // Layout principale
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Portrait con dimensioni fisse
                  CharacterPortraitSection(character: character),
                  ResponsiveUtils.responsiveHorizontalSpace(context),
                  // Info che si espande per riempire lo spazio restante
                  Expanded(
                    child: CharacterInfoSection(character: character),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}