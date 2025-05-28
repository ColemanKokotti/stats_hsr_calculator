// lib/blocs/character/character_state.dart
import 'package:equatable/equatable.dart';
import '../../data/character_model.dart';


abstract class CharacterState extends Equatable {
  const CharacterState();

  @override
  List<Object?> get props => [];
}

class CharacterInitial extends CharacterState {
  const CharacterInitial();
}

class CharacterLoading extends CharacterState {
  const CharacterLoading();
}

class CharacterLoaded extends CharacterState {
  final List<Character> characters;
  final List<Character> filteredCharacters;
  final String searchQuery;
  final String? selectedElement;
  final String? selectedPath;
  final int? selectedRarity;
  final bool showFavoritesOnly;

  const CharacterLoaded({
    required this.characters,
    required this.filteredCharacters,
    this.searchQuery = '',
    this.selectedElement,
    this.selectedPath,
    this.selectedRarity,
    this.showFavoritesOnly = false,
  });

  CharacterLoaded copyWith({
    List<Character>? characters,
    List<Character>? filteredCharacters,
    String? searchQuery,
    String? selectedElement,
    String? selectedPath,
    int? selectedRarity,
    bool? showFavoritesOnly,
  }) {
    return CharacterLoaded(
      characters: characters ?? this.characters,
      filteredCharacters: filteredCharacters ?? this.filteredCharacters,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedElement: selectedElement ?? this.selectedElement,
      selectedPath: selectedPath ?? this.selectedPath,
      selectedRarity: selectedRarity ?? this.selectedRarity,
      showFavoritesOnly: showFavoritesOnly ?? this.showFavoritesOnly,
    );
  }

  @override
  List<Object?> get props => [
    characters,
    filteredCharacters,
    searchQuery,
    selectedElement,
    selectedPath,
    selectedRarity,
    showFavoritesOnly,
  ];
}

class CharacterError extends CharacterState {
  final String message;

  const CharacterError(this.message);

  @override
  List<Object?> get props => [message];
}