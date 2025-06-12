import 'package:flutter/material.dart';
import '../../data/character_model.dart';
import 'character_app_bar.dart';
import 'character_info_container.dart';
import 'character_portrait_widget.dart';

class CharacterContentWidget extends StatelessWidget {
  final Character character;

  const CharacterContentWidget({
    super.key,
    required this.character,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // App Bar con nome e icona
        CharacterAppBar(character: character),
        
        // Content
        SliverToBoxAdapter(
          child: Column(
            children: [
              const SizedBox(height: 32),
              // Portrait centrale
              Center(
                child: CharacterPortraitWidget(
                  character: character,
                  size: 250,
                ),
              ),
              const SizedBox(height: 32),
              // Container con informazioni
              CharacterInfoContainerWidget(
                character: character,
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ],
    );
  }
}