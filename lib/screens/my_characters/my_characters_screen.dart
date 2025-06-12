import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../themes/firefly_theme.dart';
import '../../bloc/MyCharacters_Cubit/my_characters_cubit.dart';
import '../../bloc/MyCharacters_Cubit/my_characters_state.dart';
import 'widgets/my_characters_list.dart';
import 'widgets/character_selection_grid.dart';

class MyCharactersScreen extends StatelessWidget {
  const MyCharactersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MyCharactersCubit()..loadData(),
      child: const _MyCharactersScreenContent(),
    );
  }
}

class _MyCharactersScreenContent extends StatelessWidget {
  const _MyCharactersScreenContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Characters'),
        backgroundColor: FireflyTheme.jacket,
      ),
      body: Container(
        decoration: BoxDecoration(gradient: FireflyTheme.backgroundGradient),
        child: BlocConsumer<MyCharactersCubit, MyCharactersState>(
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
            if (state is MyCharactersLoading || state is MyCharactersInitial || state is MyCharactersSaving) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is MyCharactersLoaded) {
              return state.isFirstVisit
                  ? _buildCharacterSelectionScreen(context, state)
                  : _buildMyCharactersScreen(context, state);
            } else {
              return const Center(
                child: Text(
                  'Something went wrong',
                  style: TextStyle(color: Colors.white),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildCharacterSelectionScreen(BuildContext context, MyCharactersLoaded state) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Select your characters',
            style: TextStyle(
              color: FireflyTheme.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: CharacterSelectionGrid(
            characters: state.allCharacters,
            selectedCharacterIds: state.selectedCharacterIds,
            onToggleSelection: (characterId) {
              context.read<MyCharactersCubit>().toggleCharacterSelection(characterId);
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: state.selectedCharacterIds.isNotEmpty 
                  ? () => context.read<MyCharactersCubit>().saveSelectedCharacters()
                  : null,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: FireflyTheme.turquoise,
              ),
              child: const Text('Save Selected Characters'),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMyCharactersScreen(BuildContext context, MyCharactersLoaded state) {
    return Column(
      children: [
        Expanded(
          child: MyCharactersList(
            selectedCharacterIds: state.selectedCharacterIds,
            onAddCharacter: () {
              context.read<MyCharactersCubit>().navigateToCharacterSelection();
            },
          ),
        ),
      ],
    );
  }
}