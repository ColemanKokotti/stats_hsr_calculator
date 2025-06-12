import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/Auth_Cubit/auth_cubit.dart';
import '../bloc/Auth_Cubit/auth_state.dart';
import '../themes/firefly_theme.dart';
import '../widgets/favorits_screen_widgets/favorites_content.dart';
import '../widgets/favorits_screen_widgets/favorites_header.dart';
import '../widgets/favorits_screen_widgets/unauthenticated_content.dart';

class FavoritePgScreen extends StatelessWidget {
  const FavoritePgScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: FireflyTheme.backgroundGradient),
        child: SafeArea(
          child: Column(
            children: [
              // Header with back button
              const FavoritesHeader(),
              
              // Content
              Expanded(
                child: BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, authState) {
                    // Check if user is authenticated
                    if (authState is AuthUnauthenticated) {
                      return const UnauthenticatedContent();
                    }

                    // User is authenticated or in the process of authentication
                    if (authState is AuthAuthenticated) {
                      return FavoritesContent(authState: authState);
                    }

                    // Default loading state
                    return Center(
                      child: CircularProgressIndicator(
                        color: FireflyTheme.turquoise,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}