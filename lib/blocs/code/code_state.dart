part of 'code_bloc.dart';

abstract class CodeState extends Equatable {
  const CodeState();

  @override
  List<Object> get props => [];
}

class CodeInitial extends CodeState {}

class CodeSuccess extends CodeState {
  final String code;
  const CodeSuccess({required this.code});
}

class CodeError extends CodeState {
  final String code;

  const CodeError({required this.code});
}
