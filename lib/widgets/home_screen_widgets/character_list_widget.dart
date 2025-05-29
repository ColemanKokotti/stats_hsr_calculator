import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/Character_Bloc/character_bloc.dart';
import '../../bloc/Character_Bloc/character_event.dart';
import '../../bloc/Character_Bloc/character_state.dart';
import '../../screens/character_detailed_screen.dart';
import '../../themes/firefly_theme.dart';
import 'character_card_widget.dart';


class CharacterListWidget extends StatelessWidget {
  const CharacterListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CharacterBloc, CharacterState>(
      builder: (context, state) {
        if (state is CharacterLoading) {
          return Center(
            child: CircularProgressIndicator(
              color: FireflyTheme.turquoise,
            ),
          );
        }

        if (state is CharacterError) {
          return _buildErrorState(context, state);
        }

        if (state is CharacterLoaded) {
          if (state.filteredCharacters.isEmpty) {
            return _buildEmptyState(context);
          }

          return _buildCharactersList(context, state);
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildErrorState(BuildContext context, CharacterError state) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 64,
            color: Colors.red.withOpacity(0.7),
          ),
          const SizedBox(height: 16),
          Text(
            'Error loading characters',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: FireflyTheme.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            state.message,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: FireflyTheme.white.withOpacity(0.7),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              context.read<CharacterBloc>().add(const LoadCharacters());
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: FireflyTheme.turquoise,
              foregroundColor: FireflyTheme.jacket,
            ),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 64,
            color: FireflyTheme.white.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          Text(
            'No characters found',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: FireflyTheme.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try adjusting your search or filters',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: FireflyTheme.white.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCharactersList(BuildContext context, CharacterLoaded state) {
    return RefreshIndicator(
      color: FireflyTheme.turquoise,
      backgroundColor: FireflyTheme.jacket,
      onRefresh: () async {
        context.read<CharacterBloc>().add(const RefreshCharacters());
      },
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        itemCount: state.filteredCharacters.length,
        itemBuilder: (context, index) {
          final character = state.filteredCharacters[index];
          return CharacterCard(
            character: character,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => CharacterDetailScreen(character: character),
                ),
              );
            },
          );
        },
      ),
    );
  }
}