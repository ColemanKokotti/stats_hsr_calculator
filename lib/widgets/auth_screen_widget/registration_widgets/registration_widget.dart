import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/Auth_Cubit/auth_cubit.dart';
import '../../../bloc/Auth_Cubit/auth_state.dart';
import '../../../bloc/Registration_Cubit/register_cubit.dart';
import 'components/registration_buttons.dart';
import 'components/registration_footer.dart';
import 'components/registration_form.dart';
import 'components/registration_header.dart';


class RegisterWidget extends StatelessWidget {
  final VoidCallback onSwitchToLogin;

  const RegisterWidget({
    super.key,
    required this.onSwitchToLogin,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          } else if (state is AuthRegistrationSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.green,
              ),
            );
            onSwitchToLogin();
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const RegisterHeader(),
            const SizedBox(height: 32),
            const RegisterForm(),
            const SizedBox(height: 24),
            const RegisterButton(),
            const SizedBox(height: 16),
            RegisterFooter(onSwitchToLogin: onSwitchToLogin),
          ],
        ),
      ),
    );
  }
}