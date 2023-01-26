part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class ProfilePersonalConfirm extends ProfileEvent {
  final String surname;
  final String name;
  final String fathername;
  final String phone;

  const ProfilePersonalConfirm(
      {required this.surname,
      required this.name,
      required this.fathername,
      required this.phone});

  @override
  List<Object> get props => [surname, name, fathername, phone];
}

class ProfilePassportConfirm extends ProfileEvent {
  final String serial;
  final String passportNumber;

  const ProfilePassportConfirm({required this.serial, required this.passportNumber});

  @override
  List<Object> get props => [serial, passportNumber];
}

class ProfileAddressConfirm extends ProfileEvent {
  final String city;
  final String street;
  final String building;


  const ProfileAddressConfirm({
    required this.city, required this.street, required this.building});

  @override
  List<Object> get props => [city, street, building];
}

class ProfileFaceIDSwitchChange extends ProfileEvent{
  final bool isSwitched;

  const ProfileFaceIDSwitchChange({required this.isSwitched});

  @override
  List<Object> get props => [isSwitched];
}

class ProfileSenderPasswordSwitchChange extends ProfileEvent{
  final bool isSwitched;

  const ProfileSenderPasswordSwitchChange({required this.isSwitched});

  @override
  List<Object> get props => [isSwitched];
}

class ProfileSenderPasswordConfirm extends ProfileEvent{
  final String oldPassword;
  final String newPassword;

  const ProfileSenderPasswordConfirm({required this.oldPassword, required this.newPassword});

  @override
  List<Object> get props => [oldPassword, newPassword];
}

class ProfileModalPasswordConfirm extends ProfileEvent{
  final String password;

  const ProfileModalPasswordConfirm({required this.password});

  @override
  List<Object> get props => [password];
}

