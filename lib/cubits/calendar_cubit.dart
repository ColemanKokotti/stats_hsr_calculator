import 'package:flutter_bloc/flutter_bloc.dart';

class CalendarState {
  final DateTime selectedWeekStart;

  CalendarState({required this.selectedWeekStart});

  CalendarState copyWith({DateTime? selectedWeekStart}) {
    return CalendarState(
      selectedWeekStart: selectedWeekStart ?? this.selectedWeekStart,
    );
  }
}

class CalendarCubit extends Cubit<CalendarState> {
  CalendarCubit() : super(CalendarState(selectedWeekStart: _getStartOfWeek(DateTime.now())));

  void goToPreviousWeek() {
    final newWeekStart = state.selectedWeekStart.subtract(const Duration(days: 7));
    emit(state.copyWith(selectedWeekStart: newWeekStart));
  }

  void goToNextWeek() {
    final newWeekStart = state.selectedWeekStart.add(const Duration(days: 7));
    emit(state.copyWith(selectedWeekStart: newWeekStart));
  }

  void goToCurrentWeek() {
    final currentWeekStart = _getStartOfWeek(DateTime.now());
    emit(state.copyWith(selectedWeekStart: currentWeekStart));
  }

  static DateTime _getStartOfWeek(DateTime date) {
    int daysToSubtract = date.weekday - 1;
    return DateTime(date.year, date.month, date.day - daysToSubtract);
  }
}