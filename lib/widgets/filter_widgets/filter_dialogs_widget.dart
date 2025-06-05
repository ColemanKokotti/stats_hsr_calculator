import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:help_project/widgets/filter_widgets/path_dialog_widget.dart';
import 'package:help_project/widgets/filter_widgets/rarity_dialog_widget.dart';
import '../../bloc/Character_Bloc/character_bloc.dart';
import '../../bloc/Character_Bloc/character_state.dart';
import '../../bloc/Filter_Cubit/filter_cubit.dart';
import '../../bloc/Filter_Cubit/filter_state.dart';
import 'element_dialog_widget.dart';

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
            RarityDialog.show(context, characterState.selectedRarity);
            break;
          case DialogType.element:
            ElementDialog.show(context, characterState);
            break;
          case DialogType.path:
            PathDialog.show(context, characterState);
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
}