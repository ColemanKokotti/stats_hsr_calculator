import 'package:flutter/material.dart';

import '../../../../themes/firefly_theme.dart';


class RegisterHeader extends StatelessWidget {
  const RegisterHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Create Account',
      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
        color: FireflyTheme.gold,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    );
  }
}