import 'package:flutter_bloc/flutter_bloc.dart';
import 'favorits_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit() : super(const FavoritesState(favoriteIds: {}));

  void toggleFavorite(String characterId) {
    final currentFavorites = Set<String>.from(state.favoriteIds);

    if (currentFavorites.contains(characterId)) {
      currentFavorites.remove(characterId);
    } else {
      currentFavorites.add(characterId);
    }

    emit(state.copyWith(favoriteIds: currentFavorites));
  }

  bool isFavorite(String characterId) {
    return state.favoriteIds.contains(characterId);
  }

  List<String> get favoriteIds => state.favoriteIds.toList();
}