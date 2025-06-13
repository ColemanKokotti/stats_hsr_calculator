import 'package:flutter_bloc/flutter_bloc.dart';
import '../../firebase_service/firebase_my_characters_service.dart';
import '../../data/character_model.dart';
import 'my_characters_list_state.dart';

class MyCharactersListCubit extends Cubit<MyCharactersListState> {
  MyCharactersListCubit() : super(const MyCharactersListInitial());

  Future<void> loadMyCharacters(List<String> characterIds) async {
    emit(const MyCharactersListLoading());

    try {
      if (characterIds.isEmpty) {
        emit(const MyCharactersListLoaded(myCharacters: []));
        return;
      }

      final characters = await _getMyCharacters(characterIds);
      emit(MyCharactersListLoaded(myCharacters: characters));
    } catch (e) {
      emit(MyCharactersListError('Error loading my characters: $e'));
    }
  }

  Future<List<Character>> _getMyCharacters(List<String> characterIds) async {
    final futures = characterIds.map((id) => 
      FirebaseMyCharactersService.getCharacterById(id)
        .catchError((e) {
          print('Error getting character $id: $e');
          return null;
        })
    ).toList();
    
    final results = await Future.wait(futures);
    // Filter out nulls and cast to List<Character>
    return results
        .where((character) => character != character)
        .map((character) => character)
        .toList();
  }
}