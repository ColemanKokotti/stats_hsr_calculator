import 'package:equatable/equatable.dart';

class GuestConversionState extends Equatable {
  final String email;
  final String password;
  final String confirmPassword;
  final bool isSubmitting;
  final String? errorMessage;
  final bool isSuccess;

  const GuestConversionState({
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.isSubmitting,
    this.errorMessage,
    required this.isSuccess,
  });

  factory GuestConversionState.initial() {
    return const GuestConversionState(
      email: '',
      password: '',
      confirmPassword: '',
      isSubmitting: false,
      errorMessage: null,
      isSuccess: false,
    );
  }

  GuestConversionState copyWith({
    String? email,
    String? password,
    String? confirmPassword,
    bool? isSubmitting,
    String? errorMessage,
    bool? isSuccess,
  }) {
    return GuestConversionState(
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      errorMessage: errorMessage,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }

  @override
  List<Object?> get props => [
        email,
        password,
        confirmPassword,
        isSubmitting,
        errorMessage,
        isSuccess,
      ];
}