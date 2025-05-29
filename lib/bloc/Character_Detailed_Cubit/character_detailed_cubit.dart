import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/api_service.dart';
import '../../data/character_model.dart';
import 'character_detailed_state.dart';

class CharacterDetailCubit extends Cubit<CharacterDetailState> {
  CharacterDetailCubit() : super(const CharacterDetailInitial());

  Future<void> loadCharacter(String characterId) async {
    emit(const CharacterDetailLoading());

    try {
      final character = await ApiService.getCharacterById(characterId);
      emit(CharacterDetailLoaded(character));
    } catch (e) {
      emit(CharacterDetailError(e.toString()));
    }
  }

  void loadCharacterFromData(Character character) {
    emit(CharacterDetailLoaded(character));
  }
}
