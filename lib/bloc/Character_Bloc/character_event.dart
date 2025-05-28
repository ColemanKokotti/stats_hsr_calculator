// lib/blocs/character/character_event.dart
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

class ToggleFavorite extends CharacterEvent {
  final String characterId;

  const ToggleFavorite(this.characterId);

  @override
  List<Object?> get props => [characterId];
}

class FilterCharacters extends CharacterEvent {
  final String? element;
  final String? path;
  final int? rarity;
  final bool? favoritesOnly;

  const FilterCharacters({
    this.element,
    this.path,
    this.rarity,
    this.favoritesOnly,
  });

  @override
  List<Object?> get props => [element, path, rarity, favoritesOnly];
}

class SearchCharacters extends CharacterEvent {
  final String query;

  const SearchCharacters(this.query);

  @override
  List<Object?> get props => [query];
}