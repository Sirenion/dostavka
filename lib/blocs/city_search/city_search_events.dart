import 'package:equatable/equatable.dart';

enum CitySearchEvents {search, select}
enum CitySearchDragModalEvents {full, half}

abstract class CitySearchEvent extends Equatable {
  const CitySearchEvent();

  @override
  List<Object> get props => [];
}

class CitySearchDragModalStateChangedEvent extends CitySearchEvent {
  const CitySearchDragModalStateChangedEvent(this.showFull);

  final bool showFull;

  @override
  List<Object> get props => [showFull];
}

class CitySearch extends CitySearchEvent {
  final String search;
  const CitySearch({required this.search});

  @override
  List<Object> get props => [search];
}