part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {} //проверка используется ли фейсид и есть ли пароль в базе

class ProfilePersonalSuccess extends ProfileState {
  final String surname;
  final String name;
  final String fathername;
  final String phone;

  const ProfilePersonalSuccess({
    required this.surname,
    required this.name,
    required this.fathername,
    required this.phone
  });
}

class ProfilePersonalError extends ProfileState {
  final String surname;
  final String name;
  final String fathername;
  final String phone;

  const ProfilePersonalError({
    required this.surname,
    required this.name,
    required this.fathername,
    required this.phone
  });

  @override
  List<Object> get props => [surname, name, fathername, phone];
}

class ProfilePassportSuccess extends ProfileState{
  final String serial;
  final String passportNumber;

  const ProfilePassportSuccess({required this.serial,required this.passportNumber});
}

class ProfilePassportError extends ProfileState{
  final String serial;
  final String passportNumber;

  const ProfilePassportError({required this.serial,required this.passportNumber});

  @override
  List<Object> get props => [serial, passportNumber];
}

class ProfileAddressSuccess extends ProfileState {
  final String city;
  final String street;
  final String building;

  const ProfileAddressSuccess({required this.city, required this.street, required this.building});
}

class ProfileAddressError extends ProfileState {
  final String city;
  final String street;
  final String building;

  const ProfileAddressError({required this.city, required this.street, required this.building});

  @override
  List<Object> get props => [city, street, building];
}

class ProfileFaceIDSwitchState extends ProfileState{
  final bool isSwitched;

  const ProfileFaceIDSwitchState({required this.isSwitched});

  @override
  List<Object> get props => [isSwitched];
}

class ProfileSenderPasswordSwitchState extends ProfileState{
  final bool isSwitched;

  const ProfileSenderPasswordSwitchState({required this.isSwitched});

  @override
  List<Object> get props => [isSwitched];
}

class ProfileSenderPasswordSuccess extends ProfileState{
  final String oldPassword;
  final String newPassword;

  const ProfileSenderPasswordSuccess({required this.oldPassword, required this.newPassword});
}

class ProfileSenderPasswordError extends ProfileState{
  final String oldPassword;
  final String newPassword;

  const ProfileSenderPasswordError({required this.oldPassword, required this.newPassword});

  @override
  List<Object> get props => [oldPassword, newPassword];
}

class ProfileModalPasswordSuccess extends ProfileState{
  final String password;

  const ProfileModalPasswordSuccess({required this.password});
}

class ProfileModalPasswordError extends ProfileState{
  final String password;

  const ProfileModalPasswordError({required this.password});

  @override
  List<Object> get props => [password];
}