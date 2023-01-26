import 'package:dostavka/config/biometric.dart';
import 'package:equatable/equatable.dart';
import 'package:local_auth/local_auth.dart';

class BiometricState extends Equatable {

  @override
  List<Object> get props => [];
}

class BiometricAuthONState extends BiometricState{
  final BiometricType type;

  BiometricAuthONState(this.type);
}

class BiometricAuthOFFState extends BiometricState{
  final BiometricType type;

  BiometricAuthOFFState(this.type);
}