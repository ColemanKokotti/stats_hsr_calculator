import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/MyCharacters_Cubit/my_characters_cubit.dart';
import '../../data/character_model.dart';
import 'character_collection_header.dart';
import 'character_selection_grid.dart';
import 'save_collection_button.dart';

class CharacterSelectionView extends StatelessWidget {
  final List<Character> allCharacters;
  final Set<String> selectedCharacterIds;

  const CharacterSelectionView({
    super.key,
    required this.allCharacters,
    required this.selectedCharacterIds,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(child:Column(
      children: [
        Row(children: [
          const CharacterCollectionHeader(),
          const Spacer(),
          SaveCollectionButton(selectedCharacterIds: selectedCharacterIds),
        ],),
        Expanded(
          child: CharacterSelectionGrid(
            characters: allCharacters,
            selectedCharacterIds: selectedCharacterIds,
            onToggleSelection: (characterId) {
              context.read<MyCharactersCubit>().toggleCharacterSelection(characterId);
            },
          ),
        ),
      ],
    ),) ;
  }
}