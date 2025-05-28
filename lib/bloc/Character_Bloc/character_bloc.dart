// lib/blocs/character/character_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/api_service.dart';
import '../../data/character_model.dart';
import 'character_event.dart';
import 'character_state.dart';

class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  List<Character> _allCharacters = [];
  final Set<String> _favoriteIds = {};

  CharacterBloc() : super(const CharacterInitial()) {
    on<LoadCharacters>(_onLoadCharacters);
    on<RefreshCharacters>(_onRefreshCharacters);
    on<ToggleFavorite>(_onToggleFavorite);
    on<FilterCharacters>(_onFilterCharacters);
    on<SearchCharacters>(_onSearchCharacters);
  }

  Future<void> _onLoadCharacters(
      LoadCharacters event,
      Emitter<CharacterState> emit,
      ) async {
    if (_allCharacters.isEmpty) {
      emit(const CharacterLoading());
    }

    try {
      final characters = await ApiService.getCharacters();
      _allCharacters = characters.map((character) {
        return character.copyWith(
          isFavorite: _favoriteIds.contains(character.id),
        );
      }).toList();

      emit(CharacterLoaded(
        characters: _allCharacters,
        filteredCharacters: _allCharacters,
      ));
    } catch (e) {
      emit(CharacterError(e.toString()));
    }
  }

  Future<void> _onRefreshCharacters(
      RefreshCharacters event,
      Emitter<CharacterState> emit,
      ) async {
    try {
      final characters = await ApiService.getCharacters();
      _allCharacters = characters.map((character) {
        return character.copyWith(
          isFavorite: _favoriteIds.contains(character.id),
        );
      }).toList();

      if (state is CharacterLoaded) {
        final currentState = state as CharacterLoaded;
        final filteredCharacters = _applyFilters(
          _allCharacters,
          currentState.searchQuery,
          currentState.selectedElement,
          currentState.selectedPath,
          currentState.selectedRarity,
          currentState.showFavoritesOnly,
        );

        emit(currentState.copyWith(
          characters: _allCharacters,
          filteredCharacters: filteredCharacters,
        ));
      } else {
        emit(CharacterLoaded(
          characters: _allCharacters,
          filteredCharacters: _allCharacters,
        ));
      }
    } catch (e) {
      emit(CharacterError(e.toString()));
    }
  }

  void _onToggleFavorite(
      ToggleFavorite event,
      Emitter<CharacterState> emit,
      ) {
    if (_favoriteIds.contains(event.characterId)) {
      _favoriteIds.remove(event.characterId);
    } else {
      _favoriteIds.add(event.characterId);
    }

    _updateCharactersFavoriteStatus();

    if (state is CharacterLoaded) {
      final currentState = state as CharacterLoaded;
      final filteredCharacters = _applyFilters(
        _allCharacters,
        currentState.searchQuery,
        currentState.selectedElement,
        currentState.selectedPath,
        currentState.selectedRarity,
        currentState.showFavoritesOnly,
      );

      emit(currentState.copyWith(
        characters: _allCharacters,
        filteredCharacters: filteredCharacters,
      ));
    }
  }

  void _onFilterCharacters(
      FilterCharacters event,
      Emitter<CharacterState> emit,
      ) {
    if (state is CharacterLoaded) {
      final currentState = state as CharacterLoaded;
      final filteredCharacters = _applyFilters(
        _allCharacters,
        currentState.searchQuery,
        event.element,
        event.path,
        event.rarity,
        event.favoritesOnly ?? currentState.showFavoritesOnly,
      );

      emit(currentState.copyWith(
        filteredCharacters: filteredCharacters,
        selectedElement: event.element,
        selectedPath: event.path,
        selectedRarity: event.rarity,
        showFavoritesOnly: event.favoritesOnly ?? currentState.showFavoritesOnly,
      ));
    }
  }

  void _onSearchCharacters(
      SearchCharacters event,
      Emitter<CharacterState> emit,
      ) {
    if (state is CharacterLoaded) {
      final currentState = state as CharacterLoaded;
      final filteredCharacters = _applyFilters(
        _allCharacters,
        event.query,
        currentState.selectedElement,
        currentState.selectedPath,
        currentState.selectedRarity,
        currentState.showFavoritesOnly,
      );

      emit(currentState.copyWith(
        filteredCharacters: filteredCharacters,
        searchQuery: event.query,
      ));
    }
  }

  List<Character> _applyFilters(
      List<Character> characters,
      String searchQuery,
      String? element,
      String? path,
      int? rarity,
      bool showFavoritesOnly,
      ) {
    return characters.where((character) {
      // Search filter
      if (searchQuery.isNotEmpty) {
        if (!character.name.toLowerCase().contains(searchQuery.toLowerCase())) {
          return false;
        }
      }

      // Element filter
      if (element != null && element.isNotEmpty) {
        if (character.element != element) {
          return false;
        }
      }

      // Path filter
      if (path != null && path.isNotEmpty) {
        if (character.pathName != path) {
          return false;
        }
      }

      // Rarity filter
      if (rarity != null) {
        if (character.rarity != rarity) {
          return false;
        }
      }

      // Favorites filter
      if (showFavoritesOnly) {
        if (!character.isFavorite) {
          return false;
        }
      }

      return true;
    }).toList();
  }

  void _updateCharactersFavoriteStatus() {
    _allCharacters = _allCharacters.map((character) {
      return character.copyWith(
        isFavorite: _favoriteIds.contains(character.id),
      );
    }).toList();
  }
}