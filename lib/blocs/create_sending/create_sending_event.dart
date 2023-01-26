part of 'create_sending_bloc.dart';

abstract class CreateSendingEvent extends Equatable {
  const CreateSendingEvent();

  @override
  List<Object> get props => [];
}

class CreateSendingGeneralInfoConfirm extends CreateSendingEvent {
  final String cargoName;
  final String cargoParams;
  final String cargoPrice;

  const CreateSendingGeneralInfoConfirm({
    required this.cargoName,
    required this.cargoParams,
    required this.cargoPrice
  });

  @override
  List<Object> get props => [cargoName, cargoParams, cargoPrice];
}

class CreateSendingParamsConfirm extends CreateSendingEvent {
  final String cargoLength;
  final String cargoWidth;
  final String cargoHeight;
  final String cargoWeight;

  const CreateSendingParamsConfirm({
    required this.cargoLength,
    required this.cargoWidth,
    required this.cargoHeight,
    required this.cargoWeight
  });

  @override
  List<Object> get props => [cargoLength, cargoWidth, cargoHeight, cargoWeight];
}

class CreateSendingRouteConfirm extends CreateSendingEvent {
  final String from;
  final String to;

  const CreateSendingRouteConfirm({
    required this.from,
    required this.to
  });

  @override
  List<Object> get props => [from, to];
}

class CreateSendingDeliveryCheckDoorConfirm extends CreateSendingEvent {
  final bool toDoor;

  const CreateSendingDeliveryCheckDoorConfirm({
    required this.toDoor,
  });

  @override
  List<Object> get props => [toDoor];
}

class CreateSendingDeliveryCheckPaymentConfirm extends CreateSendingEvent {
  final bool payment;

  const CreateSendingDeliveryCheckPaymentConfirm({
    required this.payment,
  });

  @override
  List<Object> get props => [payment];
}

class CreateSendingDeliveryTileConfirm extends CreateSendingEvent {
  final int id;

  const CreateSendingDeliveryTileConfirm({
    required this.id,
  });

  @override
  List<Object> get props => [id];
}

class CreateSendingDeliveryDataReceived extends CreateSendingEvent {
  final List<Map<String, dynamic>> data;

  const CreateSendingDeliveryDataReceived({
    required this.data,
  });

  @override
  List<Object> get props => [data];
}

class CreateSendingReceiverPhoneConfirm extends CreateSendingEvent {
  final String phone;
  final bool isRegistered;

  const CreateSendingReceiverPhoneConfirm ({
    required this.phone, this.isRegistered = false
  });

  @override
  List<Object> get props => [phone, isRegistered];
}

class CreateSendingReceiverAddressConfirm extends CreateSendingEvent {
  final String street;
  final String building;

  const CreateSendingReceiverAddressConfirm ({
    required this.street, required this.building
  });

  @override
  List<Object> get props => [street, building];
}

class CreateSendingPromoConfirm extends CreateSendingEvent {
  final String promo;

  const CreateSendingPromoConfirm ({required this.promo});

  @override
  List<Object> get props => [promo];
}


