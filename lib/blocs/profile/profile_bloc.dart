import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<ProfilePersonalConfirm>(_onProfilePersonalConfirm);
    on<ProfilePassportConfirm>(_onProfilePassportConfirm);
    on<ProfileAddressConfirm>(_onProfileAddressConfirm);
    on<ProfileFaceIDSwitchChange>(_onProfileSwitchFaceIDChange);
    on<ProfileSenderPasswordSwitchChange>(_onProfileSenderPasswordSwitchChange);
    on<ProfileSenderPasswordConfirm>(_onProfileSenderPasswordConfirm);
    on<ProfileModalPasswordConfirm>(_onProfileModalPasswordConfirm);
  }

  FutureOr<void> _onProfilePersonalConfirm(
      ProfilePersonalConfirm event, Emitter<ProfileState> emit) {
    List l = event.props;
    bool names = true;
    bool ph = true;
    for (int i = 0; i < l.length - 1; i++) {
      if (!check(l[i].toString())) {
        names = false;
      }
    }
    if (!RegExp(r'(^(\+7)\s([0-9]){3}\s([0-9]){3}\-([0-9]){2}\-([0-9]){2}$)').hasMatch(event.phone)) {

      ph = false;
    }

    if (names && ph) {
      emit(ProfilePersonalSuccess(
          surname: event.surname,
          name: event.name,
          fathername: event.fathername,
          phone: event.phone));
    } else {
      emit(ProfilePersonalError(
          surname: event.surname,
          name: event.name,
          fathername: event.fathername,
          phone: event.phone));
    }
  }

  FutureOr<void> _onProfilePassportConfirm(
      ProfilePassportConfirm event, Emitter<ProfileState> emit) {
      if(checkPassSeries(event.serial) && checkPassNum(event.passportNumber)){
        emit(ProfilePassportSuccess(
            serial: event.serial, passportNumber: event.passportNumber));
      }else{
        emit(ProfilePassportError(
            serial: event.serial, passportNumber: event.passportNumber));
      }
  }

  FutureOr<void> _onProfileSenderPasswordSwitchChange(
      ProfileSenderPasswordSwitchChange event, Emitter<ProfileState> emit) {
      emit(ProfileSenderPasswordSwitchState(isSwitched: event.isSwitched));
  }

  FutureOr<void> _onProfileSwitchFaceIDChange(
      ProfileFaceIDSwitchChange event, Emitter<ProfileState> emit) {
    emit(ProfileFaceIDSwitchState(isSwitched: event.isSwitched));
  }

  FutureOr<void> _onProfileAddressConfirm(ProfileAddressConfirm event, Emitter<ProfileState> emit) {
    List l = event.props;
    bool b = true;
    for (int i = 0; i < l.length; i++) {
      if (!checkAddress(l[i].toString())) {
        l[i] = '';
        b = true;
      }
    }
    if (b) {
      emit(ProfileAddressSuccess(city: event.city, street: event.street, building: event.building));
    } else {
      emit(ProfileAddressError(city: l[0], street: l[1], building: l[2]));
    }
  }

  FutureOr<void> _onProfileSenderPasswordConfirm(
      ProfileSenderPasswordConfirm event, Emitter<ProfileState> emit) {
    List l = event.props;
    bool b = true;
    for (int i = 0; i < l.length; i++) {
      if (l[i].toString().isEmpty) {
        l[i] = '';
        b = false;
      }
    }
    if (b) {
      emit(ProfileSenderPasswordSuccess(oldPassword: event.oldPassword, newPassword: event.newPassword));
    } else {
      emit(ProfileSenderPasswordError(oldPassword: l[0], newPassword: l[1]));
    }
  }

  FutureOr<void> _onProfileModalPasswordConfirm(
      ProfileModalPasswordConfirm event, Emitter<ProfileState> emit) {
    if (event.password.isNotEmpty) {
      emit(ProfileModalPasswordSuccess(password: event.password));
    } else {
      emit(const ProfileModalPasswordError(password: ''));
    }
  }

  bool check(String s) {
    RegExp exp = RegExp(r'(^[А-Яа-я-]+$)');
    return exp.hasMatch(s);
  }

  bool checkPassNum(String s) {
    RegExp exp = RegExp(r'(^[0-9]{6}$)');
    return exp.hasMatch(s);
  }

  bool checkPassSeries(String s) {
    RegExp exp = RegExp(r'(^[0-9]{2}[0-9]{2}$)');
    return exp.hasMatch(s);
  }

  bool checkPhone(String s) {
    RegExp exp = RegExp(r'(^(\+7)\s([0-9]){3}\s([0-9]){3}\-([0-9]){2}\-([0-9]){2}$)');
    return exp.hasMatch(s);
  }

  bool checkAddress(String s) {
    RegExp exp = RegExp(r'(^[0-9 ,.А-Яа-я-]+$)');
    return exp.hasMatch(s);
  }

}
