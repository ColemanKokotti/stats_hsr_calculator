import 'package:flutter/material.dart';
import '../themes/firefly_theme.dart';
import '../widgets/calendar_widgets/weekly_calendar_widget.dart';
import '../widgets/event_screen_widgets/event_header_widget.dart';

class EventVersionScreen extends StatelessWidget {
  const EventVersionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: FireflyTheme.backgroundGradient),
        child: const SafeArea(
          child: Column(
            children: [
              EventHeaderWidget(),
              SizedBox(height: 16),
              WeeklyCalendarWidget(),
              Expanded(
                child: SizedBox(), // Spazio per altri contenuti futuri
              ),
            ],
          ),
        ),
      ),
    );
  }
}