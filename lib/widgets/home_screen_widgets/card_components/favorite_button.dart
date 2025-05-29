import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/Character_Bloc/character_bloc.dart';
import '../../../bloc/Character_Bloc/character_event.dart';
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
    return IconButton(
      onPressed: () {
        context.read<CharacterBloc>().add(ToggleFavorite(character.id));
      },
      icon: Icon(
        character.isFavorite ? Icons.favorite : Icons.favorite_border,
        color: character.isFavorite ? Colors.red : FireflyTheme.white,
      ),
      tooltip: character.isFavorite
          ? 'Remove from favorites'
          : 'Add to favorites',
    );
  }
}