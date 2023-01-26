import 'package:dostavka/blocs/registration/reg_bloc.dart';
import 'package:dostavka/models/hive_connection/getters.dart';
import 'package:dostavka/models/hive_connection/update.dart';
import 'package:dostavka/screens/sendings_create/sender_personal_data_2.dart';
import 'package:dostavka/widgets/bottom_nav.dart';
import 'package:dostavka/widgets/navbar.dart';
import 'package:dostavka/widgets/text_field.dart';
import 'package:dostavka/widgets/text_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../connectors/api.dart';

class SenderData1 extends StatelessWidget {
  const SenderData1({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(builder: (_) => const SenderData1());
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
                appBar: const Navbar(title: 'Отправитель (1/2)', buttonLeft: 0),
                bottomNavigationBar: BlocBuilder<RegBloc, RegState>(
                    builder: (context, state) {
                      VoidCallback? callback = (state is RegNameSuccess)
                          ? () async {
                        var user = Getters
                            .getUser()
                            .values
                            .first;
                        var cookies = Getters
                            .getCookie()
                            .values
                            .first;
                        Update.EditUser(user, first_name: name,
                            second_name: surName,
                            last_name: famName,
                            full_name: surName + ' ' + name + ' ' + famName);
                        var response = Api.create();
                        var phone = user.username;
                        phone = phone.replaceAll(" ", "");
                        phone = phone.replaceAll("-", "");
                        var tok = cookies.csrftoken.replaceAll(
                            "csrftoken=", "");
                        var middlecsrf = {"csrfmiddlewaretoken"};
                        var usr = Getters
                            .getUser()
                            .values
                            .first;
                        var phoneInf = user.username;
                        var body = {
                          "username": phone,
                          "first_name": usr.first_name,
                          "second_name": usr.second_name,
                          "last_name": usr.last_name,
                          "full_name": usr.second_name + ' ' + usr.first_name +
                              ' ' + usr.last_name
                        };
                        print("QUERY INFO ======================");
                        print("${body}")
                        print("END QUERY INFO ======================");
                        var res = await response.setFIO(
                            "csrftoken=${tok}; sessionid=${user.sessionid}",
                            tok, body);
                        if (res.bodyString !=
                            '{"detail":"CSRF Failed: CSRF token missing or incorrect."}') {
                          final data = new Map<String, dynamic>.from(res.body);
                          Navigator.of(context).push(SenderData2.route());
                        }
                        else {
                          print(res.bodyString);
                          // Navigator.of(context).push(PersonalData2.route());
                        }
                      }: null;
                      return BottomNavWithSteps(
                        label: 'Далее',
                        step: 2,
                        onPressed: callback,
                      );
                    }
                ),
                body: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 40.0),
                    child: BlocBuilder<RegBloc, RegState>(
                        builder: (context, state) {
                          return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const TextView(
                                  text: 'Поскольку Вас ещё нет в системе, нужно указать свои личные данные. \nЭто делается всего один раз.',
                                  fs: 17,
                                ),
                                Container(
                                    padding: const EdgeInsets.fromLTRB(
                                        0, 40, 0, 10),
                                    child: DTextField(
                                        isError: (surName == 'ξ')
                                            ? false : (state is RegNameError)
                                            ? ((check(surName)) ? false : true)
                                            : false,
                                        label: 'Фамилия',
                                        maxLength: 30,
                                        onChanged: (value) {
                                          surName = value;
                                          BlocProvider.of<RegBloc>(context).add(
                                              RegNameConfirm(surname: value,
                                                  name: name,
                                                  famname: famName)
                                          );
                                        }
                                    )
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0),
                                  child: DTextField(
                                    isError: (name == 'ξ')
                                        ? false : (state is RegNameError)
                                        ? ((check(name)) ? false : true)
                                        : false,
                                    label: 'Имя',
                                    maxLength: 30,
                                    onChanged: (value) {
                                      name = value;
                                      BlocProvider.of<RegBloc>(context).add(
                                          RegNameConfirm(surname: surName,
                                              name: value,
                                              famname: famName)
                                      );
                                    },
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0),
                                  child: DTextField(
                                    isError: (famName == 'ξ')
                                        ? false : (state is RegNameError)
                                        ? ((check(famName)) ? false : true)
                                        : false,
                                    label: 'Отчество',
                                    maxLength: 30,
                                    onChanged: (value) {
                                      famName = value;
                                      BlocProvider.of<RegBloc>(context).add(
                                          RegNameConfirm(surname: surName,
                                              name: name,
                                              famname: value)
                                      );
                                    },
                                  ),
                                )
                              ]
                          );
                        }
                    )
                )
            )
        )
    );
  }
}
