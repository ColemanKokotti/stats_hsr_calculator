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

  const CharacterLoaded({
    required this.characters,
    required this.filteredCharacters,
    this.searchQuery = '',
    this.selectedElement,
    this.selectedPath,
    this.selectedRarity,
  });

  CharacterLoaded copyWith({
    List<Character>? characters,
    List<Character>? filteredCharacters,
    String? searchQuery,
    String? selectedElement,
    String? selectedPath,
    int? selectedRarity,
    bool clearElement = false,
    bool clearPath = false,
    bool clearRarity = false,
  }) {
    return CharacterLoaded(
      characters: characters ?? this.characters,
      filteredCharacters: filteredCharacters ?? this.filteredCharacters,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedElement: clearElement ? null : (selectedElement ?? this.selectedElement),
      selectedPath: clearPath ? null : (selectedPath ?? this.selectedPath),
      selectedRarity: clearRarity ? null : (selectedRarity ?? this.selectedRarity),
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
  ];
}
class CharacterError extends CharacterState {
  final String message;

  const CharacterError(this.message);

  @override
  List<Object?> get props => [message];
}