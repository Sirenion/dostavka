import 'package:dostavka/blocs/biometric/biometric_bloc.dart';
import 'package:dostavka/blocs/biometric/biometric_event.dart';
import 'package:dostavka/blocs/biometric/biometric_state.dart';
import 'package:dostavka/blocs/pin/authentication_pin_bloc.dart';
import 'package:dostavka/config/biometric.dart';
import 'package:dostavka/connectors/api.dart';
import 'package:dostavka/main.dart';
import 'package:dostavka/models/hive_connection/getters.dart';
import 'package:dostavka/repositories/pin_repository.dart';
import 'package:dostavka/widgets/buttons.dart';
import 'package:dostavka/widgets/modals.dart';
import 'package:dostavka/widgets/pin_sphere.dart';
import 'package:dostavka/widgets/text_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart';

import '../../models/hive_connection/update.dart';

class AuthenticationPIN extends StatelessWidget {
  //static const String ok = "OK";

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const AuthenticationPIN());
  }

  const AuthenticationPIN({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: colorPrimary,
        scaffoldBackgroundColor: const Color(0xFFFFFFFF),
        backgroundColor: const Color(0xFFFFFFFF),
      ),
      home: const LoginPinState(),
    );
  }
}

class LoginPinState extends StatefulWidget {
  const LoginPinState({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyLoginPinState();
}

class _MyLoginPinState extends State<LoginPinState> {
  static const String authenticationFailed = "Authentication failed";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leadingWidth: 200.0,
        leading: const Padding(
          padding: EdgeInsets.only(left: 20.0, top: 10.0),
          child: TextView(
            text: 'Забыли код?',
            color: Color(0xFFF0674C),
            fs: 15.0,
            fw: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: BlocProvider(
          lazy: false,
          create: (_) =>
              AuthenticationPinBloc(pinRepository: HivePINRepository()),
          child: BlocListener<AuthenticationPinBloc, AuthenticationPinState>(
            listener: (context, state) async {
              if (state.pinStatus == AuthenticationPINStatus.equals) {
                var response = Api.create();
                var user = Getters.getUser().values.first;
                var cookies = Getters.getCookie().values.first;
                var phone = user.username;
                phone = phone.replaceAll(" ", "");
                phone = phone.replaceAll("-", "");
                var body = {"username": phone,"token" : user.csrftoken};
                print(phone);
                print(user.csrftoken);
                final result = await response.Login(body);
                print("+++++++++ ${result.body.toString()} +++++++");
                final data = new Map<String, dynamic>.from(result.body);
                final head = new Map<String, dynamic>.from(result.headers);
                print(head["set-cookie"]);
                final tkn = head["set-cookie"].split(";");
                print(tkn[0]);

                if (data["is_login"]) {
                  Update.EditUser(user, sessionid: data['sessionid'], csrftoken: data['token']);
                  print("HOLA AMIGO 1111");
                  var phoneInfo = user.username;
                  phoneInfo = phoneInfo.replaceAll(" ", "");
                  phoneInfo = phoneInfo.replaceAll("-", "");
                  var inf = await response.getUser("csrftoken=${user.csrftoken}; sessionid=${user.sessionid}", phoneInfo);
                  print("HOLA AMIGO");
                  print("NEW INFO FROM SERVER ${inf.bodyString}");
                  final userdata1 = new Map<String, dynamic>.from(inf.body);
                  Update.EditUser(user, full_name: userdata1["full_name"], first_name: userdata1["first_name"], second_name: userdata1["second_name"], last_name: userdata1["last_name"], passport_editable: userdata1["passport_editable"], passport_number: userdata1["passport_number"], address_editable: userdata1["address_editable"], address: userdata1["addresses"][0]["address"]);
                  cookies.csrftoken = tkn[0];
                  cookies.sessionid = data['sessionid'];
                  cookies.save();
                  Navigator.pushAndRemoveUntil(
                      context, MyApp.route(0), (_) => false);
                }
              } else if (state.pinStatus == AuthenticationPINStatus.unequals) {
                showDialog(
                    context: context,
                    builder: (context) => const AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          title: Text(authenticationFailed),
                          actionsAlignment: MainAxisAlignment.center,
                        ));
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

  BiometricAuthenticate biom = BiometricAuthenticate();

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
              Expanded(
                  flex: 1,
                  child: BlocProvider(
                    create: (_) => BiometricBloc()..add(BiometricInit()),
                    child: BlocBuilder<BiometricBloc, BiometricState>(
                        builder: (context, state) {
                      print('-------- ${state}');
                      ///здесь проверка user.biometric

                      if (state is BiometricAuthONState) {
                        switch (state.type) {
                          case BiometricType.face:
                            return ButtonOfNumPad(
                                num: 'auth', type: 3, onPressed: () async {
                                    if(await biom.authenticateWithBiometrics()){
                                      Navigator.pushAndRemoveUntil(
                                          context, MyApp.route(0), (_) => false);
                                    }else if(!biom.isEnabledOnDevice){
                                      showError(context, 'На устройстве не подключена биометрия');
                                    }
                            });
                          case BiometricType.fingerprint:
                            return ButtonOfNumPad(
                                num: 'auth', type: 2, onPressed: () async {
                              if(await biom.authenticateWithBiometrics()){
                              Navigator.pushAndRemoveUntil(
                              context, MyApp.route(0), (_) => false);
                              }else if(!biom.isEnabledOnDevice){
                                showError(context, 'На устройстве не подключена биометрия!');
                              }
                            });
                        }
                      }
                      return SizedBox();
                    }),
                  )),
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
                onPressed: () => BlocProvider.of<AuthenticationPinBloc>(context)
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
                child: Text(
                  enterYourPIN,
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
                      4,
                      (index) =>
                          PinSphere(input: index < state.getCountsOfPIN())),
                ),
              ),
            ]);
      },
    );
  }
}
