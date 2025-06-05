import '../../themes/firefly_theme.dart';
import 'package:flutter/material.dart';

class EmptyFavoritesWidget extends StatelessWidget {
  const EmptyFavoritesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite_border,
            size: 80,
            color: FireflyTheme.white.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          Text(
            'No favorite characters yet',
            style: TextStyle(
              color: FireflyTheme.white.withOpacity(0.7),
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Add characters to favorites to see them here',
            style: TextStyle(
              color: FireflyTheme.white.withOpacity(0.5),
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}