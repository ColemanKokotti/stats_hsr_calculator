// lib/bloc/Character_Bloc/character_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/api_service.dart';
import '../../data/character_model.dart';
import 'character_event.dart';
import 'character_state.dart';

class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  List<Character> _allCharacters = [];

  CharacterBloc() : super(const CharacterInitial()) {
    on<LoadCharacters>(_onLoadCharacters);
    on<RefreshCharacters>(_onRefreshCharacters);
    on<FilterCharacters>(_onFilterCharacters);
    on<SearchCharacters>(_onSearchCharacters);
    on<ClearAllFilters>(_onClearAllFilters);
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
      _allCharacters = characters;

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
      _allCharacters = characters;

      if (state is CharacterLoaded) {
        final currentState = state as CharacterLoaded;
        final filteredCharacters = _applyFilters(
          _allCharacters,
          currentState.searchQuery,
          currentState.selectedElement,
          currentState.selectedPath,
          currentState.selectedRarity,
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

  void _onFilterCharacters(
      FilterCharacters event,
      Emitter<CharacterState> emit,
      ) {
    if (state is CharacterLoaded) {
      final currentState = state as CharacterLoaded;

      // Determina i nuovi valori dei filtri e se devono essere puliti
      String? newElement = currentState.selectedElement;
      String? newPath = currentState.selectedPath;
      int? newRarity = currentState.selectedRarity;

      bool clearElement = false;
      bool clearPath = false;
      bool clearRarity = false;

      // Gestisce l'elemento
      if (event.element != null) {
        if (event.element!.isEmpty) {
          clearElement = true;
          newElement = null;
        } else {
          newElement = event.element;
        }
      }

      // Gestisce il path
      if (event.path != null) {
        if (event.path!.isEmpty) {
          clearPath = true;
          newPath = null;
        } else {
          newPath = event.path;
        }
      }

      // Gestisce la rarità (usa -1 per indicare clear)
      if (event.rarity != null) {
        if (event.rarity == -1) {
          clearRarity = true;
          newRarity = null;
        } else {
          newRarity = event.rarity;
        }
      }

      final filteredCharacters = _applyFilters(
        _allCharacters,
        currentState.searchQuery,
        newElement,
        newPath,
        newRarity,
      );

      emit(currentState.copyWith(
        filteredCharacters: filteredCharacters,
        selectedElement: newElement,
        selectedPath: newPath,
        selectedRarity: newRarity,
        clearElement: clearElement,
        clearPath: clearPath,
        clearRarity: clearRarity,
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
      );

      emit(currentState.copyWith(
        filteredCharacters: filteredCharacters,
        searchQuery: event.query,
      ));
    }
  }

  void _onClearAllFilters(
      ClearAllFilters event,
      Emitter<CharacterState> emit,
      ) {
    if (state is CharacterLoaded) {
      final currentState = state as CharacterLoaded;

      // Mantiene solo la query di ricerca, pulisce i filtri
      final filteredCharacters = _applyFilters(
        _allCharacters,
        currentState.searchQuery, // Mantiene la ricerca
        null, // Pulisce element
        null, // Pulisce path
        null, // Pulisce rarity
      );

      emit(currentState.copyWith(
        filteredCharacters: filteredCharacters,
        selectedElement: null,
        selectedPath: null,
        selectedRarity: null,
        clearElement: true,
        clearPath: true,
        clearRarity: true,
      ));
    }
  }

  List<Character> _applyFilters(
      List<Character> characters,
      String searchQuery,
      String? element,
      String? path,
      int? rarity,
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

      return true;
    }).toList();
  }
}