import 'package:dostavka/blocs/registration/reg_bloc.dart';
import 'package:dostavka/screens/registration/personal_data/personal_data_p2.dart';
import 'package:dostavka/screens/registration/welcome/registration.dart';
import 'package:dostavka/widgets/buttons.dart';
import 'package:dostavka/widgets/text_field.dart';
import 'package:dostavka/widgets/text_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dostavka/models/hive_connection/getters.dart';
import 'package:dostavka/models/hive_connection/update.dart';

import '../../../connectors/api.dart';

class PersonalData1 extends StatelessWidget {
  const PersonalData1({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const PersonalData1());
  }

  bool check(String s) {
    RegExp exp = RegExp(r'(^[А-Яа-я]+$)');
    return exp.hasMatch(s);
  }

  @override
  Widget build(BuildContext context) {
    String name = 'ξ';
    String famName = 'ξ';
    String surName = 'ξ';
    return BlocProvider<RegBloc>(
        create: (_) => RegBloc(),
        child: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
              ),
              body: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        BlocBuilder<RegBloc, RegState>(
                            builder: (context, state) {
                              return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const TextView(
                                        text: 'Личные данные',
                                        fs: 30.0,
                                        fw: FontWeight.w800
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.fromLTRB(
                                          0, 15.0, 0, 29.0),
                                      child: TextView(
                                        text: 'Шаг 1 из 2',
                                        fs: 25.0,
                                        fw: FontWeight.w600,
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(bottom: 10),
                                      child: DTextField(
                                        isError: (surName == 'ξ')
                                            ? false : (state is RegNameError)
                                            ? ((check(surName)) ? false : true) : false,
                                        label: 'Фамилия',
                                        maxLength: 30,
                                        keyboardType: TextInputType.text,
                                        onChanged: (value) {
                                          surName = value;
                                          BlocProvider.of<RegBloc>(context).add(
                                              RegNameConfirm(surname: value, name: name, famname: famName)
                                          );
                                        },
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(bottom: 10),
                                      child: DTextField(
                                        isError: (name == 'ξ')
                                            ? false : (state is RegNameError)
                                            ? ((check(name)) ? false : true) : false,
                                        label: 'Имя',
                                        maxLength: 30,
                                        keyboardType: TextInputType.text,
                                        onChanged: (value) {
                                          name = value;
                                          BlocProvider.of<RegBloc>(context).add(
                                              RegNameConfirm(surname: surName, name: value, famname: famName)
                                          );
                                        },
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(bottom: 10),
                                      child: DTextField(
                                        isError: (famName == 'ξ')
                                            ? false : (state is RegNameError)
                                            ? ((check(famName)) ? false : true) : false,
                                        label: 'Отчество',
                                        maxLength: 30,
                                        keyboardType: TextInputType.text,
                                        onChanged: (value) {
                                          famName = value;
                                          BlocProvider.of<RegBloc>(context).add(
                                              RegNameConfirm(surname: surName, name: name, famname: value)
                                          );
                                        },
                                      ),
                                    ),
                                  ]
                              );
                            }
                        ),
                      ]
                  )
              ),
              persistentFooterButtons: [
                Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    child: BlocBuilder<RegBloc, RegState>(
                        builder: (context, state) {
                          VoidCallback? callback = (state is RegNameSuccess)
                              ? () async{
                            var user = Getters.getUser().values.first;
                            var cookies = Getters.getCookie().values.first;
                            Update.EditUser(user, first_name: name, second_name: surName, last_name: famName, full_name: surName + ' ' + name + ' ' + famName);
                            var response = Api.create();
                            var phone = user.username;
                            phone = phone.replaceAll(" ", "");
                            phone = phone.replaceAll("-", "");
                            var tok = cookies.csrftoken.replaceAll("csrftoken=", "");
                            var middlecsrf = {"csrfmiddlewaretoken"};
                            var usr = Getters.getUser().values.first;
                            var phoneInf = user.username;
                            var body = {"username": phone, "first_name": usr.first_name, "second_name": usr.second_name, "last_name": usr.last_name, "full_name": usr.second_name + ' ' + usr.first_name + ' ' + usr.last_name};
                            print("QUERY INFO ======================");
                            print("${body}")
                            print("END QUERY INFO ======================");
                            var res = await response.setFIO("csrftoken=${tok}; sessionid=${user.sessionid}", tok, body);
                            if (res.bodyString != '{"detail":"CSRF Failed: CSRF token missing or incorrect."}'){
                              final data = new Map<String, dynamic>.from(res.body);
                              Navigator.of(context).push(PersonalData2.route());
                            }
                            else{
                              print(res.bodyString);
                              // Navigator.of(context).push(PersonalData2.route());
                            }

                          } : null;
                          return CupertinoButtonPrimary(
                            textLabel: 'Далее',
                            proceed: true,
                            callback: callback,
                          );
                        })
                )
              ],
            )
        )
    );
  }
}
