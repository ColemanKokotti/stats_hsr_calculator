import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/MyCharacters_Cubit/my_characters_cubit.dart';
import 'my_characters_list.dart';

class MyCharactersView extends StatelessWidget {
  final Set<String> selectedCharacterIds;

  const MyCharactersView({
    super.key,
    required this.selectedCharacterIds,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: MyCharactersList(
            selectedCharacterIds: selectedCharacterIds,
            onAddCharacter: () {
              context.read<MyCharactersCubit>().navigateToCharacterSelection();
            },
          ),
        ),
      ],
    );
  }
}