import 'package:dostavka/repositories/pin_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'create_pin_event.dart';
part 'create_pin_state.dart';

class CreatePINBloc extends Bloc<CreatePINEvent, CreatePINState> {
  final PINRepository pinRepository;

  CreatePINBloc({required this.pinRepository})
      : super(const CreatePINState(pinStatus: PINStatus.enterFirst)) {
    on<CreatePINAddEvent>((event, emit) {
      if (state.firstPIN.length < 4) {
        String firstPIN = "${state.firstPIN}${event.pinNum}";
        if (firstPIN.length < 4) {
          emit(CreatePINState(
              firstPIN: firstPIN, pinStatus: PINStatus.enterFirst));
        } else {
          emit(CreatePINState(
              firstPIN: firstPIN, pinStatus: PINStatus.enterSecond));
        }
      } else {
        String secondPIN = "${state.secondPIN}${event.pinNum}";
        if (secondPIN.length < 4) {
          emit(state.copyWith(
              secondPIN: secondPIN, pinStatus: PINStatus.enterSecond));
        } else if (secondPIN == state.firstPIN) {
          pinRepository.addPin(secondPIN);
          emit(
              state.copyWith(secondPIN: secondPIN, pinStatus: PINStatus.equals));
        } else {
          emit(state.copyWith(
              secondPIN: secondPIN, pinStatus: PINStatus.unequals));
        }
      }
    });
    on<CreatePINEraseEvent>((event, emit) {
      if (state.firstPIN.isEmpty) {
        emit(const CreatePINState(pinStatus: PINStatus.enterFirst));
      } else if (state.firstPIN.length < 4) {
        String firstPIN =
            state.firstPIN.substring(0, state.firstPIN.length - 1);
        emit(CreatePINState(
            firstPIN: firstPIN, pinStatus: PINStatus.enterFirst));
      } else if (state.secondPIN.isEmpty) {
        emit(state.copyWith(pinStatus: PINStatus.enterSecond));
      } else {
        String secondPIN =
            state.secondPIN.substring(0, state.secondPIN.length - 1);
        emit(state.copyWith(
            secondPIN: secondPIN, pinStatus: PINStatus.enterSecond));
      }
    });
    on<CreateNullPINEvent>((event, emit) {
      emit(const CreatePINState(pinStatus: PINStatus.enterFirst));
    });
  }

  @override
  Future<void> close() {
    pinRepository.close();
    return super.close();
  }
}
