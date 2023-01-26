import 'package:dostavka/blocs/street_search/street_search_events.dart';
import 'package:equatable/equatable.dart';

abstract class StreetSearchState extends Equatable {
  const StreetSearchState();

  @override
  List<Object?> get props => [];
}

class StreetSearchInitial extends StreetSearchState {}

class StreetSearchDragged extends StreetSearchState {
  final StreetSearchDragModalEvents streetSearchDragModalEvents;
  const StreetSearchDragged(this.streetSearchDragModalEvents);
}

class StreetSearchInputOdd extends StreetSearchState {
  final String search;
  const StreetSearchInputOdd ({required this.search});
}

class StreetSearchInputEven extends StreetSearchState {
  final String search;
  const StreetSearchInputEven({required this.search});
}

class StreetSearchInputEmpty extends StreetSearchState {
  final String search = '';
  const StreetSearchInputEmpty();
}