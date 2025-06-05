// lib/widgets/filter_widgets/element_dialog.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/Character_Bloc/character_bloc.dart';
import '../../bloc/Character_Bloc/character_event.dart';
import '../../bloc/Character_Bloc/character_state.dart';
import '../../bloc/Filter_Cubit/filter_cubit.dart';
import '../../data/character_feature.dart';
import '../../themes/firefly_theme.dart';

class ElementDialog {
  static Future<void> show(BuildContext context, CharacterLoaded state) {
    final elements = state.characters
        .map((c) => c.element)
        .where((e) => e.isNotEmpty)
        .toSet()
        .toList()
      ..sort();

    return showDialog(
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
}