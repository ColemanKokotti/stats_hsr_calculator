import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/MyCharacters_Cubit/my_characters_cubit.dart';
import '../../bloc/MyCharacters_Cubit/my_characters_state.dart';
import 'character_selection_view.dart';
import 'my_characters_view.dart';

class MyCharactersContent extends StatelessWidget {
  const MyCharactersContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MyCharactersCubit, MyCharactersState>(
      listener: (context, state) {
        if (state is MyCharactersError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is MyCharactersLoading || 
            state is MyCharactersInitial || 
            state is MyCharactersSaving) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is MyCharactersLoaded) {
          return state.isFirstVisit
              ? CharacterSelectionView(
                  allCharacters: state.allCharacters,
                  selectedCharacterIds: state.selectedCharacterIds,
                )
              : MyCharactersView(
                  selectedCharacterIds: state.selectedCharacterIds,
                );
        } else {
          return const Center(
            child: Text(
              'Something went wrong',
              style: TextStyle(color: Colors.white),
            ),
          );
        }
      },
    );
  }
}