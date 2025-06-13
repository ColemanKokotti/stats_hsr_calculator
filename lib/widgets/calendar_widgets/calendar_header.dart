import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../themes/firefly_theme.dart';
import '../../themes/responsive_utils.dart';
import '../../cubits/calendar_cubit.dart';

class CalendarHeader extends StatelessWidget {
  const CalendarHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalendarCubit, CalendarState>(
      builder: (context, state) {
        final monthYear = _getMonthYear(state.selectedWeekStart);
        
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _NavigationButton(
                icon: Icons.chevron_left,
                onTap: () => context.read<CalendarCubit>().goToPreviousWeek(),
              ),
              Expanded(
                child: Text(
                  monthYear,
                  textAlign: TextAlign.center,
                  style: ResponsiveTextUtils.getHeadlineSmallStyle(
                    context,
                    color: FireflyTheme.gold,
                  ),
                ),
              ),
              _NavigationButton(
                icon: Icons.chevron_right,
                onTap: () => context.read<CalendarCubit>().goToNextWeek(),
              ),
            ],
          ),
        );
      },
    );
  }

  String _getMonthYear(DateTime date) {
    final months = [
      'Gennaio', 'Febbraio', 'Marzo', 'Aprile', 'Maggio', 'Giugno',
      'Luglio', 'Agosto', 'Settembre', 'Ottobre', 'Novembre', 'Dicembre'
    ];
    
    return '${months[date.month - 1]} ${date.year}';
  }
}

class _NavigationButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _NavigationButton({
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: FireflyTheme.gold.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: FireflyTheme.gold.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Icon(
          icon,
          color: FireflyTheme.gold,
          size: 24,
        ),
      ),
    );
  }
}