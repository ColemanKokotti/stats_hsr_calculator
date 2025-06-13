import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../firebase_service/firebase_my_characters_service.dart';
import '../../firebase_service/firebase_characters_service.dart';
import 'my_characters_state.dart';

class MyCharactersCubit extends Cubit<MyCharactersState> {
  MyCharactersCubit() : super(const MyCharactersInitial());

  Future<void> loadData() async {
    emit(const MyCharactersLoading());

    try {
      // Check if this is the first visit
      final isFirstVisit = !(await FirebaseMyCharactersService.hasCurrentUserVisitedMyCharactersScreen());
      
      // Get all characters
      final allCharacters = await FirebaseCharactersService.getCharacters();
      
      // Get selected characters
      final selectedCharacterIds = await FirebaseMyCharactersService.getCurrentUserMyCharacters();
      
      emit(MyCharactersLoaded(
        allCharacters: allCharacters,
        selectedCharacterIds: selectedCharacterIds.toSet(),
        isFirstVisit: isFirstVisit,
      ));
    } catch (e) {
      emit(MyCharactersError('Error loading data: $e'));
    }
  }

  void toggleCharacterSelection(String characterId) {
    final currentState = state;
    if (currentState is MyCharactersLoaded) {
      final selectedIds = Set<String>.from(currentState.selectedCharacterIds);
      
      if (selectedIds.contains(characterId)) {
        selectedIds.remove(characterId);
      } else {
        selectedIds.add(characterId);
      }
      
      emit(currentState.copyWith(selectedCharacterIds: selectedIds));
    }
  }
  
  void nextPage() {
    final currentState = state;
    if (currentState is MyCharactersLoaded) {
      final nextPage = currentState.currentPage + 1;
      if (nextPage < currentState.totalPages) {
        emit(currentState.copyWith(currentPage: nextPage));
      }
    }
  }
  
  void previousPage() {
    final currentState = state;
    if (currentState is MyCharactersLoaded) {
      final prevPage = currentState.currentPage - 1;
      if (prevPage >= 0) {
        emit(currentState.copyWith(currentPage: prevPage));
      }
    }
  }
  
  void goToPage(int page) {
    final currentState = state;
    if (currentState is MyCharactersLoaded) {
      if (page >= 0 && page < currentState.totalPages) {
        emit(currentState.copyWith(currentPage: page));
      }
    }
  }

  void navigateToCharacterSelection() {
    final currentState = state;
    if (currentState is MyCharactersLoaded) {
      emit(currentState.copyWith(isFirstVisit: true));
    }
  }

  Future<void> saveSelectedCharacters() async {
    final currentState = state;
    if (currentState is MyCharactersLoaded) {
      emit(const MyCharactersSaving());
      
      try {
        final user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          await FirebaseMyCharactersService.saveMyCharacters(
            user.uid, 
            currentState.selectedCharacterIds.toList()
          );
          await FirebaseMyCharactersService.markCurrentUserMyCharactersScreenAsVisited();
          
          emit(MyCharactersLoaded(
            allCharacters: currentState.allCharacters,
            selectedCharacterIds: currentState.selectedCharacterIds,
            isFirstVisit: false,
          ));
        }
      } catch (e) {
        emit(MyCharactersError('Error saving selected characters: $e'));
        // Restore previous state after error
        emit(currentState);
      }
    }
  }
}