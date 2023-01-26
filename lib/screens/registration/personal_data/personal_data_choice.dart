import 'package:dostavka/screens/pin/create_pin_page.dart';
import 'package:dostavka/screens/registration/personal_data/personal_data_p1.dart';
import 'package:dostavka/widgets/buttons.dart';
import 'package:dostavka/widgets/text_view.dart';
import 'package:flutter/material.dart';

class PersonalDataChoice extends StatelessWidget {
  const PersonalDataChoice({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const PersonalDataChoice());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              child: Padding(
                padding: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 0),
                child: Image(
                    image: AssetImage('images/reg_3.png'),
                    fit: BoxFit.contain
                ),
              ),
            ),
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  TextView(
                      text: 'Хотите заполнить свои данные сейчас?',
                      fs: 30.0,
                      fw: FontWeight.w800
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 15.0, 0, 29.0),
                    child: TextView(
                      text: 'Они понадобятся в будущем для совершения отправлений и принятий посылок.',
                      fs: 17.0,
                      fw: FontWeight.w400,
                    ),
                  ),
                ]
            ),
            Container(
                padding: const EdgeInsets.only(top: 20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CupertinoButtonPrimary(
                      textLabel: 'Не сейчас',
                      proceed: false,
                      callback: () {
                        Navigator.of(context).push(CreatePIN.route());
                      },
                    ),
                    const Padding(
                        padding: EdgeInsets.symmetric(vertical: 5)
                    ),
                    CupertinoButtonPrimary(
                      textLabel: 'Да, хочу',
                      proceed: true,
                      callback: () {
                        Navigator.of(context).push(PersonalData1.route());
                      },
                    ),
                  ],
                )
            )
          ],
        ),
      ),
    );
  }
}
