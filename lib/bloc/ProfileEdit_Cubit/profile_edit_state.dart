import 'package:equatable/equatable.dart';

abstract class ProfileEditState extends Equatable {
  const ProfileEditState();

  @override
  List<Object?> get props => [];
}

class ProfileEditInitial extends ProfileEditState {}

class ProfileEditLoading extends ProfileEditState {}

class ProfileEditSuccess extends ProfileEditState {
  final String message;

  const ProfileEditSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class ProfileEditError extends ProfileEditState {
  final String message;

  const ProfileEditError(this.message);

  @override
  List<Object?> get props => [message];
}