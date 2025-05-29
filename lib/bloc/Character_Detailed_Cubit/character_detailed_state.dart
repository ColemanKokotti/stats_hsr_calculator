import 'package:equatable/equatable.dart';
import '../../data/character_model.dart';

abstract class CharacterDetailState extends Equatable {
  const CharacterDetailState();

  @override
  List<Object?> get props => [];
}

class CharacterDetailInitial extends CharacterDetailState {
  const CharacterDetailInitial();
}

class CharacterDetailLoading extends CharacterDetailState {
  const CharacterDetailLoading();
}

class CharacterDetailLoaded extends CharacterDetailState {
  final Character character;

  const CharacterDetailLoaded(this.character);

  @override
  List<Object?> get props => [character];
}

class CharacterDetailError extends CharacterDetailState {
  final String message;

  const CharacterDetailError(this.message);

  @override
  List<Object?> get props => [message];
}
