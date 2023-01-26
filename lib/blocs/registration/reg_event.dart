part of 'reg_bloc.dart';

abstract class RegEvent extends Equatable {
  const RegEvent();

  @override
  List<Object> get props => [];
}

class RegPhoneConfirm extends RegEvent {
  final String phone;

  const RegPhoneConfirm({required this.phone});
}

class RegNameConfirm extends RegEvent {
  final String name;
  final String surname;
  final String famname;

  const RegNameConfirm({required this.surname, required this.name, required this.famname});

  @override
  List<Object> get props => [surname, name, famname];
}

class RegAddressConfirm extends RegEvent {
  final String city;
  final String street;
  final String building;

  const RegAddressConfirm({required this.city, required this.street, required this.building});

  @override
  List<Object> get props => [city, street, building];
}
