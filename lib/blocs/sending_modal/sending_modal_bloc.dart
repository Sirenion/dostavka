import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'sending_modal_event.dart';
part 'sending_modal_state.dart';

class SendingModalBloc extends Bloc<SendingModalEvent, SendingModalState> {
  SendingModalBloc() : super(SendingModalInitial()) {
    on<SendingModalPretensionConfirm>(_onSendingModalPretensionConfirm);
    on<SendingModalOtherConfirm>(_onSendingModalOtherConfirm);
    on<SendingModalChangeInfoConfirm>(_onSendingModalChangeInfoConfirm);
  }

  FutureOr<void> _onSendingModalPretensionConfirm(SendingModalPretensionConfirm event,
      Emitter<SendingModalState> emit) {
    if (event.type.isNotEmpty && event.text.isNotEmpty) {
      emit(SendingModalPretensionSuccess(type: event.type, text: event.text));
    } else {
      emit(SendingModalPretensionError(type: event.type, text: event.text));
    }
  }

  FutureOr<void> _onSendingModalOtherConfirm(SendingModalOtherConfirm event,
      Emitter<SendingModalState> emit) {
    if (event.text.isNotEmpty) {
      emit(SendingModalOtherSuccess(text: event.text));
    } else {
      emit(SendingModalOtherError(text: event.text));
    }
  }

  FutureOr<void> _onSendingModalChangeInfoConfirm(SendingModalChangeInfoConfirm event,
      Emitter<SendingModalState> emit) {
    bool b = true;
    List l = event.props;
    for (int i = 0; i < 3; i++) {
      if (!check(l[i].trim())) {
        b = false;
      }
    }
    for (int i = 3; i < l.length; i++) {
      if (l[i].trim().toString().isEmpty) {
        b = false;
      }
    }
    if (b) {
      emit(SendingModalChangeInfoSuccess(
          surname: event.surname,
          name: event.name,
          faName: event.faName,
          city: event.city,
          street: event.street,
          building: event.building)
      );
    } else {
      emit(SendingModalChangeInfoError(
          surname: event.surname,
          name: event.name,
          faName: event.faName,
          city: event.city,
          street: event.street,
          building: event.building)
      );
    }
  }

  bool check(String s) {
    RegExp exp = RegExp(r'(^[А-Яа-я]+$)');
    return exp.hasMatch(s);
  }
}