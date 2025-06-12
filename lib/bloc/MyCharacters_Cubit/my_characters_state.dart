import 'package:equatable/equatable.dart';
import '../../data/character_model.dart';

abstract class MyCharactersState extends Equatable {
  const MyCharactersState();

  @override
  List<Object?> get props => [];
}

class MyCharactersInitial extends MyCharactersState {
  const MyCharactersInitial();
}

class MyCharactersLoading extends MyCharactersState {
  const MyCharactersLoading();
}

class MyCharactersLoaded extends MyCharactersState {
  final List<Character> allCharacters;
  final List<String> selectedCharacterIds;
  final bool isFirstVisit;

  const MyCharactersLoaded({
    required this.allCharacters,
    required this.selectedCharacterIds,
    required this.isFirstVisit,
  });

  @override
  List<Object?> get props => [allCharacters, selectedCharacterIds, isFirstVisit];

  MyCharactersLoaded copyWith({
    List<Character>? allCharacters,
    List<String>? selectedCharacterIds,
    bool? isFirstVisit,
  }) {
    return MyCharactersLoaded(
      allCharacters: allCharacters ?? this.allCharacters,
      selectedCharacterIds: selectedCharacterIds ?? this.selectedCharacterIds,
      isFirstVisit: isFirstVisit ?? this.isFirstVisit,
    );
  }
}

class MyCharactersError extends MyCharactersState {
  final String message;

  const MyCharactersError(this.message);

  @override
  List<Object?> get props => [message];
}

class MyCharactersSaving extends MyCharactersState {
  const MyCharactersSaving();
}

class MyCharactersSaved extends MyCharactersState {
  const MyCharactersSaved();
}