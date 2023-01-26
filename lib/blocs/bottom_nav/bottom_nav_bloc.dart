import 'package:dostavka/blocs/bottom_nav/bottom_nav_events.dart';
import 'package:dostavka/blocs/bottom_nav/bottom_nav_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavBloc extends Bloc<BottomNavEvent, BottomNavState> {
  BottomNavBloc() : super(const BottomNavState(BottomNavEvents.sending));

  void getItem(BottomNavEvents e) {
    switch (e) {
      case BottomNavEvents.sending:
        emit(const BottomNavState(BottomNavEvents.sending));
        break;
      case BottomNavEvents.history:
        emit(const BottomNavState(BottomNavEvents.history));
        break;
      case BottomNavEvents.map:
        emit(const BottomNavState(BottomNavEvents.map));
        break;
      case BottomNavEvents.profile:
        emit(const BottomNavState(BottomNavEvents.profile));
        break;
    }
  }
}