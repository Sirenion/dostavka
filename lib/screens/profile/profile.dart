import 'package:dostavka/blocs/profile/profile_bloc.dart';
import 'package:dostavka/connectors/api.dart';
import 'package:dostavka/main.dart';
import 'package:dostavka/models/hive_connection/boxes.dart';
import 'package:dostavka/models/hive_connection/update.dart';
import 'package:dostavka/models/temporary_model.dart';
import 'package:dostavka/repositories/temporary_repository.dart';
import 'package:dostavka/screens/profile/address_edit.dart';
import 'package:dostavka/screens/profile/confirm_pin_page.dart';
import 'package:dostavka/screens/profile/passport_edit.dart';
import 'package:dostavka/screens/profile/password_for_sender.dart';
import 'package:dostavka/screens/profile/profile_edit.dart';
import 'package:dostavka/widgets/buttons.dart';
import 'package:dostavka/widgets/modals.dart';
import 'package:dostavka/widgets/switch_tile.dart';
import 'package:dostavka/widgets/text_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dostavka/models/hive_connection/getters.dart';
import 'package:dostavka/models/hive_connection/rep_data.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const Profile());
  }

  @override
  Widget build(BuildContext context) {
    ///здесь проверка user.biometric

    var user = Getters.getUser().values.first;
    bool faceID = user.biometric; //переменная для свитча

    var city = [];
    if (user.address == '' || user.address == '-'){
      city = ["No data", "No data", "No data"];
    }
    else{
      city = user.address.split(',');
    }

    HiveTemporaryRepository temporaryRepository = HiveTemporaryRepository();
    return BlocProvider<ProfileBloc>(
      create: (_) => ProfileBloc(),
      child: FutureBuilder<TemporaryUser>(
          future: temporaryRepository.get(),
          builder:
              (BuildContext context, AsyncSnapshot<TemporaryUser> snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding:
                      const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      //blocks
                      child: Column(
                        children: [
                          //Личные данные
                          Container(
                              padding: const EdgeInsets.fromLTRB(
                                  0.0, 10.0, 0.0, 10.0),
                              child: Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.fromLTRB(
                                        0.0, 5.0, 0.0, 5.0),
                                    child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          const TextView(
                                            text: 'Личные данные',
                                            fs: 20.0,
                                            fw: FontWeight.w800,
                                          ),
                                          DTextButton(
                                            text: 'Изменить',
                                            onPressed: () async {
                                              Navigator.of(context)
                                                  .push(ProfileEdit.route());
                                            },
                                          )
                                        ]),
                                  ),
                                  Column(
                                    children: [
                                      TextViewField(
                                          name: 'Фамилия',
                                          info: user.second_name),
                                      TextViewField(
                                          name: 'Имя',
                                          info: user.first_name),
                                      TextViewField(
                                          name: 'Отчество',
                                          info: user.last_name),
                                      TextViewField(
                                          name: 'Телефон',
                                          info: user.username),

                                    ],
                                  )
                                ],
                              )),
                          //Адрес
                          Container(
                              padding: const EdgeInsets.fromLTRB(
                                  0.0, 10.0, 0.0, 10.0),
                              child: Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.fromLTRB(
                                        0.0, 5.0, 0.0, 5.0),
                                    child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          const TextView(
                                            text: 'Адрес',
                                            fs: 20.0,
                                            fw: FontWeight.w800,
                                          ),
                                          DTextButton(
                                            text: 'Изменить',
                                            onPressed: () {
                                              Navigator.of(context)
                                                  .push(AddressEdit.route());
                                            },
                                          )
                                        ]),
                                  ),
                                  Column(
                                    children: [
                                      TextViewField(
                                          name: 'Город',
                                          info: city[0]),
                                      TextViewField(
                                          name: 'Улица',
                                          info: city[1]),
                                      TextViewField(
                                          name: 'Дом',
                                          info: city[2]),
                                      TextViewField(
                                          name: 'Квартира',
                                          info: city[city.length-1]),
                                    ],
                                  )
                                ],
                              )),
                          //Паспорт
                          Container(
                            padding:
                            const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.fromLTRB(
                                      0.0, 5.0, 0.0, 15.0),
                                  alignment: Alignment.topLeft,
                                  child: const TextView(
                                    text: 'Паспортные данные',
                                    fs: 20.0,
                                    fw: FontWeight.w900,
                                  ),
                                ),
                                SizedBox(
                                    width: double.infinity,
                                    child: CupertinoButtonPrimary(
                                      textLabel: 'Заполнить',
                                      proceed: false,
                                      callback: () {
                                        Navigator.of(context)
                                            .push(PassportEdit.route());
                                      },
                                    ))
                              ],
                            ),
                          ),
                          //Безопасность
                          Container(
                            padding:
                            const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.fromLTRB(
                                      0.0, 5.0, 0.0, 5.0),
                                  alignment: Alignment.topLeft,
                                  child: const TextView(
                                    text: 'Безопасность',
                                    fs: 20.0,
                                    fw: FontWeight.w900,
                                  ),
                                ),
                                Column(
                                  children: [
                                    Container(
                                      decoration: const BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                                width: 1.0,
                                                color: Color(0xFFE2E5EA)),
                                          )),
                                      child: ListTile(
                                        title: const TextView(
                                            text: 'Изменить пин-код',
                                            fw: FontWeight.w600),
                                        trailing: const Icon(
                                          Icons.arrow_forward_ios,
                                          size: 16.0,
                                          color: Color(0xFF2D3A52),
                                        ),
                                        contentPadding:
                                        const EdgeInsets.fromLTRB(
                                            0.0, 0.0, 10.0, 0.0),
                                        onTap: () {
                                          Navigator.of(context)
                                              .push(ConfirmPIN.route());
                                        },
                                      ),
                                    ),
                                    Container(
                                      decoration: const BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                                width: 1.0,
                                                color: Color(0xFFE2E5EA)),
                                          )),
                                      child: ListTile(
                                        title: Row(
                                          children: const [
                                            TextView(
                                                text: 'Пароль для отправителей',
                                                fw: FontWeight.w600),
                                            DModalPassword(),
                                          ],
                                        ),
                                        trailing: const Icon(
                                          Icons.arrow_forward_ios,
                                          size: 16.0,
                                          color: Color(0xFF2D3A52),
                                        ),
                                        contentPadding:
                                        const EdgeInsets.fromLTRB(
                                            0.0, 0.0, 10.0, 0.0),
                                        onTap: () {
                                          Navigator.of(context)
                                              .push(PasswordForSender.route());
                                        },
                                      ),
                                    ),
                                    Container(
                                        decoration: const BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(
                                                  width: 1.0,
                                                  color: Color(0xFFE2E5EA)),
                                            )),
                                        child: BlocBuilder<ProfileBloc,
                                            ProfileState>(
                                          builder: (context, state) {
                                            return DSwitch(value: faceID,
                                                text: 'Использовать FaceID',
                                                onChanged: (bool value) {
                                                  ///здесь установка user.biometric
                                                  faceID = value;
                                                  Update.EditUser(user, biometric: faceID);
                                                  BlocProvider.of<ProfileBloc>(
                                                      context).add(
                                                      ProfileFaceIDSwitchChange(
                                                          isSwitched: !faceID));
                                                });
                                          },
                                        )),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Container(
                              padding: const EdgeInsets.fromLTRB(
                                  0.0, 10.0, 0.0, 10.0),
                              width: double.infinity,
                              child: CupertinoButtonPrimary(
                                  textLabel: 'Выйти из аккаунта',
                                  proceed: false,
                                  callback: () {
                                    var usr = Getters.getUser().values.first;
                                    Update.EditUser(user, is_login: false);
                                    runMain(false);
                                    // Navigator.of(context).pop();
                                  }))
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Container();
            }
          }),
    );
  }
}
