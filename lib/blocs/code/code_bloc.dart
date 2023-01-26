import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'code_event.dart';
part 'code_state.dart';

class CodeBloc extends Bloc<CodeEvent, CodeState> {
  CodeBloc() : super(CodeInitial()) {
    on<CodeConfirm>(_onCodeConfirm);
  }

  FutureOr<void> _onCodeConfirm(CodeConfirm event, Emitter<CodeState> emit) {
    if (event.code == "12345") {
      emit(CodeSuccess(code: event.code));
    } else {
      emit(CodeError(code: event.code));
    }
  }
}
