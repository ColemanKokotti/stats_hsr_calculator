import 'package:flutter/material.dart';
import '../themes/firefly_theme.dart';

class StatsRecordsScreen extends StatelessWidget {
  const StatsRecordsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: FireflyTheme.backgroundGradient),
        child: Center(
          child: FireflyTheme.gradientText(
            'Stats Records',
            gradient: FireflyTheme.eyesGradient,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
        ),
      ),
    );
  }
}
