import 'package:flutter/material.dart';
import '../../data/character_model.dart';
import '../../themes/firefly_theme.dart';
import '../../themes/responsive_utils.dart';
import 'character_features_icons_row.dart';
import 'character_name_widget.dart';
import 'character_features_info_container.dart';

class CharacterInfoSection extends StatelessWidget {
  final Character character;

  const CharacterInfoSection({
    super.key,
    required this.character,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Character Name
          CharacterNameWidget(name: character.name),

          ResponsiveUtils.responsiveVerticalSpace(
            context,
            mobileHeight: 20,
            tabletHeight: 28,
            desktopHeight: 36,
          ),

          // Features Info Container
          CharacterFeaturesInfoContainer(character: character),

          ResponsiveUtils.responsiveVerticalSpace(
            context,
            mobileHeight: 12,
            tabletHeight: 16,
            desktopHeight: 20,
          ),

          // Feature Icons
          CharacterFeaturesIconsRow(character: character),

          // Spazio per bilanciare il layout
          const Spacer(),
        ],
      ),
    );
  }
}