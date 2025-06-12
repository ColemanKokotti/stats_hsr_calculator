import 'package:equatable/equatable.dart';

class ProfileSetupState extends Equatable {
  final String username;
  final bool isSubmitting;
  final String? errorMessage;

  const ProfileSetupState({
    required this.username,
    required this.isSubmitting,
    this.errorMessage,
  });

  factory ProfileSetupState.initial() {
    return const ProfileSetupState(
      username: '',
      isSubmitting: false,
      errorMessage: null,
    );
  }

  ProfileSetupState copyWith({
    String? username,
    bool? isSubmitting,
    String? errorMessage,
  }) {
    return ProfileSetupState(
      username: username ?? this.username,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [username, isSubmitting, errorMessage];
}