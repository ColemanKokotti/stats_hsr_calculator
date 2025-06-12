import 'package:flutter/material.dart';
import '../../data/character_model.dart';
import '../../themes/firefly_theme.dart';
import 'character_icon_widget.dart';

class CharacterAppBar extends StatelessWidget {
  final Character character;

  const CharacterAppBar({
    super.key,
    required this.character,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      automaticallyImplyLeading: false,
      backgroundColor: FireflyTheme.jacket.withOpacity(0.9),
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          character.name,
          style: TextStyle(
            color: FireflyTheme.white,
            fontWeight: FontWeight.bold,
            fontSize: 12
          ),
        ),
        centerTitle: true,
        titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: CharacterIconWidget(character: character),
        ),
      ],
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: FireflyTheme.white,
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }
}