import 'package:flutter_bloc/flutter_bloc.dart';

class PasswordFormCubit extends Cubit<PasswordFormState> {
  PasswordFormCubit() : super(const PasswordFormState());

  void toggleExpansion() {
    emit(state.copyWith(isExpanded: !state.isExpanded));
  }

  void toggleCurrentPasswordVisibility() {
    emit(state.copyWith(obscureCurrentPassword: !state.obscureCurrentPassword));
  }

  void toggleNewPasswordVisibility() {
    emit(state.copyWith(obscureNewPassword: !state.obscureNewPassword));
  }

  void toggleConfirmPasswordVisibility() {
    emit(state.copyWith(obscureConfirmPassword: !state.obscureConfirmPassword));
  }

  void closeSection() {
    emit(state.copyWith(isExpanded: false));
  }
}

class PasswordFormState {
  final bool isExpanded;
  final bool obscureCurrentPassword;
  final bool obscureNewPassword;
  final bool obscureConfirmPassword;

  const PasswordFormState({
    this.isExpanded = false,
    this.obscureCurrentPassword = true,
    this.obscureNewPassword = true,
    this.obscureConfirmPassword = true,
  });

  PasswordFormState copyWith({
    bool? isExpanded,
    bool? obscureCurrentPassword,
    bool? obscureNewPassword,
    bool? obscureConfirmPassword,
  }) {
    return PasswordFormState(
      isExpanded: isExpanded ?? this.isExpanded,
      obscureCurrentPassword: obscureCurrentPassword ?? this.obscureCurrentPassword,
      obscureNewPassword: obscureNewPassword ?? this.obscureNewPassword,
      obscureConfirmPassword: obscureConfirmPassword ?? this.obscureConfirmPassword,
    );
  }
}