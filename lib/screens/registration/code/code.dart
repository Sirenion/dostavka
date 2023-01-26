import 'dart:math';

import 'package:dostavka/blocs/code/code_bloc.dart';
import 'package:dostavka/connectors/api.dart';
import 'package:dostavka/models/hive_connection/getters.dart';
import 'package:dostavka/models/hive_connection/update.dart';
import 'package:dostavka/screens/registration/tos/tos.dart';
import 'package:dostavka/widgets/buttons.dart';
import 'package:dostavka/widgets/phone_code_field.dart';
import 'package:dostavka/widgets/text_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Code extends StatelessWidget {
  const Code({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const Code());
  }

  @override
  Widget build(BuildContext context) {
    var codename = '';
    var user = Getters.getUser().values.first;
    var cookies = Getters.getCookie().values.first;
    var sessionid = Random().nextInt(10000).toString();
    var csrftoken = Random().nextInt(1000000).toString();

    return BlocProvider<CodeBloc>(
        create: (_) => CodeBloc(),
        child: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Scaffold(
              body: Container(
                padding: const EdgeInsets.all(20.0),
                margin: const EdgeInsets.only(top: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: (MediaQuery
                              .of(context)
                              .viewInsets
                              .bottom != 0)
                              ? MediaQuery
                              .of(context)
                              .size
                              .width * 0
                              : double.infinity,
                          alignment: Alignment.center,
                          child: const Padding(
                            padding: EdgeInsets.fromLTRB(25.0, 20.0, 25.0, 0),
                            child: Image(
                                repeat: ImageRepeat.noRepeat,
                                image: AssetImage('images/reg_2.png'),
                                fit: BoxFit.contain
                            ),
                          ),
                        ),
                        const Align(
                          alignment: Alignment.topLeft,
                          child: DNavButton(
                              itemCode: 0
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const TextView(
                          text: 'Введите код из смс:',
                          fs: 30.0,
                          fw: FontWeight.w800,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.0),
                        ),
                        BlocBuilder<CodeBloc, CodeState>(
                            builder: (context, state) {
                              return PhoneField(
                                onCompleted: (value) {
                                  print('HAHHAHA');
                                  print(value);
                                  cookies.ver_code = value;
                                  BlocProvider.of<CodeBloc>(context).add(CodeConfirm(code: value));
                                },
                              );
                            }
                        ),
                      ],
                    ),
                    Container(
                        padding: const EdgeInsets.only(top: 20.0),
                        width: double.infinity,
                        child: BlocBuilder<CodeBloc, CodeState>(
                            builder: (context, state) {
                              VoidCallback? callback = (state is CodeSuccess)
                                  ? () async {

                                var response = Api.create();
                                print('aaaaa');
                                print(cookies.ver_code);
                                print('HOLA');
                                var user = Getters.getUser().values.first;
                                var phone = user.username;
                                phone = phone.replaceAll(" ", "");
                                phone = phone.replaceAll("-", "");
                                var body = {"username": phone,"verify_code" : int.parse(cookies.ver_code)};
                                print(phone);
                                print(cookies.ver_code);
                                final result = await response.Login(body);
                                print(result.body.toString());
                                final data = new Map<String, dynamic>.from(result.body);
                                print(data['is_login']);
                                final head = new Map<String, dynamic>.from(result.headers);
                                print(head["set-cookie"]);
                                final tkn = head["set-cookie"].split(";");
                                print(tkn[0]);
                                if (data['is_login']){
                                  Update.EditUser(user, sessionid: data['sessionid'], csrftoken: data['token']);
                                  cookies.csrftoken = tkn[0];
                                  cookies.sessionid = data['sessionid'];
                                  cookies.save();
                                  print('STDT: sessid ${sessionid} token ${csrftoken}'
                                      '\nUSER: sessid ${Getters.getUser().values.first.sessionid} token ${Getters.getUser().values.first.csrftoken}'
                                      '\nCOOK: sessid ${Getters.getCookie().values.first.sessionid} token ${Getters.getCookie().values.first.csrftoken}');
                                  print("HOLA AMIGO 1111");
                                  var phoneInfo = user.username;
                                  phoneInfo = phoneInfo.replaceAll(" ", "");
                                  phoneInfo = phoneInfo.replaceAll("-", "");
                                  var inf = await response.getUser("csrftoken=${user.csrftoken}; sessionid=${user.sessionid}", phoneInfo);
                                  print("HOLA AMIGO");
                                  print("NEW INFO FROM SERVER ${inf.bodyString}");
                                  final userdata1 = new Map<String, dynamic>.from(inf.body);
                                  Update.EditUser(user, full_name: userdata1["full_name"], first_name: userdata1["first_name"], second_name: userdata1["second_name"], last_name: userdata1["last_name"], passport_editable: userdata1["passport_editable"], passport_number: userdata1["passport_number"], address_editable: userdata1["address_editable"]);
                                  final suggestions_data = await response.getSuggestions();
                                  print(suggestions_data.toString());
                                  final res = new Map<String, dynamic>.from(suggestions_data.body);
                                  print(res);
                                  var sugg = Getters.getSuggest().values.first;
                                  if (res.isNotEmpty){
                                    Update.editSuggest(sugg, res["url"], res["token"])
                                    Navigator.of(context).pushAndRemoveUntil(
                                        TermsOfService.route(), (
                                        Route<dynamic> route) => false);
                                  }
                                }

                              } : null;
                              return CupertinoButtonPrimary(
                                textLabel: 'Отправить код',
                                proceed: true,
                                callback: callback,
                              );
                            }
                        )
                    )
                  ],
                ),
              ),
            )
        )
    );
  }
}
