import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/Character_Bloc/character_bloc.dart';
import '../../bloc/Character_Bloc/character_state.dart';
import '../../bloc/Filter_Cubit/filter_cubit.dart';
import 'clear_filters_button_widget.dart';
import 'filter_chip_widget.dart';
import 'filter_dialogs_widget.dart';

class CharacterFilters extends StatelessWidget {
  const CharacterFilters({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FilterCubit(),
      child: const _CharacterFiltersContent(),
    );
  }
}

class _CharacterFiltersContent extends StatelessWidget {
  const _CharacterFiltersContent();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CharacterBloc, CharacterState>(
      builder: (context, state) {
        if (state is! CharacterLoaded) return const SizedBox.shrink();

        final hasActiveFilters = state.selectedRarity != null ||
            state.selectedElement != null ||
            state.selectedPath != null;

        return Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    // Filtro Rarità
                    FilterChipWidget(
                      label: state.selectedRarity != null ? '${state.selectedRarity}★' : 'Rarity',
                      isSelected: state.selectedRarity != null,
                      onTap: () => context.read<FilterCubit>().showRarityDialog(),
                    ),
                    const SizedBox(width: 8),
                    // Filtro Elemento
                    FilterChipWidget(
                      label: state.selectedElement ?? 'Element',
                      isSelected: state.selectedElement != null,
                      onTap: () => context.read<FilterCubit>().showElementDialog(),
                    ),
                    const SizedBox(width: 8),
                    // Filtro Path
                    FilterChipWidget(
                      label: state.selectedPath ?? 'Path',
                      isSelected: state.selectedPath != null,
                      onTap: () => context.read<FilterCubit>().showPathDialog(),
                    ),
                    const SizedBox(width: 8),
                    // Pulsante Clear Filters
                    if (hasActiveFilters)
                      const ClearFiltersButton(),
                  ],
                ),
              ),
            ),
            // Dialogs
            const FilterDialogsWidget(),
          ],
        );
      },
    );
  }
}