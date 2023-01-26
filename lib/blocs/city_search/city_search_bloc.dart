import 'dart:async';

import 'package:dostavka/blocs/city_search/city_search_events.dart';
import 'package:dostavka/blocs/city_search/city_search_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CitySearchBloc extends Bloc<CitySearchEvent, CitySearchState> {
  CitySearchBloc() : super(CitySearchInitial()) {
    on<CitySearch>(_onSearch);
    on<CitySearchDragModalStateChangedEvent>(_onDragModal);
  }

  FutureOr<void> _onDragModal(CitySearchDragModalStateChangedEvent event, Emitter<CitySearchState> emit) {
    if (event.showFull) {
      emit(const CitySearchDragged(CitySearchDragModalEvents.full));
    } else {
      emit(const CitySearchDragged(CitySearchDragModalEvents.half));
    }
  }

  FutureOr<void> _onSearch(CitySearch event, Emitter<CitySearchState> emit) {
    if (event.search.isEmpty) {
      emit(const CitySearchInputEmpty());
    } else {
      if (event.search.length % 2 == 0) {
        emit(CitySearchInputEven(search: event.search));
      } else {
        emit(CitySearchInputOdd(search: event.search));
      }
    }
  }
}