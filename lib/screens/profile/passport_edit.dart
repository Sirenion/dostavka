import 'package:dostavka/blocs/profile/profile_bloc.dart';
import 'package:dostavka/main.dart';
import 'package:dostavka/models/hive_connection/getters.dart';
import 'package:dostavka/models/hive_connection/update.dart';
import 'package:dostavka/widgets/bottom_nav.dart';
import 'package:dostavka/widgets/navbar.dart';
import 'package:dostavka/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../connectors/api.dart';

class PassportEdit extends StatelessWidget {
  const PassportEdit({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(builder: (_) => const PassportEdit());
  }

  bool checkPassNum(String s) {
    RegExp exp = RegExp(r'(^[0-9]{6}$)');
    return exp.hasMatch(s);
  }

  bool checkPassSeries(String s) {
    RegExp exp = RegExp(r'(^[0-9]{2}[0-9]{2}$)');
    return exp.hasMatch(s);
  }

  @override
  Widget build(BuildContext context) {
    String serial = 'ξ';
    String passportNumber = 'ξ';
    var user = Getters.getUser().values.first;
    return BlocProvider<ProfileBloc>(
        create: (_) => ProfileBloc(),
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Scaffold(
              appBar: const Navbar(
                  title: 'Паспортные данные',
                  buttonLeft: 0
              ),
              bottomNavigationBar: BlocBuilder<ProfileBloc, ProfileState>(
                  builder: (context, state) {
                    VoidCallback? callback = (state is ProfilePassportSuccess)
                        ? () async {
                      Update.EditUser(user, passport_number: '$serial $passportNumber');
                      var cook = Getters
                          .getCookie()
                          .values
                          .first;
                      var tok = cook.csrftoken.replaceAll("csrftoken=", "");
                      var phone = user.username;
                      phone = phone.replaceAll(" ", "").replaceAll("-", "");
                      var body = {
                        "username" : phone,
                        "passport_number": "$serial $passportNumber"
                      }
                      var response = Api.create();
                      var data = await response.setPassport("csrftoken=${tok}; sessionid=${user.sessionid}", tok,
                          body);
                      print(data.bodyString);
                      var res = new Map<String, dynamic>.from(data.body);
                      if (res != null){
                        Navigator.of(context).pushReplacement(MyApp.route(3));
                      }
                    } : null;
                    return BottomNavSoloButton(
                      label: 'Сохранить изменения',
                      onPressed: callback,
                    );
                  }),
              body: Container(
                  padding: const EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 0.0),
                  child: SingleChildScrollView(
                      child:
                      BlocBuilder<ProfileBloc, ProfileState>(
                        builder: (context, state) {
                          return Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10.0),
                                child: DTextField(
                                  label: 'Серия',
                                  isError: (serial == 'ξ')
                                      ? false
                                      : (state is ProfilePassportError)
                                      ? ((checkPassSeries(serial)) ? false : true)
                                      : false,
                                  maxLength: 4,
                                  typeFormat: 3,
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    serial = value;
                                    BlocProvider.of<ProfileBloc>(context).add(
                                        ProfilePassportConfirm(serial: value,
                                            passportNumber: passportNumber));
                                  },
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10.0),
                                child: DTextField(
                                  label: 'Номер паспорта',
                                  isError: (passportNumber == 'ξ')
                                      ? false
                                      : (state is ProfilePassportError)
                                      ? ((checkPassNum(passportNumber)) ? false : true)
                                      : false,
                                  maxLength: 6,
                                  typeFormat: 3,
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    passportNumber = value;
                                    BlocProvider.of<ProfileBloc>(context).add(
                                        ProfilePassportConfirm(serial: serial,
                                            passportNumber: value)
                                    );
                                  },
                                ),
                              ),
                            ],
                          );
                        },
                      )
                  )
              )
          ),
        )
    );
  }
}
