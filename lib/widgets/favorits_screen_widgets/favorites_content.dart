import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/Auth_Cubit/auth_state.dart';
import '../../bloc/Character_Bloc/character_bloc.dart';
import '../../bloc/Character_Bloc/character_state.dart';
import '../../bloc/Favorits_Cubit/favorits_cubit.dart';
import '../../bloc/Favorits_Cubit/favorits_state.dart';
import '../../themes/firefly_theme.dart';
import 'empty_favorits_widget.dart';
import 'favorite_character_list.dart';
import 'favorites_error_widget.dart';

class FavoritesContent extends StatelessWidget {
  final AuthAuthenticated authState;

  const FavoritesContent({
    super.key,
    required this.authState,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CharacterBloc, CharacterState>(
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
              // Show loading indicator if favorites are loading
              if (favoritesState.isLoading) {
                return Center(
                  child: CircularProgressIndicator(
                    color: FireflyTheme.turquoise,
                  ),
                );
              }

              // Show error if there's an error loading favorites
              if (favoritesState.error != null) {
                return FavoritesErrorWidget(
                  errorMessage: favoritesState.error!,
                  authState: authState,
                );
              }

              // Filter characters by favorites
              final favoriteCharacters = characterState.characters
                  .where((character) =>
                  favoritesState.favoriteIds.contains(character.id))
                  .toList();

              // Show empty state if no favorites
              if (favoriteCharacters.isEmpty) {
                return const EmptyFavoritesWidget();
              }

              // Show list of favorite characters
              return FavoriteCharactersList(
                favoriteCharacters: favoriteCharacters,
              );
            },
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}