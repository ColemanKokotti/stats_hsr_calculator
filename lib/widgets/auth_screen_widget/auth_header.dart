import 'package:flutter/material.dart';
import '../../themes/firefly_theme.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: FireflyTheme.hairGradient,
            boxShadow: [
              BoxShadow(
                color: FireflyTheme.jacket.withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Image.asset("assets/images/hsr_stats_calculator_logo.png",height: 30,width: 30,),
        ),
        const SizedBox(height: 24),
        FireflyTheme.gradientText(
          'HSR Stats Calculator',
          gradient: FireflyTheme.eyesGradient,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Manage your Honkai Star Rail characters',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Colors.white.withOpacity(0.7),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}