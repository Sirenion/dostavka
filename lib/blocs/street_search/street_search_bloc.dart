import 'dart:async';

import 'package:dostavka/blocs/street_search/street_search_events.dart';
import 'package:dostavka/blocs/street_search/street_search_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StreetSearchBloc extends Bloc<StreetSearchEvent, StreetSearchState> {
  StreetSearchBloc() : super(StreetSearchInitial()) {
    on<StreetSearch>(_onSearch);
    on<StreetSearchDragModalStateChangedEvent>(_onDragModal);
  }

  FutureOr<void> _onDragModal(StreetSearchDragModalStateChangedEvent event, Emitter<StreetSearchState> emit) {
    if (event.showFull) {
      emit(const StreetSearchDragged(StreetSearchDragModalEvents.full));
    } else {
      emit(const StreetSearchDragged(StreetSearchDragModalEvents.half));
    }
  }

  FutureOr<void> _onSearch(StreetSearch event, Emitter<StreetSearchState> emit) {
    if (event.search.isEmpty) {
      emit(const StreetSearchInputEmpty());
    } else {
      if (event.search.length % 2 == 0) {
        emit(StreetSearchInputEven(search: event.search));
      } else {
        emit(StreetSearchInputOdd(search: event.search));
      }
    }
  }
}