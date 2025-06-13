import 'package:flutter_bloc/flutter_bloc.dart';

class DeleteAccountCubit extends Cubit<DeleteAccountState> {
  DeleteAccountCubit() : super(const DeleteAccountState());

  void toggleExpansion() {
    emit(state.copyWith(
      isExpanded: !state.isExpanded,
      showConfirmation: !state.isExpanded ? false : state.showConfirmation,
    ));
  }

  void showConfirmation() {
    emit(state.copyWith(showConfirmation: true));
  }

  void hideConfirmation() {
    emit(state.copyWith(showConfirmation: false));
  }

  void togglePasswordVisibility() {
    emit(state.copyWith(obscurePassword: !state.obscurePassword));
  }
}

class DeleteAccountState {
  final bool isExpanded;
  final bool showConfirmation;
  final bool obscurePassword;

  const DeleteAccountState({
    this.isExpanded = false,
    this.showConfirmation = false,
    this.obscurePassword = true,
  });

  DeleteAccountState copyWith({
    bool? isExpanded,
    bool? showConfirmation,
    bool? obscurePassword,
  }) {
    return DeleteAccountState(
      isExpanded: isExpanded ?? this.isExpanded,
      showConfirmation: showConfirmation ?? this.showConfirmation,
      obscurePassword: obscurePassword ?? this.obscurePassword,
    );
  }
}