part of 'sending_modal_bloc.dart';

abstract class SendingModalEvent extends Equatable {
  const SendingModalEvent();

  @override
  List<Object> get props => [];
}

class SendingModalPretensionConfirm extends SendingModalEvent {
  final String type;
  final String text;
  const SendingModalPretensionConfirm({required this.type, required this.text});

  @override
  List<Object> get props => [type, text];
}

class SendingModalOtherConfirm extends SendingModalEvent {
  final String text;
  const SendingModalOtherConfirm({required this.text});

  @override
  List<Object> get props => [text];
}

class SendingModalChangeInfoConfirm extends SendingModalEvent {
  final String surname;
  final String name;
  final String faName;
  final String city;
  final String street;
  final String building;
  const SendingModalChangeInfoConfirm({
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