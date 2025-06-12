import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/Auth_Cubit/auth_cubit.dart';
import '../bloc/Auth_Cubit/auth_state.dart';
import '../bloc/Auth_Screen_Cubit/auth_screen_cubit.dart';
import '../screens/navigation_screen.dart';
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
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          // Debug print to track auth state changes in the auth screen
          print('Auth state in AuthScreen: $state');
          
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
          }
        },
        builder: (context, state) {
          // If authenticated, navigate to the navigation screen
          if (state is AuthAuthenticated) {
            print('User authenticated, navigating to NavigationScreen');
            // Use a post-frame callback to avoid build during build issues
            WidgetsBinding.instance.addPostFrameCallback((_) {
              // Check if the context is still valid before navigating
              if (context.mounted) {
                try {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const NavigationScreen()),
                  );
                } catch (e) {
                  print('Error navigating to NavigationScreen: $e');
                }
              }
            });
          }
          
          // Show loading indicator when in loading state
          if (state is AuthLoading) {
            return Scaffold(
              body: Container(
                decoration: BoxDecoration(
                  gradient: FireflyTheme.backgroundGradient,
                ),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          }
          
          // Show auth form for all other states
          return Scaffold(
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
          );
        },
      ),
    );
  }
}