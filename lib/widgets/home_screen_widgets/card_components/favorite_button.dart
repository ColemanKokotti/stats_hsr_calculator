// lib/widgets/home_screen_widgets/card_components/favorite_button.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/Favorits_Cubit/favorits_cubit.dart';
import '../../../bloc/Favorits_Cubit/favorits_state.dart';
import '../../../data/character_model.dart';
import '../../../themes/firefly_theme.dart';

class FavoriteButton extends StatelessWidget {
  final Character character;

  const FavoriteButton({
    super.key,
    required this.character,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesCubit, FavoritesState>(
      builder: (context, state) {
        final isFavorite = state.favoriteIds.contains(character.id);

        return IconButton(
          onPressed: () {
            context.read<FavoritesCubit>().toggleFavorite(character.id);
          },
          icon: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            color: isFavorite ? Colors.red : FireflyTheme.white,
          ),
          tooltip: isFavorite
              ? 'Remove from favorites'
              : 'Add to favorites',
        );
      },
    );
  }
}