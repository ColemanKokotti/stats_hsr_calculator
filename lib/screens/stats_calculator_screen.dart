import 'package:flutter/material.dart';
import '../themes/firefly_theme.dart';
import '../widgets/stats_calculator_widgets/stats_calculator_header.dart';
import '../widgets/stats_calculator_widgets/history_button.dart';

class StatsCalculatorScreen extends StatelessWidget {
  const StatsCalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: FireflyTheme.backgroundGradient),
        child: SafeArea(
          child: Stack(
            children: [
              _buildStatsCalculatorContent(context),
              const HistoryButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatsCalculatorContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 20),
          const StatsCalculatorHeader(),
          const SizedBox(height: 40),
          // TODO: Add stats calculator content here
          Expanded(
            child: Center(
              child: Text(
                'Stats Calculator Content',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: FireflyTheme.gold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
