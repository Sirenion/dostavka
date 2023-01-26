import 'package:dostavka/config/biometric.dart';
import 'package:dostavka/main.dart';
import 'package:dostavka/models/hive_connection/update.dart';
import 'package:dostavka/repositories/temporary_repository.dart';
import 'package:dostavka/widgets/buttons.dart';
import 'package:dostavka/widgets/text_view.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:dostavka/models/hive_connection/getters.dart';

import '../../../models/hive_connection/rep_data.dart';

class TouchIdReg extends StatelessWidget {
  const TouchIdReg({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const TouchIdReg());
  }

  @override
  Widget build(BuildContext context) {
    var user = Getters.getUser();
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              child: Padding(
                padding: EdgeInsets.fromLTRB(40.0, 10.0, 40.0, 0),
                child: Image(
                    image: AssetImage('images/touch_id.png'),
                    fit: BoxFit.contain),
              ),
            ),
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  TextView(
                      text: 'Хотите использовать Touch-ID для входа?',
                      fs: 30.0,
                      fw: FontWeight.w800),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 15.0, 0, 29.0),
                    child: TextView(
                      text:
                      'Это значительно повысит комфорт использования и ускорит вход в приложение',
                      fs: 17.0,
                      fw: FontWeight.w400,
                    ),
                  ),
                ]),
            Container(
                padding: const EdgeInsets.only(top: 10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CupertinoButtonPrimary(
                      textLabel: 'Не сейчас',
                      proceed: false,
                      callback: () {
                        Navigator.of(context).push(MyApp.route(0));
                      },
                    ),
                    const Padding(
                        padding: EdgeInsets.symmetric(vertical: 5)),
                    CupertinoButtonPrimary(
                      textLabel: 'Да, хочу',
                      proceed: true,
                      callback: () {
                        Update.EditUser(user.values.first, biometric: true);
                        Navigator.of(context).push(MyApp.route(0));
                      },
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
