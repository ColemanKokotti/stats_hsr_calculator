// lib/widgets/filter_widgets/path_dialog.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/Character_Bloc/character_bloc.dart';
import '../../bloc/Character_Bloc/character_event.dart';
import '../../bloc/Character_Bloc/character_state.dart';
import '../../bloc/Filter_Cubit/filter_cubit.dart';
import '../../data/character_feature.dart';
import '../../themes/firefly_theme.dart';

class PathDialog {
  static Future<void> show(BuildContext context, CharacterLoaded state) {
    final paths = state.characters
        .map((c) => c.pathName)
        .where((p) => p.isNotEmpty)
        .toSet()
        .toList()
      ..sort();

    return showDialog(
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
}