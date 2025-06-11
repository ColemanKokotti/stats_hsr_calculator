import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../bloc/Login_Cubit/login_cubit.dart';
import '../../../../bloc/Login_Cubit/login_state.dart';
import '../../castom_auth_widgets/custom_text_field.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return Form(
          child: Column(
            children: [
              CustomTextField(
                labelText: 'Email',
                prefixIcon: Icons.email,
                keyboardType: TextInputType.emailAddress,
                initialValue: state.email,
                onChanged: (value) => context.read<LoginCubit>().updateEmail(value),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CustomTextField(
                labelText: 'Password',
                prefixIcon: Icons.lock,
                obscureText: state.obscurePassword,
                initialValue: state.password,
                onChanged: (value) => context.read<LoginCubit>().updatePassword(value),
                suffixIcon: IconButton(
                  icon: Icon(
                    state.obscurePassword ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () => context.read<LoginCubit>().togglePasswordVisibility(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
            ],
          ),
        );
      },
    );
  }
}