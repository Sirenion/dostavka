import 'package:equatable/equatable.dart';

enum StreetSearchEvents {search, select}
enum StreetSearchDragModalEvents {full, half}

abstract class StreetSearchEvent extends Equatable {
  const StreetSearchEvent();

  @override
  List<Object> get props => [];
}

class StreetSearchDragModalStateChangedEvent extends StreetSearchEvent {
  const StreetSearchDragModalStateChangedEvent(this.showFull);

  final bool showFull;

  @override
  List<Object> get props => [showFull];
}

class StreetSearch extends StreetSearchEvent {
  final String search;
  const StreetSearch({required this.search});

  @override
  List<Object> get props => [search];
}