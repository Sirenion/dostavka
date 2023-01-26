import 'package:dostavka/blocs/pin/create_pin_bloc.dart';
import 'package:dostavka/main.dart';
import 'package:dostavka/repositories/pin_repository.dart';
import 'package:dostavka/widgets/buttons.dart';
import 'package:dostavka/widgets/pin_sphere.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePIN extends StatelessWidget {
  static const String setupPIN = "Setup PIN";
  static const String pinCreated = "Ваш пин-код был успешно создан";
  static const String pinNonCreated = "Пин-коды не совпадают";
  static const String ok = "OK";

  const ChangePIN({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const ChangePIN());
  }

  @override
  Widget build(BuildContext context) {
    VoidCallback callback;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leadingWidth: 74.0,
        leading: const Padding(
          padding: EdgeInsets.only(left: 20.0),
          child: DNavButton(
            itemCode: 0,
          ),
        ),
      ),
      body: SafeArea(
        child: BlocProvider(
          create: (context) => CreatePINBloc(pinRepository: HivePINRepository()),
          child: BlocListener<CreatePINBloc, CreatePINState>(
            listener: (context, state) {
              if (state.pinStatus == PINStatus.equals) {
                Navigator.pushReplacement(context, MyApp.route(3));
              } else if (state.pinStatus == PINStatus.unequals) {
                callback = () {
                  BlocProvider.of<CreatePINBloc>(context).add(const CreateNullPINEvent());
                  Navigator.of(context, rootNavigator: true).pop();
                };
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15))),
                        title: const Text(pinNonCreated),
                        actionsAlignment: MainAxisAlignment.center,
                        actions: [
                          TextButton(
                            onPressed: callback,
                            child: const Text(ok),
                          )
                        ],
                      );
                    }
                );
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(flex: 3, child: _MainPart()),
                  Expanded(flex: 4, child: _NumPad()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NumPad extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Row(
              children: [
                Expanded(
                    child: ButtonOfNumPad(
                        num: '1',
                        onPressed: () =>
                            BlocProvider.of<CreatePINBloc>(context)
                                .add(const CreatePINAddEvent(pinNum: 1)))),
                const SizedBox(width: 10),
                Expanded(
                    child: ButtonOfNumPad(
                        num: '2',
                        onPressed: () =>
                            BlocProvider.of<CreatePINBloc>(context)
                                .add(const CreatePINAddEvent(pinNum: 2)))),
                const SizedBox(width: 10),
                Expanded(
                    child: ButtonOfNumPad(
                        num: '3',
                        onPressed: () =>
                            BlocProvider.of<CreatePINBloc>(context)
                                .add(const CreatePINAddEvent(pinNum: 3)))),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Flexible(
            child: Row(
              children: [
                Expanded(
                    child: ButtonOfNumPad(
                        num: '4',
                        onPressed: () =>
                            BlocProvider.of<CreatePINBloc>(context)
                                .add(const CreatePINAddEvent(pinNum: 4)))),
                const SizedBox(width: 10),
                Expanded(
                    child: ButtonOfNumPad(
                        num: '5',
                        onPressed: () =>
                            BlocProvider.of<CreatePINBloc>(context)
                                .add(const CreatePINAddEvent(pinNum: 5)))),
                const SizedBox(width: 10),
                Expanded(
                    child: ButtonOfNumPad(
                        num: '6',
                        onPressed: () =>
                            BlocProvider.of<CreatePINBloc>(context)
                                .add(const CreatePINAddEvent(pinNum: 6)))),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Flexible(
            child: Row(
              children: [
                Expanded(
                    child: ButtonOfNumPad(
                        num: '7',
                        onPressed: () =>
                            BlocProvider.of<CreatePINBloc>(context)
                                .add(const CreatePINAddEvent(pinNum: 7)))),
                const SizedBox(width: 10),
                Expanded(
                    child: ButtonOfNumPad(
                        num: '8',
                        onPressed: () =>
                            BlocProvider.of<CreatePINBloc>(context)
                                .add(const CreatePINAddEvent(pinNum: 8)))),
                const SizedBox(width: 10),
                Expanded(
                    child: ButtonOfNumPad(
                        num: '9',
                        onPressed: () =>
                            BlocProvider.of<CreatePINBloc>(context)
                                .add(const CreatePINAddEvent(pinNum: 9)))),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Flexible(
            child: Row(
              children: [
                const Expanded(
                  child: SizedBox(),
                ),
                const SizedBox(width: 10),
                Expanded(
                    child: ButtonOfNumPad(
                        num: '0',
                        onPressed: () =>
                            BlocProvider.of<CreatePINBloc>(context)
                                .add(const CreatePINAddEvent(pinNum: 0)))),
                const SizedBox(width: 10),
                Expanded(
                    child: ButtonOfNumPad(
                      num: 'back',
                      type: 1,
                      onPressed: () =>
                          BlocProvider.of<CreatePINBloc>(context)
                              .add(const CreatePINEraseEvent()),
                    )),
              ],
            ),
          ),
        ],
    );
  }
}

class _MainPart extends StatelessWidget {
  static const String createPIN = "Придумайте пин-код для безопасного входа";
  static const String reEnterYourPIN = "Повторите пин-код ещё раз";

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreatePINBloc, CreatePINState>(
        buildWhen: (previous, current) =>
        previous.firstPIN != current.firstPIN ||
            previous.secondPIN != current.secondPIN,
        builder: (context, state) {
          return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Flexible(
                  flex: 1,
                  child: Text(
                    state.pinStatus == PINStatus.enterFirst
                        ? createPIN
                        : reEnterYourPIN,
                    style: const TextStyle(
                      fontFamily: 'Exo2.0',
                      fontWeight: FontWeight.w800,
                      fontSize: 30.0,
                      color: Color(0xFF2D3A52),
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                        4, (index) =>
                        PinSphere(input: index < state.getCountsOfPIN())),
                  ),
                ),
              ]);
        },
    );
  }
}
