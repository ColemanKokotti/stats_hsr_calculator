import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubits/calendar_cubit.dart';
import 'calendar_header.dart';
import 'weekly_calendar_row.dart';

class WeeklyCalendarWidget extends StatelessWidget {
  const WeeklyCalendarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CalendarCubit(),
      child: const Column(
        children: [
          CalendarHeader(),
          WeeklyCalendarRow(),
        ],
      ),
    );
  }
}