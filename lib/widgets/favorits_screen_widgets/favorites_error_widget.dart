import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/Auth_Cubit/auth_state.dart';
import '../../bloc/Favorits_Cubit/favorits_cubit.dart';
import '../../themes/firefly_theme.dart';

class FavoritesErrorWidget extends StatelessWidget {
  final String errorMessage;
  final AuthAuthenticated authState;

  const FavoritesErrorWidget({
    super.key,
    required this.errorMessage,
    required this.authState,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 48,
            color: Colors.red[300],
          ),
          const SizedBox(height: 16),
          Text(
            'Error: $errorMessage',
            style: TextStyle(color: FireflyTheme.white),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              // Reload favorites
              context.read<FavoritesCubit>().onUserChanged(authState.user);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: FireflyTheme.turquoise,
            ),
            child: const Text('Try Again'),
          ),
        ],
      ),
    );
  }
}