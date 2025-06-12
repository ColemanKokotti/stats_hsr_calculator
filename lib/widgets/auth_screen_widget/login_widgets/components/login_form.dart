import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../bloc/Login_Cubit/login_cubit.dart';
import '../../../../bloc/Login_Cubit/login_state.dart';
import '../../castom_auth_widgets/custom_text_field.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

// Creiamo una chiave globale per il form che può essere accessibile da altri widget
final loginFormKey = GlobalKey<FormState>();

class _LoginFormState extends State<LoginForm> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return Form(
          key: loginFormKey,
          child: Column(
            children: [
              CustomTextField(
                labelText: 'Email',
                prefixIcon: Icons.email,
                keyboardType: TextInputType.emailAddress,
                initialValue: state.email,
                onChanged: (value) {
                  // Trim whitespace when updating email
                  context.read<LoginCubit>().updateEmail(value.trim());
                },
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
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters';
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