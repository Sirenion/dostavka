import 'package:dostavka/blocs/city_search/city_search_events.dart';
import 'package:equatable/equatable.dart';

abstract class CitySearchState extends Equatable {
  const CitySearchState();

  @override
  List<Object?> get props => [];
}

class CitySearchInitial extends CitySearchState {}

class CitySearchDragged extends CitySearchState {
  final CitySearchDragModalEvents citySearchDragModalEvents;
  const CitySearchDragged(this.citySearchDragModalEvents);
}

class CitySearchInputOdd extends CitySearchState {
  final String search;
  const CitySearchInputOdd ({required this.search});
}

class CitySearchInputEven extends CitySearchState {
  final String search;
  const CitySearchInputEven({required this.search});
}

class CitySearchInputEmpty extends CitySearchState {
  final String search = '';
  const CitySearchInputEmpty();
}