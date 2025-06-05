// lib/bloc/Character_Bloc/character_event.dart
import 'package:equatable/equatable.dart';

abstract class CharacterEvent extends Equatable {
  const CharacterEvent();

  @override
  List<Object?> get props => [];
}

class LoadCharacters extends CharacterEvent {
  const LoadCharacters();
}

class RefreshCharacters extends CharacterEvent {
  const RefreshCharacters();
}

class FilterCharacters extends CharacterEvent {
  final String? element;
  final String? path;
  final int? rarity;

  const FilterCharacters({
    this.element,
    this.path,
    this.rarity,
  });

  @override
  List<Object?> get props => [element, path, rarity];
}

class SearchCharacters extends CharacterEvent {
  final String query;

  const SearchCharacters(this.query);

  @override
  List<Object?> get props => [query];
}

class ClearAllFilters extends CharacterEvent {
  const ClearAllFilters();
}