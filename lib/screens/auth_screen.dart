import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/Auth_Screen_Cubit/auth_screen_cubit.dart';
import '../themes/firefly_theme.dart';
import '../widgets/auth_screen_widget/auth_container.dart';
import '../widgets/auth_screen_widget/auth_header.dart';


class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthScreenCubit()),
      ],
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: FireflyTheme.backgroundGradient,
          ),
          child: const SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(24.0),
              child: Column(
                children: [
                  SizedBox(height: 40),
                  AuthHeader(),
                  SizedBox(height: 48),
                  AuthFormContainer(),
                  SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}