import 'package:equatable/equatable.dart';

class FavoritesState extends Equatable {
  final Set<String> favoriteIds;

  const FavoritesState({required this.favoriteIds});

  FavoritesState copyWith({Set<String>? favoriteIds}) {
    return FavoritesState(
      favoriteIds: favoriteIds ?? this.favoriteIds,
    );
  }

  @override
  List<Object> get props => [favoriteIds];
}
