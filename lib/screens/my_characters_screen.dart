import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../themes/firefly_theme.dart';
import '../bloc/MyCharacters_Cubit/my_characters_cubit.dart';
import '../bloc/MyCharacters_Cubit/my_characters_state.dart';
import '../widgets/my_characters_widgets/character_selection_grid.dart';
import '../widgets/my_characters_widgets/my_characters_list.dart';


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
        title:  FireflyTheme.gradientText(
          'My Characters',
          gradient: FireflyTheme.eyesGradient,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.auto_stories,
                color: FireflyTheme.turquoise,
                size: 24,
              ),
              const SizedBox(width: 8),
              Text(
                'Character Collection',
                style: TextStyle(
                  color: FireflyTheme.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
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
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.save_alt,
                    color: FireflyTheme.white,
                    size: 20,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Save Collection (${state.selectedCharacterIds.length})',
                    style: TextStyle(
                      color: FireflyTheme.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
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