import 'package:flutter/material.dart';
import '../../themes/firefly_theme.dart';

class EventHeaderWidget extends StatelessWidget {
  const EventHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: FireflyTheme.gradientText(
          'Events',
          gradient: FireflyTheme.eyesGradient,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
      ),
    );
  }
}