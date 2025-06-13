import 'package:flutter/material.dart';
import '../data/character_model.dart';
import '../themes/firefly_theme.dart';
import '../themes/responsive_utils.dart';
import '../widgets/character_detail_widgets/character_detail_container.dart';

class MyCharacterDetailedScreen extends StatelessWidget {
  final Character character;

  const MyCharacterDetailedScreen({
    super.key,
    required this.character,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FireflyTheme.jacket,
      appBar: AppBar(
        backgroundColor: FireflyTheme.turquoiseDark,
        title: Text(
          character.name,
          style: ResponsiveTextUtils.getTitleLargeStyle(
            context,
            color: FireflyTheme.white,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: FireflyTheme.white,
            size: ResponsiveImageUtils.getMediumIconSize(context),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: ResponsiveUtils.getStandardContainerPadding(context),
        child: CharacterDetailContainer(character: character),
      ),
    );
  }
}