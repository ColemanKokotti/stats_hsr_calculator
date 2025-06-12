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
    // This method is now handled directly in the AnimatedAuthForm widget
    // through the AuthCubit.signInAsGuest() method
  }
}