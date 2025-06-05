import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/Character_Bloc/character_bloc.dart';
import '../bloc/Character_Bloc/character_state.dart';
import '../bloc/Favorits_Cubit/favorits_cubit.dart';
import '../bloc/Favorits_Cubit/favorits_state.dart';
import '../themes/firefly_theme.dart';
import '../widgets/favorits_screen_widgets/empty_favorits_widget.dart';
import '../widgets/favorits_screen_widgets/favorite_character_list.dart';

class FavoritePgScreen extends StatelessWidget {
  const FavoritePgScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: FireflyTheme.backgroundGradient),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(16),
                child: FireflyTheme.gradientText(
                  'Favorite Characters',
                  gradient: FireflyTheme.eyesGradient,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              // Content
              Expanded(
                child: BlocBuilder<CharacterBloc, CharacterState>(
                  builder: (context, characterState) {
                    if (characterState is CharacterLoading) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: FireflyTheme.turquoise,
                        ),
                      );
                    }

                    if (characterState is CharacterError) {
                      return Center(
                        child: Text(
                          'Error: ${characterState.message}',
                          style: TextStyle(color: FireflyTheme.white),
                        ),
                      );
                    }

                    if (characterState is CharacterLoaded) {
                      return BlocBuilder<FavoritesCubit, FavoritesState>(
                        builder: (context, favoritesState) {

                          final favoriteCharacters = characterState.characters
                              .where((character) =>
                              favoritesState.favoriteIds.contains(character.id))
                              .toList();

                          if (favoriteCharacters.isEmpty) {
                            return const EmptyFavoritesWidget();
                          }

                          return FavoriteCharactersList(
                            favoriteCharacters: favoriteCharacters,
                          );
                        },
                      );
                    }

                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}