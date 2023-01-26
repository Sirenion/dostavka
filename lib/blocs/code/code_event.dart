part of 'code_bloc.dart';

abstract class CodeEvent extends Equatable {
  const CodeEvent();

  @override
  List<Object> get props => [];
}

class CodeConfirm extends CodeEvent {
  final String code;

  const CodeConfirm({required this.code});
}
