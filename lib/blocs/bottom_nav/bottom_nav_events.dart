import 'package:equatable/equatable.dart';

enum BottomNavEvents {sending,history,map,profile}

abstract class BottomNavEvent extends Equatable {
  const BottomNavEvent();

  @override
  List<Object> get props => [];
}

class BottomNavStateChanged extends BottomNavEvent {
  const BottomNavStateChanged(this.page);

  final BottomNavEvents page;

  @override
  List<Object> get props => [page];
}