import 'package:flutter/material.dart';
import '../../themes/firefly_theme.dart';
import 'search_bar_widget.dart';

class HomeHeaderWidget extends StatelessWidget {
  const HomeHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          FireflyTheme.gradientText(
            'Characters',
            gradient: FireflyTheme.eyesGradient,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 16),
          const SearchBarWidget(),
        ],
      ),
    );
  }
}