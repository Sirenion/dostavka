import 'package:dostavka/blocs/bottom_nav/bottom_nav_events.dart';
import 'package:equatable/equatable.dart';

class BottomNavState extends Equatable {
  final BottomNavEvents page;
  const BottomNavState(this.page);

  @override
  List<Object?> get props => [page];
}