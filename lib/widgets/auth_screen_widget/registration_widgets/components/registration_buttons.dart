import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../bloc/Auth_Cubit/auth_cubit.dart';
import '../../../../bloc/Auth_Cubit/auth_state.dart';
import '../../../../bloc/Registration_Cubit/register_cubit.dart';
import '../../../../bloc/Registration_Cubit/register_state.dart';
import '../../castom_auth_widgets/custom_elevated_button.dart';


class RegisterButton extends StatelessWidget {
  const RegisterButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, authState) {
        return BlocBuilder<RegisterCubit, RegisterState>(
          builder: (context, registerState) {
            return CustomElevatedButton(
              onPressed: authState is AuthLoading
                  ? null
                  : () {
                context.read<AuthCubit>().registerWithEmailAndPassword(
                  email: registerState.email,
                  password: registerState.password,
                  confirmPassword: registerState.confirmPassword,
                );
              },
              isLoading: authState is AuthLoading,
              text: 'Register',
            );
          },
        );
      },
    );
  }
}