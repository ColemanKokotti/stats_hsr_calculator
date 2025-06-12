import 'package:equatable/equatable.dart';

class FavoritesState extends Equatable {
  final Set<String> favoriteIds;
  final bool isLoading;
  final String? error;

  const FavoritesState({
    required this.favoriteIds, 
    this.isLoading = false,
    this.error,
  });

  FavoritesState copyWith({
    Set<String>? favoriteIds,
    bool? isLoading,
    String? error,
  }) {
    return FavoritesState(
      favoriteIds: favoriteIds ?? this.favoriteIds,
      isLoading: isLoading ?? this.isLoading,
      error: error,  // Pass null to clear the error
    );
  }

  @override
  List<Object?> get props => [favoriteIds, isLoading, error];
}
