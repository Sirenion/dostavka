import 'package:dostavka/blocs/profile/profile_bloc.dart';
import 'package:dostavka/screens/profile/change_password.dart';
import 'package:dostavka/widgets/buttons.dart';
import 'package:dostavka/widgets/modals.dart';
import 'package:dostavka/widgets/navbar.dart';
import 'package:dostavka/widgets/switch_tile.dart';
import 'package:dostavka/widgets/text_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class PasswordForSender extends StatelessWidget {
  const PasswordForSender({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(builder: (_) => const PasswordForSender());
  }

  @override
  Widget build(BuildContext context) {
    bool usePassword = false; // для свитча
    bool isPassword = false; //переменная, есть ли пароль в базе
    return BlocProvider<ProfileBloc>(
      create: (_) => ProfileBloc(),
      child: Scaffold(
          appBar: const Navbar(title: 'Пароль для отправителей', buttonLeft: 0),
          body: Container(
            padding: const EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 0.0),
            child: SingleChildScrollView(
              child: BlocBuilder<ProfileBloc, ProfileState>(
                  builder: (context, state) {
                    return Column(
                      children: [
                        Container(
                            decoration: const BoxDecoration(
                                border: Border(
                                  bottom:
                                  BorderSide(
                                      width: 1.0, color: Color(0xFFE2E5EA)),
                                )
                            ),
                            child: DSwitch(
                                value: usePassword,
                                text: 'Использовать пароль',
                                onChanged: (value) {
                                  if (isPassword) {
                                    usePassword = value;
                                    BlocProvider.of<ProfileBloc>(context).add(
                                        ProfileSenderPasswordSwitchChange(
                                            isSwitched: !usePassword));
                                  } else {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return const DModalSenderPassword();
                                        }).then((newValue) {
                                      isPassword = true;
                                      usePassword = value;
                                      BlocProvider.of<ProfileBloc>(context).add(
                                          ProfileSenderPasswordSwitchChange(
                                              isSwitched: !usePassword)
                                      );
                                    });
                                  }
                                })
                        ),
                        if (usePassword)
                          Container(
                            decoration: const BoxDecoration(
                                border: Border(
                                  bottom:
                                  BorderSide(
                                      width: 1.0, color: Color(0xFFE2E5EA)),
                                )
                            ),
                            child: ListTile(
                              title: const TextView(
                                  text: 'Изменить пароль', fw: FontWeight.w600),
                              trailing: const Icon(
                                Icons.arrow_forward_ios,
                                size: 16.0,
                                color: Color(0xFF2D3A52),
                              ),
                              contentPadding:
                              const EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                              onTap: () {
                                Navigator.of(context).push(
                                    ChangePassword.route());
                              },
                            ),
                          ),
                        if (usePassword)
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.fromLTRB(
                                0.0, 20.0, 0.0, 0.0),
                            child: CupertinoButtonPrimary(
                              textLabel: 'Удалить пароль',
                              proceed: false,
                              callback: () {
                                //тут надо удалять пароль
                              },
                            ),
                          ),
                      ],
                    );
                  }),
            ),
          )
      ),
    );
  }
}
