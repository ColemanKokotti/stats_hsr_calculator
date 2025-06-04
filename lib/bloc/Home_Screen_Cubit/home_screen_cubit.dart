import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'home_screen_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final TextEditingController searchController = TextEditingController();

  HomeCubit() : super(const HomeState()) {
    // Sincronizza il controller con lo stato iniziale
    searchController.addListener(_onControllerChanged);
  }

  void _onControllerChanged() {
    // Aggiorna lo stato solo se diverso dal controller
    if (state.searchQuery != searchController.text) {
      emit(state.copyWith(searchQuery: searchController.text));
    }
  }

  void updateSearchQuery(String query) {
    // Aggiorna il controller se diverso
    if (searchController.text != query) {
      searchController.text = query;
    }
    emit(state.copyWith(searchQuery: query));
  }

  void clearSearch() {
    searchController.clear(); // Questo triggererà automaticamente _onControllerChanged
  }

  @override
  Future<void> close() {
    searchController.removeListener(_onControllerChanged);
    searchController.dispose();
    return super.close();
  }
}