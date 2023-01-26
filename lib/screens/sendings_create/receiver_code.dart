import 'dart:convert';

import 'package:dostavka/blocs/code/code_bloc.dart';
import 'package:dostavka/screens/sendings_create/nearest.dart';
import 'package:dostavka/screens/sendings_create/receiver_address.dart';
import 'package:dostavka/widgets/buttons.dart';
import 'package:dostavka/widgets/phone_code_field.dart';
import 'package:dostavka/widgets/text_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../connectors/api.dart';
import '../../models/hive_connection/getters.dart';
import '../../models/hive_connection/rep_data.dart';
import '../../models/hive_connection/update.dart';

class ReceiverCode extends StatelessWidget {
  const ReceiverCode({Key? key,
    required this.isRegistered,
  }) : super(key: key);

  static Route route(bool b) {
    return MaterialPageRoute<void>(builder: (_) => ReceiverCode(isRegistered: b));
  }

  final bool isRegistered;

  @override
  Widget build(BuildContext context) {
    print(isRegistered);
    var cookies = Getters.getCookie().values.first;
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

                                if (isRegistered) {
                                  var response = Api.create();
                                  var user = Getters.getUser().values.first;
                                  var userRec = Getters.getUser().values.last;
                                  var phone = userRec.username;
                                  phone = phone.replaceAll(" ", "");
                                  phone = phone.replaceAll("-", "");
                                  print("VRIFICATION CODE ${cookies.ver_code}");
                                  var body = {"username": phone,"verify_code" : cookies.ver_code};
                                  final result = await response.Login(body);
                                  final data = new Map<String, dynamic>.from(result.body);
                                  print(data['is_login']);
                                  final head = new Map<String, dynamic>.from(result.headers);
                                  print(head["set-cookie"]);
                                  final tkn = head["set-cookie"].split(";");
                                  print(tkn[0]);
                                  if (data['is_login']){
                                    var phoneInf = user.username;
                                    phoneInf = phoneInf.replaceAll(" ", "");
                                    phoneInf = phoneInf.replaceAll("-", "");
                                    var phoneInf2 = userRec.username;
                                    phoneInf2 = phoneInf2.replaceAll(" ", "");
                                    phoneInf2 = phoneInf2.replaceAll("-", "");
                                    var bodyDraft = {
                                      "user_from": phoneInf,
                                      // "user_to": phoneInf2,
                                      "by_user_to": false,
                                      // "delivery": json.encode(delivery.delivery),
                                    };
                                    print("BODY OF DRAFT++++++++++++ ${bodyDraft}")
                                    var tok = cookies.csrftoken.replaceAll("csrftoken=", "");
                                    final createDraft = await response.createDraft("csrftoken=${tok}; sessionid=${cookies.sessionid}", tok, bodyDraft);
                                    print(createDraft.bodyString);
                                    var draftData = new Map<String, dynamic>.from(createDraft.body);
                                    var dr = Getters.getDraft().values.first;
                                    var recb = {
                                      "number" : draftData["number"],
                                      "user_to": phoneInf2,
                                      "delivery": json.encode(dr.delivery),
                                      "delivery['service]": dr.delivery["service"]

                                    }
                                    final addreciever = await response.changeDraft("csrftoken=${tok}; sessionid=${cookies.sessionid}", tok, recb);
                                    var recdat = new Map<String, dynamic>.from(addreciever.body);
                                    print(recdat);
                                    var carg = Getters.getCargo().values.first;

                                    var cargobody = {
                                      "need_pack": false,
                                      "name": carg.name,
                                      "height": carg.height,
                                      "width": carg.width,
                                      "length": carg.length,
                                      "weigh": carg.weigh,
                                      "declaired_value": carg.declared_value,
                                      "draft": draftData["number"],
                                    }
                                    var data = await response.createCargo("sessionid=${cookies.sessionid}; ${cookies.csrftoken}", tok, cargobody);
                                    var resp = new Map<String, dynamic>.from(data.body);
                                    print (resp);
                                    Update.editCargo(carg,
                                        uuid: resp["uiid"]);
                                    Navigator.of(context).push(
                                        NearestPoint.route(int.parse(draftData["number"])));
                                  }
                                } else {
                                  var response = Api.create();
                                  Getters.getCookie().add(Cookie());
                                  var cook = Getters.getCookie().values.last;
                                  var user = Getters.getUser().values.last;
                                  var phone = user.username;
                                  phone = phone.replaceAll(" ", "");
                                  phone = phone.replaceAll("-", "");
                                  var body = {"username": phone,"verify_code" : int.parse(cookies.ver_code)};
                                  print("VRIFICATION CODE ${cookies.ver_code}");
                                  final result = await response.Login(body);
                                  final data = new Map<String, dynamic>.from(result.body);
                                  print(data['is_login']);
                                  final head = new Map<String, dynamic>.from(result.headers);
                                  print(head["set-cookie"]);
                                  final tkn = head["set-cookie"].split(";");
                                  print(tkn[0]);
                                  if (data['is_login']){
                                    cook.csrftoken = tkn[0];
                                    cook.sessionid = data['sessionid'];
                                    cook.save();
                                    Update.EditUser(user, sessionid: data['sessionid'], csrftoken: data['token']);
                                    Navigator.of(context).push(
                                        ReceiverAddress.route());
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
