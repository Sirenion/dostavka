import 'package:dostavka/widgets/text_view.dart';
import 'package:dostavka/widgets/cards.dart';
import 'package:dostavka/widgets/navbar.dart';
import 'package:flutter/material.dart';

class N {
  final String id;
  final int status;
  final String date;
  final bool isNew;

  N(this.id, this.status, this.date, this.isNew);
}

class Notifications extends StatelessWidget {
  const Notifications({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const Notifications());
  }

  @override
  Widget build(BuildContext context) {
    List<N> entries = [
      N('#4232552517902', 1, 'сегодня в 14:29', true),
      N('#4232552517902', 2, 'сегодня в 14:29', true),
      N('#4232552517902', 3, 'сегодня в 14:29', true),
      N('#4232552517902', 1, 'сегодня в 14:29', false),
      N('#4232552517902', 2, 'сегодня в 14:29', false),
      N('#4232552517902', 3, 'сегодня в 14:29', false),
      N('#4232552517902', 4, 'сегодня в 14:29', false),
      N('#4232552517902', 1, 'сегодня в 14:29', false),
    ];
    return Scaffold(
        appBar: const Navbar(
          title: 'Уведомления',
          buttonLeft: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 10.0),
                child: TextView(
                  text: 'Новые',
                  fs: 17.0,
                  fw: FontWeight.w600,
                ),
              ),
              ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  itemCount: entries.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: DCardNotification(
                        id: entries[index].id,
                        status: entries[index].status,
                        date: entries[index].date,
                      ),
                    );
                  }
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: TextView(
                  text: 'Просмотренные',
                  fs: 17.0,
                  fw: FontWeight.w600,
                ),
              ),
              ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  itemCount: entries.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: DCardNotification(
                        id: entries[index].id,
                        status: entries[index].status,
                        date: entries[index].date,
                        payment: true,
                        price: '1000',
                      ),
                    );
                  }
              ),
            ],
          ),
        )
    );
  }
}
