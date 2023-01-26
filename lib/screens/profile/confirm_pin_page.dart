import 'package:dostavka/blocs/pin/authentication_pin_bloc.dart';
import 'package:dostavka/repositories/pin_repository.dart';
import 'package:dostavka/screens/profile/change_pin_page.dart';
import 'package:dostavka/widgets/buttons.dart';
import 'package:dostavka/widgets/pin_sphere.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConfirmPIN extends StatelessWidget {
  //static const String ok = "OK";

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const ConfirmPIN());
  }

  const ConfirmPIN({Key? key}) : super(key: key);

  static const String authenticationFailed = "Wrong PIN-code";

  @override
  Widget build(BuildContext context) {
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
          lazy: false,
          create: (_) =>
              AuthenticationPinBloc(pinRepository: HivePINRepository()),
          child: BlocListener<AuthenticationPinBloc, AuthenticationPinState>(
            listener: (context, state) {
              if (state.pinStatus == AuthenticationPINStatus.equals) {
                Navigator.of(context).pushReplacement(ChangePIN.route());
              } else if (state.pinStatus == AuthenticationPINStatus.unequals) {
                showDialog(
                    context: context,
                    builder: (context) =>
                    const AlertDialog(
                      shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(15))),
                      title: Text(authenticationFailed),
                      actionsAlignment: MainAxisAlignment.center,
                    )
                );
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(flex: 2, child: _MainPart()),
                  Expanded(flex: 3, child: _NumPad()),
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
                        num: "1",
                        onPressed: () =>
                            BlocProvider.of<AuthenticationPinBloc>(context).add(
                                const AuthenticationPinAddEvent(pinNum: 1)))),
                const SizedBox(width: 10),
                Expanded(
                    child: ButtonOfNumPad(
                        num: "2",
                        onPressed: () =>
                            BlocProvider.of<AuthenticationPinBloc>(context).add(
                                const AuthenticationPinAddEvent(pinNum: 2)))),
                const SizedBox(width: 10),
                Expanded(
                    child: ButtonOfNumPad(
                        num: "3",
                        onPressed: () =>
                            BlocProvider.of<AuthenticationPinBloc>(context).add(
                                const AuthenticationPinAddEvent(pinNum: 3)))),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Flexible(
            child: Row(
              children: [
                Expanded(
                    child: ButtonOfNumPad(
                        num: "4",
                        onPressed: () =>
                            BlocProvider.of<AuthenticationPinBloc>(context).add(
                                const AuthenticationPinAddEvent(pinNum: 4)))),
                const SizedBox(width: 10),
                Expanded(
                    child: ButtonOfNumPad(
                        num: "5",
                        onPressed: () =>
                            BlocProvider.of<AuthenticationPinBloc>(context).add(
                                const AuthenticationPinAddEvent(pinNum: 5)))),
                const SizedBox(width: 10),
                Expanded(
                    child: ButtonOfNumPad(
                        num: "6",
                        onPressed: () =>
                            BlocProvider.of<AuthenticationPinBloc>(context).add(
                                const AuthenticationPinAddEvent(pinNum: 6)))),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Flexible(
            child: Row(
              children: [
                Expanded(
                    child: ButtonOfNumPad(
                        num: "7",
                        onPressed: () =>
                            BlocProvider.of<AuthenticationPinBloc>(context).add(
                                const AuthenticationPinAddEvent(pinNum: 7)))),
                const SizedBox(width: 10),
                Expanded(
                    child: ButtonOfNumPad(
                        num: "8",
                        onPressed: () =>
                            BlocProvider.of<AuthenticationPinBloc>(context).add(
                                const AuthenticationPinAddEvent(pinNum: 8)))),
                const SizedBox(width: 10),
                Expanded(
                    child: ButtonOfNumPad(
                        num: "9",
                        onPressed: () =>
                            BlocProvider.of<AuthenticationPinBloc>(context).add(
                                const AuthenticationPinAddEvent(pinNum: 9)))),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Flexible(
            child: Row(
              children: [
                const Expanded(
                  flex: 1,
                      child: SizedBox(),
                ),
                const SizedBox(width: 10),
                Expanded(
                    child: ButtonOfNumPad(
                        num: '0',
                        onPressed: () =>
                            BlocProvider.of<AuthenticationPinBloc>(context).add(
                                const AuthenticationPinAddEvent(pinNum: 0)))),
                const SizedBox(width: 10),
                Expanded(
                    child: ButtonOfNumPad(
                      num: '0',
                      type: 1,
                      onPressed: () =>
                          BlocProvider.of<AuthenticationPinBloc>(context)
                              .add(const AuthenticationPinEraseEvent()),
                    )),
              ],
            ),
          ),
        ],
    );
  }
}

class _MainPart extends StatelessWidget {
  static const String enterYourPIN = "Введите пин-код";

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationPinBloc, AuthenticationPinState>(
        buildWhen: (previous, current) => previous.pin != current.pin,
        builder: (context, state) {
          return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Flexible(
                  flex: 1,
                  child: Text(enterYourPIN,
                    style: TextStyle(
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
