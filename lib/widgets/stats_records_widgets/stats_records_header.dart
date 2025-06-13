import 'package:flutter/material.dart';
import '../../themes/firefly_theme.dart';

class StatsRecordsHeader extends StatelessWidget {
  const StatsRecordsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FireflyTheme.gradientText(
        'Stats Records',
        gradient: FireflyTheme.eyesGradient,
        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}