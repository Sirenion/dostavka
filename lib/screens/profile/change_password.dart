import 'package:dostavka/blocs/profile/profile_bloc.dart';
import 'package:dostavka/screens/profile/password_for_sender.dart';
import 'package:dostavka/widgets/bottom_nav.dart';
import 'package:dostavka/widgets/navbar.dart';
import 'package:dostavka/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePassword extends StatelessWidget {
  const ChangePassword({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const ChangePassword());
  }

  @override
  Widget build(BuildContext context) {
    String oldPass = '0';
    String newPass = '0';

    return BlocProvider<ProfileBloc>(
        create: (_) => ProfileBloc(),
        child: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Scaffold(
              appBar: const Navbar(title: 'Изменить пароль', buttonLeft: 0),
              bottomNavigationBar: BlocBuilder<ProfileBloc, ProfileState>(
                  builder: (context, state) {
                VoidCallback? callback = (state is ProfileSenderPasswordSuccess)
                    ? () {
                        Navigator.of(context).push(PasswordForSender.route());
                      }
                    : null;
                return BottomNavSoloButton(
                  label: 'Сохранить изменения',
                  onPressed: callback,
                );
              }),
              body: SingleChildScrollView(
                child: BlocBuilder<ProfileBloc, ProfileState>(
                    builder: (context, state) {
                  return Container(
                    padding: const EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 0.0),
                    child: SingleChildScrollView(
                        child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: DTextField(
                              isError: (oldPass == '0')
                                  ? false
                                  : (state is ProfileSenderPasswordError &&
                                          state.oldPassword.isEmpty)
                                      ? true
                                      : false,
                              label: 'Старый пароль',
                              onChanged: (value) {
                                oldPass = value;
                                BlocProvider.of<ProfileBloc>(context).add(
                                    ProfileSenderPasswordConfirm(
                                        oldPassword: value,
                                        newPassword: newPass));
                              }),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: DTextField(
                              isError: (newPass == '0')
                                  ? false
                                  : (state is ProfileSenderPasswordError &&
                                  state.newPassword.isEmpty)
                                  ? true
                                  : false,
                              label: 'Новый пароль',
                              onChanged: (value) {
                                newPass = value;
                                BlocProvider.of<ProfileBloc>(context).add(
                                    ProfileSenderPasswordConfirm(
                                        oldPassword: oldPass,
                                        newPassword: value));
                              }),
                          ),
                      ],
                    )),
                  );
                }),
              ),
            )));
  }
}
