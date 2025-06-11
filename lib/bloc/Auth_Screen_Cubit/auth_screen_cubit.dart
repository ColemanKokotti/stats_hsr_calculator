import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_screen_state.dart';

class AuthScreenCubit extends Cubit<AuthScreenState> {
  AuthScreenCubit() : super(const AuthScreenState());

  void toggleAuthMode() {
    emit(state.copyWith(
      isLogin: !state.isLogin,
      animationKey: state.animationKey + 1,
    ));
  }

  void handleGuestLogin() {
  }
}