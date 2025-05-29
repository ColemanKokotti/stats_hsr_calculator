import 'package:equatable/equatable.dart';

abstract class FilterEvent extends Equatable {
  const FilterEvent();

  @override
  List<Object?> get props => [];
}

class ShowRarityDialog extends FilterEvent {
  const ShowRarityDialog();
}

class ShowElementDialog extends FilterEvent {
  const ShowElementDialog();
}

class ShowPathDialog extends FilterEvent {
  const ShowPathDialog();
}

class HideDialog extends FilterEvent {
  const HideDialog();
}
