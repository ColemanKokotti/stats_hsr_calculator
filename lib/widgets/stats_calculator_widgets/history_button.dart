import 'package:flutter/material.dart';
import '../../themes/firefly_theme.dart';
import '../../screens/stats_records_screen.dart';

class HistoryButton extends StatelessWidget {
  const HistoryButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 20,
      right: 5,
      child: Container(
        decoration: BoxDecoration(
          color: FireflyTheme.jacket.withOpacity(0.3),
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: FireflyTheme.gold.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: IconButton(
          icon: Icon(
            Icons.history,
            color: FireflyTheme.gold,
            size: 28,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const StatsRecordsScreen(),
              ),
            );
          },
          tooltip: 'Stats Records',
        ),
      ),
    );
  }
}