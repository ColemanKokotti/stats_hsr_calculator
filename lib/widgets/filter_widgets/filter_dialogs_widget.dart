import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/Character_Bloc/character_bloc.dart';
import '../../bloc/Character_Bloc/character_event.dart';
import '../../bloc/Character_Bloc/character_state.dart';
import '../../bloc/Filter_Cubit/filter_cubit.dart';
import '../../bloc/Filter_Cubit/filter_state.dart';
import '../../data/character_feature.dart';
import '../../themes/firefly_theme.dart';

class FilterDialogsWidget extends StatelessWidget {
  const FilterDialogsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FilterCubit, FilterState>(
      listener: (context, filterState) {
        final characterState = context.read<CharacterBloc>().state;
        if (characterState is! CharacterLoaded) return;

        switch (filterState.activeDialog) {
          case DialogType.rarity:
            _showRarityDialog(context, characterState.selectedRarity);
            break;
          case DialogType.element:
            _showElementDialog(context, characterState);
            break;
          case DialogType.path:
            _showPathDialog(context, characterState);
            break;
          case DialogType.none:
            break;
        }
      },
      builder: (context, state) {
        return const SizedBox.shrink();
      },
    );
  }

  void _showRarityDialog(BuildContext context, int? currentRarity) {
    showDialog(
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

  void _showElementDialog(BuildContext context, CharacterLoaded state) {
    final elements = state.characters
        .map((c) => c.element)
        .where((e) => e.isNotEmpty)
        .toSet()
        .toList()
      ..sort();

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: FireflyTheme.jacket,
        title: Text(
          'Select Element',
          style: TextStyle(color: FireflyTheme.white),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (state.selectedElement != null)
                ListTile(
                  title: Text('Clear Filter', style: TextStyle(color: FireflyTheme.white)),
                  leading: Icon(Icons.clear, color: FireflyTheme.turquoise),
                  onTap: () {
                    context.read<CharacterBloc>().add(const FilterCharacters(element: null));
                    context.read<FilterCubit>().hideDialog();
                    Navigator.pop(dialogContext);
                  },
                ),
              ...elements.map((element) => ListTile(
                title: Text(element, style: TextStyle(color: FireflyTheme.white)),
                leading: Container(
                  width: 24,
                  height: 24,
                  child: ChararcterAssets.hasElementIcon(element)
                      ? Image.asset(
                    ChararcterAssets.getElementIcon(element),
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        decoration: BoxDecoration(
                          color: ChararcterAssets.getFactionColor(element),
                          shape: BoxShape.circle,
                        ),
                      );
                    },
                  )
                      : Container(
                    decoration: BoxDecoration(
                      color: ChararcterAssets.getFactionColor(element),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                selected: state.selectedElement == element,
                selectedColor: FireflyTheme.turquoise,
                onTap: () {
                  context.read<CharacterBloc>().add(FilterCharacters(element: element));
                  context.read<FilterCubit>().hideDialog();
                  Navigator.pop(dialogContext);
                },
              )),
            ],
          ),
        ),
      ),
    ).then((_) => context.read<FilterCubit>().hideDialog());
  }

  void _showPathDialog(BuildContext context, CharacterLoaded state) {
    final paths = state.characters
        .map((c) => c.pathName)
        .where((p) => p.isNotEmpty)
        .toSet()
        .toList()
      ..sort();

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: FireflyTheme.jacket,
        title: Text(
          'Select Path',
          style: TextStyle(color: FireflyTheme.white),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (state.selectedPath != null)
                ListTile(
                  title: Text('Clear Filter', style: TextStyle(color: FireflyTheme.white)),
                  leading: Icon(Icons.clear, color: FireflyTheme.turquoise),
                  onTap: () {
                    context.read<CharacterBloc>().add(const FilterCharacters(path: null));
                    context.read<FilterCubit>().hideDialog();
                    Navigator.pop(dialogContext);
                  },
                ),
              ...paths.map((path) => ListTile(
                title: Text(path, style: TextStyle(color: FireflyTheme.white)),
                leading: SizedBox(
                  width: 24,
                  height: 24,
                  child: ChararcterAssets.hasPathIcon(path)
                      ? Image.asset(
                    ChararcterAssets.getPathIcon(path),
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(
                        Icons.category,
                        color: ChararcterAssets.getPathColor(path),
                        size: 20,
                      );
                    },
                  )
                      : Icon(
                    Icons.category,
                    color: ChararcterAssets.getPathColor(path),
                    size: 20,
                  ),
                ),
                selected: state.selectedPath == path,
                selectedColor: FireflyTheme.turquoise,
                onTap: () {
                  context.read<CharacterBloc>().add(FilterCharacters(path: path));
                  context.read<FilterCubit>().hideDialog();
                  Navigator.pop(dialogContext);
                },
              )),
            ],
          ),
        ),
      ),
    ).then((_) => context.read<FilterCubit>().hideDialog());
  }

  Color _getRarityColor(int rarity) {
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