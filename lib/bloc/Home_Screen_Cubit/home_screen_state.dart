import 'package:equatable/equatable.dart';

class HomeState extends Equatable {
  final String searchQuery;

  const HomeState({
    this.searchQuery = '',
  });

  HomeState copyWith({
    String? searchQuery,
  }) {
    return HomeState(
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  @override
  List<Object?> get props => [searchQuery];
}