part of 'create_sending_bloc.dart';

abstract class CreateSendingState extends Equatable {
  const CreateSendingState();

  @override
  List<Object> get props => [];
}

class CreateSendingInitial extends CreateSendingState {}

class CreateSendingGeneralInfoSuccess extends CreateSendingState {
  final String cargoName;
  final String cargoParams;
  final String cargoPrice;

  const CreateSendingGeneralInfoSuccess({
    required this.cargoName,
    required this.cargoParams,
    required this.cargoPrice
  });

  @override
  List<Object> get props => [cargoName, cargoParams, cargoPrice];
}

class CreateSendingGeneralInfoError extends CreateSendingState {
  final String cargoName;
  final String cargoParams;
  final String cargoPrice;

  const CreateSendingGeneralInfoError({
    required this.cargoName,
    required this.cargoParams,
    required this.cargoPrice
  });

  @override
  List<Object> get props => [cargoName, cargoParams, cargoPrice];
}

class CreateSendingParamsError extends CreateSendingState {
  final String cargoLength;
  final String cargoWidth;
  final String cargoHeight;
  final String cargoWeight;

  const CreateSendingParamsError({
    required this.cargoLength,
    required this.cargoWidth,
    required this.cargoHeight,
    required this.cargoWeight
  });

  @override
  List<Object> get props => [cargoLength, cargoWidth, cargoHeight, cargoWeight];
}

class CreateSendingParamsSuccess extends CreateSendingState {
  final String cargoLength;
  final String cargoWidth;
  final String cargoHeight;
  final String cargoWeight;

  const CreateSendingParamsSuccess({
    required this.cargoLength,
    required this.cargoWidth,
    required this.cargoHeight,
    required this.cargoWeight
  });

  @override
  List<Object> get props => [cargoLength, cargoWidth, cargoHeight, cargoWeight];
}

class CreateSendingRouteSuccess extends CreateSendingState {
  final String from;
  final String to;

  const CreateSendingRouteSuccess({
    required this.from,
    required this.to
  });

  @override
  List<Object> get props => [from, to];
}

class CreateSendingDeliveryCheckDoor extends CreateSendingState {
  final bool toDoor;

  const CreateSendingDeliveryCheckDoor({
    required this.toDoor,
  });

  @override
  List<Object> get props => [toDoor];
}

class CreateSendingDeliveryCheckPayment extends CreateSendingState {
  final bool payment;

  const CreateSendingDeliveryCheckPayment({
    required this.payment,
  });

  @override
  List<Object> get props => [payment];
}

class CreateSendingDeliveryTileSelected extends CreateSendingState {
  final int id;

  const CreateSendingDeliveryTileSelected({
    required this.id,
  });

  @override
  List<Object> get props => [id];
}

class CreateSendingDeliveryDataDownloaded extends CreateSendingState {
  final List<Map<String, dynamic>> data;

  const CreateSendingDeliveryDataDownloaded({
    required this.data,
  });

  @override
  List<Object> get props => [data];
}

class CreateSendingReceiverPhoneSuccess extends CreateSendingState {
  final String phone;
  final bool isRegistered;

  const CreateSendingReceiverPhoneSuccess ({
    required this.phone, this.isRegistered = false
  });

  @override
  List<Object> get props => [phone, isRegistered];
}

class CreateSendingReceiverPhoneError extends CreateSendingState {
  final String phone;

  const CreateSendingReceiverPhoneError ({
    required this.phone,
  });

  @override
  List<Object> get props => [phone];
}

class CreateSendingReceiverAddressSuccess extends CreateSendingState {
  final String street;
  final String building;

  const CreateSendingReceiverAddressSuccess ({
    required this.street, required this.building
  });

  @override
  List<Object> get props => [street, building];
}

class CreateSendingReceiverAddressError extends CreateSendingState {
  final String street;
  final String building;

  const CreateSendingReceiverAddressError ({
    required this.street, required this.building
  });

  @override
  List<Object> get props => [street, building];
}

class CreateSendingPromoSuccess extends CreateSendingState {
  final String promo;

  const CreateSendingPromoSuccess ({required this.promo});

  @override
  List<Object> get props => [promo];
}

class CreateSendingPromoError extends CreateSendingState {
  final String promo;

  const CreateSendingPromoError ({required this.promo});

  @override
  List<Object> get props => [promo];
}