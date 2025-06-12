import 'package:equatable/equatable.dart';
import '../../data/character_model.dart';

abstract class MyCharactersListState extends Equatable {
  const MyCharactersListState();

  @override
  List<Object?> get props => [];
}

class MyCharactersListInitial extends MyCharactersListState {
  const MyCharactersListInitial();
}

class MyCharactersListLoading extends MyCharactersListState {
  const MyCharactersListLoading();
}

class MyCharactersListLoaded extends MyCharactersListState {
  final List<Character> myCharacters;

  const MyCharactersListLoaded({
    required this.myCharacters,
  });

  @override
  List<Object?> get props => [myCharacters];
}

class MyCharactersListError extends MyCharactersListState {
  final String message;

  const MyCharactersListError(this.message);

  @override
  List<Object?> get props => [message];
}