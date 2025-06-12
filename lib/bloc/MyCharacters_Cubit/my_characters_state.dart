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
  final int currentPage;
  final int charactersPerPage;

  const MyCharactersLoaded({
    required this.allCharacters,
    required this.selectedCharacterIds,
    required this.isFirstVisit,
    this.currentPage = 0,
    this.charactersPerPage = 6,
  });

  int get totalPages => (allCharacters.length / charactersPerPage).ceil();
  
  List<Character> get currentPageCharacters {
    final startIndex = currentPage * charactersPerPage;
    final endIndex = (startIndex + charactersPerPage) > allCharacters.length 
        ? allCharacters.length 
        : startIndex + charactersPerPage;
    
    if (startIndex >= allCharacters.length) {
      return [];
    }
    
    return allCharacters.sublist(startIndex, endIndex);
  }

  @override
  List<Object?> get props => [allCharacters, selectedCharacterIds, isFirstVisit, currentPage, charactersPerPage];

  MyCharactersLoaded copyWith({
    List<Character>? allCharacters,
    List<String>? selectedCharacterIds,
    bool? isFirstVisit,
    int? currentPage,
    int? charactersPerPage,
  }) {
    return MyCharactersLoaded(
      allCharacters: allCharacters ?? this.allCharacters,
      selectedCharacterIds: selectedCharacterIds ?? this.selectedCharacterIds,
      isFirstVisit: isFirstVisit ?? this.isFirstVisit,
      currentPage: currentPage ?? this.currentPage,
      charactersPerPage: charactersPerPage ?? this.charactersPerPage,
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