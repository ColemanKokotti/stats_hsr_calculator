import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/Auth_Cubit/auth_cubit.dart';
import '../bloc/Auth_Cubit/auth_state.dart';
import '../themes/firefly_theme.dart';
import '../widgets/profile_screen_widgets/profile_card.dart';
import '../widgets/profile_screen_widgets/profile_header.dart';
import '../widgets/profile_screen_widgets/logout_button.dart';
import '../widgets/profile_screen_widgets/favorites_button.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: FireflyTheme.backgroundGradient),
        child: SafeArea(
          child: Stack(
            children: [
              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  if (state is AuthAuthenticated) {
                    return _buildProfileContent(context, state);
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
              const FavoritesButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileContent(BuildContext context, AuthAuthenticated state) {
    // Add error handling for user object
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 20),
          const ProfileHeader(),
          const SizedBox(height: 40),
          ProfileCard(user: state.user, isGuest: state.isGuest),
          const SizedBox(height: 40),
          const LogoutButton(),
        ],
      ),
    );
  }
}