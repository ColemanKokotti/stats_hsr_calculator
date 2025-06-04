import 'package:flutter/material.dart';
import '../../../themes/firefly_theme.dart';

class EmptyStatsWidget extends StatelessWidget {
  const EmptyStatsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.analytics_outlined,
            color: FireflyTheme.white.withOpacity(0.3),
            size: 64,
          ),
          const SizedBox(height: 16),
          Text(
            'Statistics Not Available',
            style: TextStyle(
              color: FireflyTheme.white.withOpacity(0.7),
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Character stats will appear here when available',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: FireflyTheme.white.withOpacity(0.5),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}