import 'package:dostavka/blocs/profile/profile_bloc.dart';
import 'package:dostavka/main.dart';
import 'package:dostavka/widgets/bottom_nav.dart';
import 'package:dostavka/widgets/navbar.dart';
import 'package:dostavka/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dostavka/models/hive_connection/getters.dart';
import 'package:dostavka/models/hive_connection/update.dart';

import '../../connectors/api.dart';

class ProfileEdit extends StatelessWidget {
  const ProfileEdit({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const ProfileEdit());
  }

  bool check(String s) {
    RegExp exp = RegExp(r'(^[А-Яа-я]+$)');
    return exp.hasMatch(s);
  }

  bool checkPhone(String s) {
    RegExp exp = RegExp(
        r'(^(\+7)\s([0-9]){3}\s([0-9]){3}\-([0-9]){2}\-([0-9]){2}$)');
    return exp.hasMatch(s);
  }

  @override
  Widget build(BuildContext context) {

    String surname = 'ξ';
    String name = 'ξ';
    String fathername = 'ξ';
    String phone = '+7 000 000-00-00';

    var user = Getters.getUser().values.first;
    // String surname = user.second_name;
    // String name = user.first_name;
    // String fathername = user.last_name;
    // String phone = user.username;


    return BlocProvider<ProfileBloc>(
        create: (_) => ProfileBloc(),
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Scaffold(
            appBar: const Navbar(title: 'Редактирование', buttonLeft: 0),
            bottomNavigationBar: BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state) {
                  VoidCallback? callback = (state is ProfilePersonalSuccess)
                      ? () async{
                    Update.EditUser(user, first_name: name, second_name: surname, last_name: fathername, full_name: surname + ' ' + name + ' ' + fathername);
                    var response = Api.create();

                    var cook = Getters.getCookie().values.first;
                    var tok = cook.csrftoken.replaceAll("csrftoken=", "");
                    var middlecsrf = {"csrfmiddlewaretoken"};
                    var usr = Getters.getUser().values.first;
                    var phoneInf = user.username;
                    phoneInf = phoneInf.replaceAll(" ", "");
                    phoneInf = phoneInf.replaceAll("-", "");
                    var body = {"username": phoneInf, "first_name": usr.first_name, "second_name": usr.second_name, "last_name": usr.last_name, "full_name": usr.second_name + ' ' + usr.first_name + ' ' + usr.last_name};
                    print("QUERY INFO ======================");
                    print("${body}")
                    print("END QUERY INFO ======================");
                    var res = await response.setFIO("csrftoken=${tok}; sessionid=${user.sessionid}", tok, body);
                    if (res.bodyString != null){
                      print("RESPONSE");
                      print(res.bodyString);
                      Navigator.of(context).pushReplacement(MyApp.route(3));
                    }
                  } : null;
                  return BottomNavSoloButton(
                    label: 'Сохранить изменения',
                    onPressed: callback,
                  );
                }),
            body: Container(
              width: double.infinity,
              height: double.infinity,
              padding: const EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 10.0),
              child: SingleChildScrollView(child:
              BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: DTextField(
                        isError: (surname == 'ξ')
                            ? false
                            : (state is ProfilePersonalError)
                            ? ((check(surname)) ? false : true) : false,
                        label: 'Фамилия',
                        maxLength: 30,
                        onChanged: (value) {
                          surname = value;
                          BlocProvider.of<ProfileBloc>(context).add(
                              ProfilePersonalConfirm(
                                  surname: value,
                                  name: name,
                                  fathername: fathername,
                                  phone: phone)
                          );
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: DTextField(
                        isError: (name == 'ξ') ? false
                            : (state is ProfilePersonalError)
                            ? ((check(name)) ? false : true) : false,
                        label: 'Имя',
                        maxLength: 30,
                        onChanged: (value) {
                          name = value;
                          BlocProvider.of<ProfileBloc>(context).add(
                              ProfilePersonalConfirm(
                                  surname: surname,
                                  name: value,
                                  fathername: fathername,
                                  phone: phone)
                          );
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: DTextField(
                        isError: (fathername == 'ξ') ? false
                            : (state is ProfilePersonalError)
                            ? ((check(fathername)) ? false : true) : false,
                        label: 'Отчество',
                        maxLength: 30,
                        onChanged: (value) {
                          fathername = value;
                          BlocProvider.of<ProfileBloc>(context).add(
                              ProfilePersonalConfirm(
                                  surname: surname,
                                  name: name,
                                  fathername: value,
                                  phone: phone)
                          );
                        },
                      ),
                    ),
                    // Container(
                    //   padding: const EdgeInsets.symmetric(vertical: 10.0),
                    //   child: DTextField(
                    //     isError: (phone == 'ξ') ? false
                    //         : (state is ProfilePersonalError)
                    //         ? ((checkPhone(phone)) ? false : true) : false,
                    //     label: 'Телефон',
                    //     typeFormat: 1,
                    //     keyboardType: TextInputType.phone,
                    //     onChanged: (value) {
                    //       phone = value;
                    //       BlocProvider.of<ProfileBloc>(context).add(
                    //           ProfilePersonalConfirm(
                    //               surname: surname,
                    //               name: name,
                    //               fathername: fathername,
                    //               phone: value)
                    //       );
                    //     },
                    //   ),
                    // )
                  ],
                );
              })
              ),
            ),
          ),
        )
    );
  }
}
