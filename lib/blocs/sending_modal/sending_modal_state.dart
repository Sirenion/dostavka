part of 'sending_modal_bloc.dart';

abstract class SendingModalState extends Equatable {
  const SendingModalState();

  @override
  List<Object> get props => [];
}

class SendingModalInitial extends SendingModalState {}

class SendingModalPretensionSuccess extends SendingModalState {
  final String type;
  final String text;
  const SendingModalPretensionSuccess({required this.type, required this.text});

  @override
  List<Object> get props => [type, text];
}

class SendingModalPretensionError extends SendingModalState {
  final String type;
  final String text;
  const SendingModalPretensionError({required this.type, required this.text});

  @override
  List<Object> get props => [type, text];
}

class SendingModalOtherSuccess extends SendingModalState {
  final String text;
  const SendingModalOtherSuccess({required this.text});

  @override
  List<Object> get props => [text];
}

class SendingModalOtherError extends SendingModalState {
  final String text;
  const SendingModalOtherError({required this.text});

  @override
  List<Object> get props => [text];
}

class SendingModalChangeInfoSuccess extends SendingModalState {
  final String surname;
  final String name;
  final String faName;
  final String city;
  final String street;
  final String building;
  const SendingModalChangeInfoSuccess({
    required this.surname,
    required this.name,
    required this.faName,
    required this.city,
    required this.street,
    required this.building,
  });

  @override
  List<Object> get props => [surname, name, faName, city, street, building];
}

class SendingModalChangeInfoError extends SendingModalState {
  final String surname;
  final String name;
  final String faName;
  final String city;
  final String street;
  final String building;
  const SendingModalChangeInfoError({
    required this.surname,
    required this.name,
    required this.faName,
    required this.city,
    required this.street,
    required this.building,
  });

  @override
  List<Object> get props => [surname, name, faName, city, street, building];
}