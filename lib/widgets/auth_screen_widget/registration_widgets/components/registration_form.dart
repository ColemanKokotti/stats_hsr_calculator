import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../bloc/Registration_Cubit/register_cubit.dart';
import '../../../../bloc/Registration_Cubit/register_state.dart';
import '../../castom_auth_widgets/custom_text_field.dart';


class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state) {
        return Form(
          child: Column(
            children: [
              CustomTextField(
                labelText: 'Email',
                prefixIcon: Icons.email,
                keyboardType: TextInputType.emailAddress,
                initialValue: state.email,
                onChanged: (value) => context.read<RegisterCubit>().updateEmail(value),
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
                onChanged: (value) => context.read<RegisterCubit>().updatePassword(value),
                suffixIcon: IconButton(
                  icon: Icon(
                    state.obscurePassword ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () => context.read<RegisterCubit>().togglePasswordVisibility(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CustomTextField(
                labelText: 'Confirm Password',
                prefixIcon: Icons.lock_outline,
                obscureText: state.obscureConfirmPassword,
                initialValue: state.confirmPassword,
                onChanged: (value) => context.read<RegisterCubit>().updateConfirmPassword(value),
                suffixIcon: IconButton(
                  icon: Icon(
                    state.obscureConfirmPassword ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () => context.read<RegisterCubit>().toggleConfirmPasswordVisibility(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your password';
                  }
                  if (value != state.password) {
                    return 'Passwords do not match';
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