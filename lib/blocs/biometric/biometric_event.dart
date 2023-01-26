import 'package:dostavka/config/biometric.dart';
import 'package:equatable/equatable.dart';
import 'package:local_auth/local_auth.dart';

class BiometricEvent extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class BiometricAuthChange extends BiometricEvent{

}

class BiometricInit extends BiometricEvent{
  BiometricInit();
}