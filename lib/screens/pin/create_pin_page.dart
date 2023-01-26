import 'package:dostavka/blocs/biometric/biometric_bloc.dart';
import 'package:dostavka/blocs/biometric/biometric_event.dart';
import 'package:dostavka/blocs/pin/create_pin_bloc.dart';
import 'package:dostavka/config/biometric.dart';
import 'package:dostavka/models/hive_connection/getters.dart';
import 'package:dostavka/models/hive_connection/update.dart';
import 'package:dostavka/repositories/pin_repository.dart';
import 'package:dostavka/screens/registration/face_id/face_id.dart';
import 'package:dostavka/screens/registration/touch_id/touch_id.dart';
import 'package:dostavka/screens/registration/welcome/registration.dart';
import 'package:dostavka/widgets/buttons.dart';
import 'package:dostavka/widgets/pin_sphere.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart';

import '../../connectors/api.dart';

class CreatePIN extends StatelessWidget {
  static const String setupPIN = "Setup PIN";
  static const String pinCreated = "Ваш пин-код был успешно создан";
  static const String pinNonCreated = "Пин-коды не совпадают";
  static const String ok = "OK";

  const CreatePIN({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const CreatePIN());
  }

  Future<BiometricType> checkType() async {
    var type = await BiometricAuthenticate().getAvailableBiometrics();
    return type![0];
  }

  @override
  Widget build(BuildContext context) {

    BiometricType type;

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
        child: FutureBuilder<BiometricType>(
          future: checkType(),
          builder: (context, snapshot) {
            return MultiBlocProvider(

              providers: [
                BlocProvider(create: (context) => CreatePINBloc(pinRepository: HivePINRepository())),
                BlocProvider(create: (context) => BiometricBloc()..add(BiometricInit()))
              ],
              child: BlocListener<CreatePINBloc, CreatePINState>(
                listener: (context, state) {
                  if (state.pinStatus == PINStatus.equals) {
                    var user = Getters.getUser().values.first;
                    Update.EditUser(user, is_login: true);
                    Navigator.pushReplacement(context, snapshot.data == BiometricType.fingerprint ? TouchIdReg.route()  : FaceIdReg.route());
                  } else if (state.pinStatus == PINStatus.unequals) {
                    VoidCallback callback = () async {
                      var response = Api.create();
                      var user = Getters.getUser().values.first;
                      print("HOLA AMIGO 1111");
                      var phoneInfo = user.username;
                      phoneInfo = phoneInfo.replaceAll(" ", "");
                      phoneInfo = phoneInfo.replaceAll("-", "");
                      var inf = await response.getUser("csrftoken=${user.csrftoken}; sessionid=${user.sessionid}", phoneInfo);
                      print("HOLA AMIGO");
                      print("NEW INFO FROM SERVER ${inf.bodyString}");
                      final userdata1 = new Map<String, dynamic>.from(inf.body);
                      if (userdata1["addresses"].isNotEmpty){
                        Update.EditUser(user, full_name: userdata1["full_name"], first_name: userdata1["first_name"], second_name: userdata1["second_name"], last_name: userdata1["last_name"], passport_editable: userdata1["passport_editable"], passport_number: userdata1["passport_number"], address_editable: userdata1["address_editable"], address: userdata1["addresses"][0]["address"]);
                      }
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
            );
          }),
        )
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
