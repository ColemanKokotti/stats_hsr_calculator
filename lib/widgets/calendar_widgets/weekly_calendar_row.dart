import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../themes/firefly_theme.dart';
import '../../themes/responsive_utils.dart';
import '../../cubits/calendar_cubit.dart';

class WeeklyCalendarRow extends StatelessWidget {
  const WeeklyCalendarRow({super.key});

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    
    return BlocBuilder<CalendarCubit, CalendarState>(
      builder: (context, state) {
        final DateTime startOfWeek = state.selectedWeekStart;
    
    return Container(
      height: 80,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: FireflyTheme.jacket.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: FireflyTheme.gold.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: List.generate(7, (index) {
          final DateTime day = startOfWeek.add(Duration(days: index));
          final bool isToday = _isSameDay(day, now);
          
          return Expanded(
            child: _DayWidget(
              day: day,
              isToday: isToday,
            ),
          );
        }),
      ),
    );
      },
    );
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
           date1.month == date2.month &&
           date1.day == date2.day;
  }
}

class _DayWidget extends StatelessWidget {
  final DateTime day;
  final bool isToday;

  const _DayWidget({
    required this.day,
    required this.isToday,
  });

  @override
  Widget build(BuildContext context) {
    final String dayName = _getDayName(day.weekday);
    
    return Container(
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: isToday 
            ? FireflyTheme.gold.withOpacity(0.2)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        border: isToday 
            ? Border.all(color: FireflyTheme.gold, width: 1)
            : null,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            dayName,
            style: ResponsiveTextUtils.getBodySmallStyle(
              context,
              color: isToday 
                  ? FireflyTheme.gold 
                  : FireflyTheme.gold.withOpacity(0.7),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            day.day.toString(),
            style: ResponsiveTextUtils.getBodyMediumStyle(
              context,
              color: isToday 
                  ? FireflyTheme.gold 
                  : FireflyTheme.gold.withOpacity(0.9),
            ),
          ),
        ],
      ),
    );
  }

  String _getDayName(int weekday) {
    switch (weekday) {
      case 1: return 'MON';
      case 2: return 'TUE';
      case 3: return 'WED';
      case 4: return 'THU';
      case 5: return 'FRI';
      case 6: return 'SAT';
      case 7: return 'SUN';
      default: return '';
    }
  }
}