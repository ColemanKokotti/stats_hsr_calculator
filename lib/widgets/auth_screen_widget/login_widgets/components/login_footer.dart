import 'package:flutter/material.dart';
import '../../../../themes/firefly_theme.dart';


class LoginFooter extends StatelessWidget {
  final VoidCallback onSwitchToRegister;

  const LoginFooter({
    super.key,
    required this.onSwitchToRegister,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onSwitchToRegister,
      child: RichText(
        text: TextSpan(
          text: "Don't have an account? ",
          style: TextStyle(color: Colors.white.withOpacity(0.7)),
          children: [
            TextSpan(
              text: 'Register',
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