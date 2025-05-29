import 'package:flutter_bloc/flutter_bloc.dart';

import 'filter_state.dart';

class FilterCubit extends Cubit<FilterState> {
  FilterCubit() : super(const FilterState());

  void showRarityDialog() {
    emit(state.copyWith(activeDialog: DialogType.rarity));
  }

  void showElementDialog() {
    emit(state.copyWith(activeDialog: DialogType.element));
  }

  void showPathDialog() {
    emit(state.copyWith(activeDialog: DialogType.path));
  }

  void hideDialog() {
    emit(state.copyWith(activeDialog: DialogType.none));
  }
}