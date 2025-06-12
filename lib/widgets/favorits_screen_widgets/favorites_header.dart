import 'package:flutter/material.dart';
import '../../themes/firefly_theme.dart';

class FavoritesHeader extends StatelessWidget {
  const FavoritesHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          // Back button
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: FireflyTheme.jacket.withOpacity(0.3),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.arrow_back_ios_new,
                color: FireflyTheme.turquoise,
                size: 20,
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Title
          Expanded(
            child: Center(
              child: FireflyTheme.gradientText(
                'Favorite Characters',
                gradient: FireflyTheme.eyesGradient,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ),
          // Empty space to balance the back button
          const SizedBox(width: 44),
        ],
      ),
    );
  }
}