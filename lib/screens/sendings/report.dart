import 'package:dostavka/screens/sendings/change_user_data.dart';
import 'package:dostavka/screens/sendings/other.dart';
import 'package:dostavka/screens/sendings/pretension.dart';
import 'package:dostavka/widgets/navbar.dart';
import 'package:dostavka/widgets/text_view.dart';
import 'package:flutter/material.dart';

class ReportProblem extends StatelessWidget {
  const ReportProblem({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const ReportProblem());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
            appBar: const Navbar(
              title: 'Сообщить о проблеме',
              buttonLeft: 0,
            ),
            body: Container(
              margin: const EdgeInsets.all(20.0),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  InkWell(
                    child: TextViewFieldSecondary(
                        text: 'Изменить данные получателя'
                    ),
                    onTap: () {
                      Navigator.of(context).push(ChangeUserData.route());
                    },
                  ),
                  InkWell(
                    child: TextViewFieldSecondary(
                        text: 'Претензия по отправлению'
                    ),
                    onTap: () {
                      Navigator.of(context).push(Pretension.route());
                    },
                  ),
                  InkWell(
                    child: TextViewFieldSecondary(
                        text: 'Другое'
                    ),
                    onTap: () {
                      Navigator.of(context).push(Other.route());
                    },
                  )
                ],
              ),
            )
        )
    );
  }
}
