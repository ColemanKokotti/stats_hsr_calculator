import 'package:flutter/material.dart';
import '../../../themes/firefly_theme.dart';

class StatsHeader extends StatelessWidget {
  const StatsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.analytics_outlined,
          color: FireflyTheme.turquoise,
          size: 24,
        ),
        const SizedBox(width: 8),
        Text(
          'Character Statistics',
          style: TextStyle(
            color: FireflyTheme.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}