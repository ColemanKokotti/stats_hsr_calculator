import 'package:flutter_bloc/flutter_bloc.dart';

class UsernameFormCubit extends Cubit<UsernameFormState> {
  UsernameFormCubit() : super(const UsernameFormState());

  void toggleExpansion() {
    emit(state.copyWith(isExpanded: !state.isExpanded));
  }

  void closeSection() {
    emit(state.copyWith(isExpanded: false));
  }
}

class UsernameFormState {
  final bool isExpanded;

  const UsernameFormState({
    this.isExpanded = false,
  });

  UsernameFormState copyWith({
    bool? isExpanded,
  }) {
    return UsernameFormState(
      isExpanded: isExpanded ?? this.isExpanded,
    );
  }
}