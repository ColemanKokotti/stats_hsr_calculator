import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/Auth_Cubit/auth_cubit.dart';
import '../../../bloc/Auth_Cubit/auth_state.dart';
import '../../../bloc/login_cubit/login_cubit.dart';
import 'components/login_buttons.dart';
import 'components/login_footer.dart';
import 'components/login_form.dart';
import 'components/login_header.dart';


class LoginWidget extends StatelessWidget {
  final VoidCallback onSwitchToRegister;
  final VoidCallback onGuestLogin;

  const LoginWidget({
    super.key,
    required this.onSwitchToRegister,
    required this.onGuestLogin,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const LoginHeader(),
            const SizedBox(height: 32),
            const LoginForm(),
            const SizedBox(height: 24),
            LoginButtons(onGuestLogin: onGuestLogin),
            const SizedBox(height: 16),
            LoginFooter(onSwitchToRegister: onSwitchToRegister),
          ],
        ),
      ),
    );
  }
}