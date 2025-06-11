import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../bloc/Auth_Cubit/auth_cubit.dart';
import '../../../../bloc/Auth_Cubit/auth_state.dart';
import '../../../../bloc/Login_Cubit/login_cubit.dart';
import '../../../../bloc/Login_Cubit/login_state.dart';
import '../../castom_auth_widgets/custom_elevated_button.dart';
import '../../castom_auth_widgets/custom_outline_button.dart';

class LoginButtons extends StatelessWidget {
  final VoidCallback onGuestLogin;

  const LoginButtons({
    super.key,
    required this.onGuestLogin,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, authState) {
        return BlocBuilder<LoginCubit, LoginState>(
          builder: (context, loginState) {
            return Column(
              children: [
                CustomElevatedButton(
                  onPressed: authState is AuthLoading
                      ? null
                      : () {
                    context.read<AuthCubit>().signInWithEmailAndPassword(
                      email: loginState.email,
                      password: loginState.password,
                    );
                  },
                  isLoading: authState is AuthLoading,
                  text: 'Login',
                ),
                const SizedBox(height: 16),
                CustomOutlinedButton(
                  onPressed: authState is AuthLoading ? null : onGuestLogin,
                  icon: Icons.person_outline,
                  text: 'Continue as Guest',
                ),
              ],
            );
          },
        );
      },
    );
  }
}