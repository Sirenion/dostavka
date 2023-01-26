import 'package:dostavka/main.dart';
import 'package:dostavka/widgets/buttons.dart';
import 'package:dostavka/widgets/text_view.dart';
import 'package:flutter/material.dart';

class SendingCreationSuccess extends StatelessWidget {
  const SendingCreationSuccess({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(
        builder: (_) => const SendingCreationSuccess());
  }

  @override
  Widget build(BuildContext context) {
    var id = '#4232552517902';
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
                    image: AssetImage('images/completed.png'),
                    fit: BoxFit.contain
                ),
              ),
            ),
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                        style: const TextStyle(
                          fontFamily: 'Exo2.0',
                          fontWeight: FontWeight.w800,
                          fontSize: 30.0,
                          color: Color(0xFF2D3A52),
                        ),
                        children: <TextSpan>[
                          const TextSpan(text: 'Отправление '),
                          TextSpan(
                            text: id,
                            style: const TextStyle(
                              color: Color(0xFFF0674C),
                            ),
                          ),
                          const TextSpan(
                            text: ' успешно создано!',
                          ),
                        ]
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 15.0, 0, 29.0),
                    child: TextView(
                      text: 'Осталось только выбрать пункт отправления и принести туда посылку.',
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
                      textLabel: 'Позже',
                      proceed: false,
                      callback: () {
                        Navigator.of(context).push(MyApp.route(0));
                      },
                    ),
                    const Padding(
                        padding: EdgeInsets.symmetric(vertical: 5)
                    ),
                    CupertinoButtonPrimary(
                      textLabel: 'Посмотреть пункты',
                      proceed: true,
                      callback: () {
                        Navigator.of(context).push(MyApp.route(2));
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