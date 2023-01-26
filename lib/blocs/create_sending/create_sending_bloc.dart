import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'create_sending_event.dart';
part 'create_sending_state.dart';

class CreateSendingBloc extends Bloc<CreateSendingEvent, CreateSendingState> {
  CreateSendingBloc() : super(CreateSendingInitial()) {
    on<CreateSendingGeneralInfoConfirm>(_onCreateSendingGeneralInfoConfirm);
    on<CreateSendingParamsConfirm>(_onCreateSendingParamsConfirm);
    on<CreateSendingRouteConfirm>(_onCreateSendingRouteConfirm);
    on<CreateSendingDeliveryCheckDoorConfirm>(_onCreateSendingDeliveryCheckDoorConfirm);
    on<CreateSendingDeliveryCheckPaymentConfirm>(_onCreateSendingDeliveryCheckPaymentConfirm);
    on<CreateSendingDeliveryTileConfirm>(_onCreateSendingDeliveryTileConfirm);
    on<CreateSendingReceiverPhoneConfirm>(_onCreateSendingReceiverPhoneConfirm);
    on<CreateSendingReceiverAddressConfirm>(_onCreateSendingReceiverAddressConfirm);
    on<CreateSendingPromoConfirm>(_onCreateSendingPromoConfirm);
    on<CreateSendingDeliveryDataReceived>(_onCreateSendingDeliveryDataReceived);
  }

  FutureOr<void> _onCreateSendingGeneralInfoConfirm(
      CreateSendingGeneralInfoConfirm event,
      Emitter<CreateSendingState> emit) {
    List l = event.props;
    bool b = true;
    for (int i = 0; i < l.length; i++) {
      if (l[i]
          .trim()
          .isEmpty) {
        b = false;
      }
    }
    if (b) {
      emit(CreateSendingGeneralInfoSuccess(
          cargoName: event.cargoName,
          cargoParams: event.cargoParams,
          cargoPrice: event.cargoPrice)
      );
    } else {
      emit(CreateSendingGeneralInfoError(
          cargoName: event.cargoName,
          cargoParams: event.cargoParams,
          cargoPrice: event.cargoPrice)
      );
    }
  }

  FutureOr<void> _onCreateSendingParamsConfirm(CreateSendingParamsConfirm event,
      Emitter<CreateSendingState> emit) {
    List l = event.props;
    bool b = true;
    for (int i = 0; i < l.length; i++) {
      if (l[i].trim().isEmpty) {
        b = false;
      }
    }
    if (b) {
      emit(CreateSendingParamsSuccess(
          cargoLength: event.cargoLength,
          cargoWidth: event.cargoWidth,
          cargoHeight: event.cargoHeight,
          cargoWeight: event.cargoWeight)
      );
    } else {
      emit(CreateSendingParamsError(
          cargoLength: event.cargoLength,
          cargoWidth: event.cargoWidth,
          cargoHeight: event.cargoHeight,
          cargoWeight: event.cargoWeight)
      );
    }
  }

  FutureOr<void> _onCreateSendingRouteConfirm(CreateSendingRouteConfirm event,
      Emitter<CreateSendingState> emit) {
    if (event.from.trim().isNotEmpty && event.to.trim().isNotEmpty) {
      emit(CreateSendingRouteSuccess(from: event.from, to: event.to));
    }
  }

  FutureOr<void> _onCreateSendingDeliveryCheckDoorConfirm(CreateSendingDeliveryCheckDoorConfirm event,
      Emitter<CreateSendingState> emit) {
    emit(CreateSendingDeliveryCheckDoor(toDoor: event.toDoor));
  }

  FutureOr<void> _onCreateSendingDeliveryCheckPaymentConfirm(CreateSendingDeliveryCheckPaymentConfirm event,
      Emitter<CreateSendingState> emit) {
    emit(CreateSendingDeliveryCheckPayment(payment: event.payment));
  }

  FutureOr<void> _onCreateSendingDeliveryTileConfirm(CreateSendingDeliveryTileConfirm event,
      Emitter<CreateSendingState> emit) {
    emit(CreateSendingDeliveryTileSelected(id: event.id));
  }

  FutureOr<void> _onCreateSendingDeliveryDataReceived(CreateSendingDeliveryDataReceived event,
      Emitter<CreateSendingState> emit) {
    emit(CreateSendingDeliveryDataDownloaded(data: event.data));
  }

  FutureOr<void> _onCreateSendingReceiverPhoneConfirm(CreateSendingReceiverPhoneConfirm event,
      Emitter<CreateSendingState> emit) {
      if (RegExp(r'(^(\+7)\s([0-9]){3}\s([0-9]){3}\-([0-9]){2}\-([0-9]){2}$)').hasMatch(event.phone)) {
        emit(CreateSendingReceiverPhoneSuccess(phone: event.phone, isRegistered: event.isRegistered));
      } else {
        emit(CreateSendingReceiverPhoneError(phone: event.phone));
      }

  }

  bool check(String s) {
    // ignore: valid_regexps, unnecessary_string_escapes
    RegExp exp = RegExp(r'(^(\+7)\s([0-9]){3}\s([0-9]){3}\-([0-9]){2}\-([0-9]){2}$)');
    return exp.hasMatch(s);
  }

  FutureOr<void> _onCreateSendingReceiverAddressConfirm(CreateSendingReceiverAddressConfirm event,
      Emitter<CreateSendingState> emit) {
    if (checkAddress(event.street) && event.building.isNotEmpty) {
      emit(CreateSendingReceiverAddressSuccess(street: event.street, building: event.building));
    } else {
      emit(CreateSendingReceiverAddressError(street: event.street, building: event.building));
    }
  }

  bool checkAddress(String s) {
    RegExp exp = RegExp('^[0-9 ,.\'А-Яа-я-]+\$');
    return exp.hasMatch(s.trim());
  }

  FutureOr<void> _onCreateSendingPromoConfirm(CreateSendingPromoConfirm event,
      Emitter<CreateSendingState> emit) {
    if (event.promo == "123456") {
      emit(CreateSendingPromoSuccess(promo: event.promo));
    } else {
      emit(CreateSendingPromoError(promo: event.promo));
    }
  }
}