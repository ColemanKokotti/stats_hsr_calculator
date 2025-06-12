import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/Auth_Cubit/auth_cubit.dart';
import '../../bloc/Auth_Cubit/auth_state.dart';
import '../../themes/firefly_theme.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: FireflyTheme.buttonGradient,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _confirmLogout(context),
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.logout_rounded,
                  color: FireflyTheme.white,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Text(
                  'Logout',
                  style: TextStyle(
                    color: FireflyTheme.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _confirmLogout(BuildContext context) {
    // Check if the user is a guest
    final authState = context.read<AuthCubit>().state;
    final isGuest = authState is AuthAuthenticated && 
                    authState.user.isAnonymous;
    
    if (isGuest) {
      _showGuestLogoutDialog(context);
    } else {
      _showRegularLogoutDialog(context);
    }
  }
  
  void _showRegularLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: FireflyTheme.jacket,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Text(
          'Confirm Logout',
          style: TextStyle(
            color: FireflyTheme.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          'Are you sure you want to logout?',
          style: TextStyle(
            color: FireflyTheme.white,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(
                color: FireflyTheme.gold,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // For regular users, we don't delete the account
              context.read<AuthCubit>().signOut(deleteGuestAccount: false);
            },
            child: const Text(
              'Logout',
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  void _showGuestLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: FireflyTheme.jacket,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Text(
          'Guest Account',
          style: TextStyle(
            color: FireflyTheme.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          'You are currently using a guest account. If you logout, your account and all your data will be permanently deleted. Would you like to convert your guest account to a permanent account instead?',
          style: TextStyle(
            color: FireflyTheme.white,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(
                color: FireflyTheme.gold,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // Sign out and delete the guest account and its data
              context.read<AuthCubit>().signOut(deleteGuestAccount: true);
            },
            child: const Text(
              'Logout & Delete Account',
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              
              // Navigate to the guest conversion screen
              Navigator.pushNamed(context, '/guest_conversion');

              // If the conversion was successful, we don't need to do anything else
              // If it was cancelled or failed, we stay on the current screen
            },
            child: Text(
              'Convert Account',
              style: TextStyle(
                color: FireflyTheme.turquoise,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}