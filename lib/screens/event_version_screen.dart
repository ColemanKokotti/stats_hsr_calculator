import 'package:flutter/material.dart';
import '../themes/firefly_theme.dart';
import '../themes/responsive_utils.dart';

class EventVersionScreen extends StatelessWidget {
  const EventVersionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FireflyTheme.jacket,
      body: Center(
        child: Text(
          'Event Version Screen',
          style: ResponsiveTextUtils.getHeadlineMediumStyle(
            context,
            color: FireflyTheme.gold,
          ),
        ),
      ),
    );
  }
}