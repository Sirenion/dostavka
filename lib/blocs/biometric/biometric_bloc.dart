import 'dart:async';

import 'package:dostavka/blocs/biometric/biometric_event.dart';
import 'package:dostavka/blocs/biometric/biometric_state.dart';
import 'package:dostavka/config/biometric.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:dostavka/models/hive_connection/getters.dart';

class BiometricBloc extends Bloc<BiometricEvent, BiometricState>{
  BiometricBloc() : super(BiometricState()){
    on<BiometricInit>(_onBiometricInit);
  }

}

Future<void> _onBiometricInit(BiometricInit event, Emitter<BiometricState> emit) async {
  BiometricAuthenticate biom = BiometricAuthenticate();
  var type = await biom.getAvailableBiometrics();
  var user = Getters.getUser();
    if (user.values.first.biometric && await biom.checkAuth()) {
      emit(BiometricAuthONState(type![0]));
    } else {

      emit(BiometricAuthOFFState(type![0]));
    }
  }
