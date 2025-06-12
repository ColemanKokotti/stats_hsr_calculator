import 'package:equatable/equatable.dart';

class ProfilePictureState extends Equatable {
  final List<String> allProfilePictures;
  final String selectedProfilePicture;
  final int currentPage;
  final int itemsPerPage;
  final int totalPages;

  const ProfilePictureState({
    required this.allProfilePictures,
    required this.selectedProfilePicture,
    required this.currentPage,
    required this.itemsPerPage,
    required this.totalPages,
  });

  factory ProfilePictureState.initial({
    required List<String> allProfilePictures,
    required int itemsPerPage,
  }) {
    final totalPages = (allProfilePictures.length / itemsPerPage).ceil();
    return ProfilePictureState(
      allProfilePictures: allProfilePictures,
      selectedProfilePicture: allProfilePictures.isNotEmpty ? allProfilePictures[0] : '',
      currentPage: 0,
      itemsPerPage: itemsPerPage,
      totalPages: totalPages,
    );
  }

  ProfilePictureState copyWith({
    List<String>? allProfilePictures,
    String? selectedProfilePicture,
    int? currentPage,
    int? itemsPerPage,
    int? totalPages,
  }) {
    return ProfilePictureState(
      allProfilePictures: allProfilePictures ?? this.allProfilePictures,
      selectedProfilePicture: selectedProfilePicture ?? this.selectedProfilePicture,
      currentPage: currentPage ?? this.currentPage,
      itemsPerPage: itemsPerPage ?? this.itemsPerPage,
      totalPages: totalPages ?? this.totalPages,
    );
  }

  @override
  List<Object?> get props => [
        allProfilePictures,
        selectedProfilePicture,
        currentPage,
        itemsPerPage,
        totalPages,
      ];
}