import 'package:dostavka/blocs/biometric/biometric_bloc.dart';
import 'package:dostavka/blocs/biometric/biometric_event.dart';
import 'package:dostavka/blocs/biometric/biometric_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/error_codes.dart' as auth_error;

//использовать фейс ид - хранить бул
//экраны фейс ид и тач ид показывать, если пройдена проверка
//хранить бул с тач ид
//кнопка на пине - если тру верхнее

class BiometricAuthenticate {
  BiometricAuthenticate();
  LocalAuthentication auth = LocalAuthentication();
  _SupportState _supportState = _SupportState.unknown;
  bool _isAuthenticating = false;
  bool isEnabledOnDevice = true;

  Future<void> init() async{
    if(await auth.isDeviceSupported()){
      _supportState = _SupportState.supported;
    }else{
      _supportState = _SupportState.unsupported;
    }
  }

  Future<bool> checkAuth() async{
    return await checkBiometrics() && await checkSupported() && await getAvailableBiometrics() != null;
  }

  Future<bool> checkSupported() async{
    await init();
    print(_supportState);
    return _supportState == _SupportState.supported;
  }

  Future<bool> checkBiometrics() async {
    late bool canCheckBiometrics;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      canCheckBiometrics = false;
      print(e);
    }
    return canCheckBiometrics;
  }

  Future<List<BiometricType>?> getAvailableBiometrics() async {
    late List<BiometricType> availableBiometrics;
    try {
      availableBiometrics = await auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      availableBiometrics = <BiometricType>[];
      print(e);
    }
    return availableBiometrics;
  }

  Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      _isAuthenticating = true;

      authenticated = await auth.authenticate(
          localizedReason: 'Let OS determine authentication method',
          useErrorDialogs: true,
          stickyAuth: true);

      _isAuthenticating = false;
    } on PlatformException catch (e) {
      print(e);

      _isAuthenticating = false;

      return;
    }

  }

  Future<bool> authenticateWithBiometrics() async {
    bool authenticated = false;
    var type = await getAvailableBiometrics();
    const iosStrings = IOSAuthMessages(
        cancelButton: 'Отмена',
        goToSettingsButton: 'settings',
        goToSettingsDescription: 'Please set up your Touch ID.',
        lockOut: 'Please reenable your Touch ID');

    const androidStrings = AndroidAuthMessages(
      biometricHint: 'Подтвердите личность',
      biometricNotRecognized: 'Палец не распознан',
      biometricRequiredTitle: 'Необходима аутентификация',
      biometricSuccess: 'Успех',
      cancelButton: 'Отмена',
      deviceCredentialsRequiredTitle: 'Отмена',
      deviceCredentialsSetupDescription: 'Отмена',
      goToSettingsButton: 'Отмена',
      goToSettingsDescription: 'Отмена',
      signInTitle: 'Необходима аутентификация',
    );

    try {
      _isAuthenticating = true;
      if(type?[0] == BiometricType.fingerprint){
        authenticated = await auth.authenticate(
            localizedReason:
            'Просканируйте палец',
            useErrorDialogs: true,
            stickyAuth: true,
            biometricOnly: true,
            androidAuthStrings: androidStrings,
            iOSAuthStrings: iosStrings
        );
      }
      if(type?[0] == BiometricType.face){
        authenticated = await auth.authenticate(
            localizedReason:
            'Просканируйте лицо',
            useErrorDialogs: true,
            stickyAuth: true,
            biometricOnly: true,
            iOSAuthStrings: iosStrings);
      }
    } on PlatformException catch (e) {
      print("${e}");
      if(e.code == auth_error.notEnrolled){
        isEnabledOnDevice = false;
      }
      _isAuthenticating = false;
    }

    return authenticated;
  }

  Future<void> _cancelAuthentication() async {
    await auth.stopAuthentication();
    _isAuthenticating = false;
  }
}

enum _SupportState {
  unknown,
  supported,
  unsupported,
}