part of 'reg_bloc.dart';

abstract class RegState extends Equatable {
  const RegState();

  @override
  List<Object> get props => [];
}

class RegInitial extends RegState {}

class RegPhoneSuccess extends RegState {
  final String phone;
  const RegPhoneSuccess({required this.phone});
}

class RegPhoneError extends RegState {
  final String phone;

  const RegPhoneError({required this.phone});
}

class RegNameSuccess extends RegState {
  final String name;
  final String surname;
  final String famname;

  const RegNameSuccess({required this.surname, required this.name, required this.famname});
}

class RegNameError extends RegState {
  final String name;
  final String surname;
  final String famname;

  const RegNameError({required this.surname, required this.name, required this.famname});

  @override
  List<Object> get props => [surname, name, famname];
}

class RegAddressSuccess extends RegState {
  final String city;
  final String street;
  final String building;

  const RegAddressSuccess({required this.city, required this.street, required this.building});
}

class RegAddressError extends RegState {
  final String city;
  final String street;
  final String building;

  const RegAddressError({required this.city, required this.street, required this.building});

  @override
  List<Object> get props => [city, street, building];
}