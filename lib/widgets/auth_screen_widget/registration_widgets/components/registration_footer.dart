import 'package:flutter/material.dart';
import '../../../../themes/firefly_theme.dart';


class RegisterFooter extends StatelessWidget {
  final VoidCallback onSwitchToLogin;

  const RegisterFooter({
    super.key,
    required this.onSwitchToLogin,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onSwitchToLogin,
      child: RichText(
        text: TextSpan(
          text: 'Already have an account? ',
          style: TextStyle(color: Colors.white.withOpacity(0.7)),
          children: [
            TextSpan(
              text: 'Login',
              style: TextStyle(
                color: FireflyTheme.gold,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}