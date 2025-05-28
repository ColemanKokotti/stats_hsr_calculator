// lib/widgets/character_filters_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/Character_Bloc/character_bloc.dart';
import '../bloc/Character_Bloc/character_event.dart';
import '../bloc/Character_Bloc/character_state.dart';
import '../themes/firefly_theme.dart';

class CharacterFilters extends StatelessWidget {
  const CharacterFilters({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CharacterBloc, CharacterState>(
      builder: (context, state) {
        if (state is! CharacterLoaded) return const SizedBox.shrink();

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                // Filtro Rarità
                _buildRarityFilter(context, state),
                const SizedBox(width: 8),
                // Filtro Elemento
                _buildElementFilter(context, state),
                const SizedBox(width: 8),
                // Filtro Path
                _buildPathFilter(context, state),
                const SizedBox(width: 8),
                // Filtro Preferiti
                _buildFavoritesFilter(context, state),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildRarityFilter(BuildContext context, CharacterLoaded state) {
    return _FilterChip(
      label: state.selectedRarity != null ? '${state.selectedRarity}★' : 'Rarity',
      isSelected: state.selectedRarity != null,
      onTap: () => _showRarityDialog(context, state.selectedRarity),
    );
  }

  Widget _buildElementFilter(BuildContext context, CharacterLoaded state) {
    return _FilterChip(
      label: state.selectedElement ?? 'Element',
      isSelected: state.selectedElement != null,
      onTap: () => _showElementDialog(context, state),
    );
  }

  Widget _buildPathFilter(BuildContext context, CharacterLoaded state) {
    return _FilterChip(
      label: state.selectedPath ?? 'Path',
      isSelected: state.selectedPath != null,
      onTap: () => _showPathDialog(context, state),
    );
  }

  Widget _buildFavoritesFilter(BuildContext context, CharacterLoaded state) {
    return _FilterChip(
      label: 'Favorites',
      isSelected: state.showFavoritesOnly,
      onTap: () {
        context.read<CharacterBloc>().add(FilterCharacters(
          favoritesOnly: !state.showFavoritesOnly,
        ));
      },
    );
  }

  void _showRarityDialog(BuildContext context, int? currentRarity) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
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
                  Navigator.pop(context);
                },
              ),
            ...List.generate(3, (index) {
              final rarity = 5 - index; // 5, 4, 3
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
                  Navigator.pop(context);
                },
              );
            }),
          ],
        ),
      ),
    );
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
      builder: (context) => AlertDialog(
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
                    Navigator.pop(context);
                  },
                ),
              ...elements.map((element) => ListTile(
                title: Text(element, style: TextStyle(color: FireflyTheme.white)),
                leading: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: _getElementColor(element),
                    shape: BoxShape.circle,
                  ),
                ),
                selected: state.selectedElement == element,
                selectedColor: FireflyTheme.turquoise,
                onTap: () {
                  context.read<CharacterBloc>().add(FilterCharacters(element: element));
                  Navigator.pop(context);
                },
              )),
            ],
          ),
        ),
      ),
    );
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
      builder: (context) => AlertDialog(
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
                    Navigator.pop(context);
                  },
                ),
              ...paths.map((path) => ListTile(
                title: Text(path, style: TextStyle(color: FireflyTheme.white)),
                leading: Icon(Icons.category, color: FireflyTheme.turquoise),
                selected: state.selectedPath == path,
                selectedColor: FireflyTheme.turquoise,
                onTap: () {
                  context.read<CharacterBloc>().add(FilterCharacters(path: path));
                  Navigator.pop(context);
                },
              )),
            ],
          ),
        ),
      ),
    );
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

  Color _getElementColor(String element) {
    switch (element.toLowerCase()) {
      case 'fire':
        return const Color(0xFFFF6B6B);
      case 'ice':
        return const Color(0xFF74C0FC);
      case 'lightning':
        return const Color(0xFFFFD93D);
      case 'wind':
        return const Color(0xFF51CF66);
      case 'physical':
        return const Color(0xFFCED4DA);
      case 'quantum':
        return const Color(0xFF9775FA);
      case 'imaginary':
        return const Color(0xFFFFEC99);
      default:
        return FireflyTheme.white;
    }
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected
              ? FireflyTheme.turquoise
              : FireflyTheme.jacket,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? FireflyTheme.turquoise : FireflyTheme.white.withOpacity(0.3),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? FireflyTheme.turquoise : FireflyTheme.white,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}