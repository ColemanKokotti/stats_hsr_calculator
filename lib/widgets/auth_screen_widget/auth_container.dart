import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/Auth_Screen_Cubit/auth_screen_cubit.dart';
import '../../bloc/Auth_Screen_Cubit/auth_screen_state.dart';
import '../../themes/firefly_theme.dart';
import '../animated_auth_form.dart';


class AuthFormContainer extends StatelessWidget {
  const AuthFormContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 400),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: FireflyTheme.cardGradient,
        border: Border.all(
          color: FireflyTheme.jacket.withOpacity(0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: BlocBuilder<AuthScreenCubit, AuthScreenState>(
        builder: (context, state) {
          return AnimatedAuthForm(
            key: ValueKey(state.animationKey),
            isLogin: state.isLogin,
          );
        },
      ),
    );
  }
}