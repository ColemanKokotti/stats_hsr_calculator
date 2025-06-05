// lib/widgets/filter_widgets/rarity_dialog.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/Character_Bloc/character_bloc.dart';
import '../../bloc/Character_Bloc/character_event.dart';
import '../../bloc/Filter_Cubit/filter_cubit.dart';
import '../../themes/firefly_theme.dart';

class RarityDialog {
  static Future<void> show(BuildContext context, int? currentRarity) {
    return showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: FireflyTheme.jacket,
        title: Text(
          'Select Rarity',
          style: TextStyle(color: FireflyTheme.white),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (currentRarity != null)
              ListTile(
                title: Text('Clear Filter', style: TextStyle(color: FireflyTheme.white)),
                leading: Icon(Icons.clear, color: FireflyTheme.turquoise),
                onTap: () {
                  context.read<CharacterBloc>().add(const FilterCharacters(rarity: null));
                  context.read<FilterCubit>().hideDialog();
                  Navigator.pop(dialogContext);
                },
              ),
            ...List.generate(3, (index) {
              final rarity = 5 - index;
              return ListTile(
                title: Row(
                  children: [
                    Text('$rarity Star', style: TextStyle(color: FireflyTheme.white)),
                    const SizedBox(width: 8),
                    ...List.generate(rarity, (i) => Icon(
                      Icons.star,
                      color: _getRarityColor(rarity),
                      size: 16,
                    )),
                  ],
                ),
                selected: currentRarity == rarity,
                selectedColor: FireflyTheme.turquoise,
                onTap: () {
                  context.read<CharacterBloc>().add(FilterCharacters(rarity: rarity));
                  context.read<FilterCubit>().hideDialog();
                  Navigator.pop(dialogContext);
                },
              );
            }),
          ],
        ),
      ),
    ).then((_) => context.read<FilterCubit>().hideDialog());
  }

  static Color _getRarityColor(int rarity) {
    switch (rarity) {
      case 5:
        return const Color(0xFFFFD700);
      case 4:
        return const Color(0xFFB19CD9);
      case 3:
        return const Color(0xFF4FC3F7);
      default:
        return FireflyTheme.white;
    }
  }
}