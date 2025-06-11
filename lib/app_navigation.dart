import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:help_project/screens/auth_screen.dart';
import 'package:help_project/screens/navigation_screen.dart';
import 'package:help_project/screens/splash_screen.dart';
import 'bloc/Auth_Cubit/auth_cubit.dart';
import 'bloc/Auth_Cubit/auth_state.dart';

class AppNavigator extends StatelessWidget {
  const AppNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is AuthInitial || state is AuthLoading) {
          return const SplashScreen();
        } else if (state is AuthAuthenticated) {
          return const NavigationScreen();
        } else {
          return const AuthScreen();
        }
      },
    );
  }
}