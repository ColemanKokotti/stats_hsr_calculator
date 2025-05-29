import 'package:equatable/equatable.dart';

enum DialogType { none, rarity, element, path }

class FilterState extends Equatable {
  final DialogType activeDialog;

  const FilterState({
    this.activeDialog = DialogType.none,
  });

  FilterState copyWith({
    DialogType? activeDialog,
  }) {
    return FilterState(
      activeDialog: activeDialog ?? this.activeDialog,
    );
  }

  @override
  List<Object?> get props => [activeDialog];
}
