import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'reg_event.dart';
part 'reg_state.dart';

class RegBloc extends Bloc<RegEvent, RegState> {
  RegBloc() : super(RegInitial()) {
    on<RegPhoneConfirm>(_onRegPhoneConfirm);
    on<RegNameConfirm>(_onRegNameConfirm);
    on<RegAddressConfirm>(_onRegAddressConfirm);
  }

  FutureOr<void> _onRegPhoneConfirm(RegPhoneConfirm event, Emitter<RegState> emit) {
    if (RegExp(r'(^(\+7)\s([0-9]){3}\s([0-9]){3}\-([0-9]){2}\-([0-9]){2}$)').hasMatch(event.phone)) {
      emit(RegPhoneSuccess(phone: event.phone));
    } else {
      emit(RegPhoneError(phone: event.phone));
    }
  }

  FutureOr<void> _onRegNameConfirm(RegNameConfirm event, Emitter<RegState> emit) {
    List l = event.props;
    bool b = true;
    for (int i = 0; i < l.length; i++) {
      if (!check(l[i].toString())) {
        b = false;
      }
    }
    if (b) {
      emit(RegNameSuccess(surname: event.surname, name: event.name, famname: event.famname));
    } else {
      emit(RegNameError(surname: event.surname, name: event.name, famname: event.famname));
    }
  }

  FutureOr<void> _onRegAddressConfirm(RegAddressConfirm event, Emitter<RegState> emit) {
    List l = event.props;
    bool b = true;
    for (int i = 0; i < l.length; i++) {
      if (!checkAddress(l[i].toString())) {
        l[i] = '';
        b = false;
      }
    }
    if (b) {
      emit(RegAddressSuccess(city: event.city, street: event.street, building: event.building));
    } else {
      emit(RegAddressError(city: l[0], street: l[1], building: l[2]));
    }
  }

  bool check(String s) {
    RegExp exp = RegExp(r'(^[А-Яа-я]+$)');
    return exp.hasMatch(s);
  }

  bool checkAddress(String s) {
    RegExp exp = RegExp(r'(^[0-9 ,.А-Яа-я-]+$)');
    return exp.hasMatch(s.trim());
  }
}
