import 'package:flutter_bloc/flutter_bloc.dart';
import 'profile_picture_state.dart';

class ProfilePictureCubit extends Cubit<ProfilePictureState> {
  final List<String> allProfilePictures;
  final int itemsPerPage;

  ProfilePictureCubit({
    required this.allProfilePictures,
    this.itemsPerPage = 9,
  }) : super(ProfilePictureState.initial(
          allProfilePictures: allProfilePictures,
          itemsPerPage: itemsPerPage,
        ));

  void selectProfilePicture(String picture) {
    emit(state.copyWith(selectedProfilePicture: picture));
  }

  void nextPage() {
    if (state.currentPage < state.totalPages - 1) {
      emit(state.copyWith(currentPage: state.currentPage + 1));
    }
  }

  void previousPage() {
    if (state.currentPage > 0) {
      emit(state.copyWith(currentPage: state.currentPage - 1));
    }
  }

  void goToPage(int page) {
    if (page >= 0 && page < state.totalPages) {
      emit(state.copyWith(currentPage: page));
    }
  }

  List<String> getCurrentPageItems() {
    final startIndex = state.currentPage * itemsPerPage;
    final endIndex = (startIndex + itemsPerPage) > allProfilePictures.length
        ? allProfilePictures.length
        : startIndex + itemsPerPage;

    return allProfilePictures.sublist(startIndex, endIndex);
  }
}