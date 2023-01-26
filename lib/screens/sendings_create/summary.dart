import 'package:dostavka/models/hive_connection/getters.dart';
import 'package:dostavka/screens/sendings_create/success.dart';
import 'package:dostavka/widgets/bottom_nav.dart';
import 'package:dostavka/widgets/navbar.dart';
import 'package:dostavka/widgets/text_view.dart';
import 'package:flutter/material.dart';

class Summary extends StatelessWidget {
  const Summary({Key? key,

  }) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const Summary());
  }

  @override
  Widget build(BuildContext context) {

    var user = Getters.getUser().values.first;
    var userReceiver = Getters.getUser().values.last;
    var draft = Getters.getDraft().values.first;
    var cargo = Getters.getCargo().values.first;

    print(Getters.getDraft().values.first.toString());
    print(draft.date_create);
    print(draft.user_from);
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
            appBar: const Navbar(
              title: 'Итог',
              buttonLeft: 0,
            ),
            bottomNavigationBar: BottomNavWithSteps(
              step: 2,
              label: 'Создать отправление',
              onPressed: () {
                Navigator.of(context).push(SendingCreationSuccess.route());
              },
            ),
            body: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(bottom: 10.0),
                            child: TextView(
                                text: 'Посылка',
                                fs: 20.0,
                                fw: FontWeight.w800
                            ),
                          ),
                          TextViewField(
                            name: 'Название',
                            info: cargo.name,
                          ),
                          TextViewField(
                            name: 'Размеры',
                            info: '${cargo.length}x${cargo.width}x${cargo.height}см',
                          ),
                          TextViewField(
                            name: 'Вес',
                            info: cargo.weigh > 1.0 ? '${cargo.weigh}' : 'менее 1кг',
                          ),
                          TextViewField(
                            name: 'Стоимость',
                            info: '${cargo.declared_value}',
                            isPrice: true,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:  [
                          Padding(
                            padding: EdgeInsets.only(bottom: 10.0),
                            child: TextView(
                                    text: 'Маршрут',
                                    fs: 20.0,
                                    fw: FontWeight.w800
                                ),
                            ),
                          TextViewField(
                            name: 'Откуда',
                            info: draft.user_from,
                          ),
                          TextViewField(
                            name: 'Куда',
                            info: userReceiver.address,
                          ),
                          TextViewField(
                            name: 'Служба доставки',
                            info: 'СДЭК',
                          ),
                          TextViewField(
                            name: 'Офис выдачи',
                            info: 'Бульвар Ладыгина, 52',
                          ),
                          TextViewField(
                            name: 'До двери',
                            info: draft.courier_bring ? 'Да' : 'Нет',
                          ),
                          TextViewField(
                            name: 'Оплата наличными',
                            info: draft.payment ? 'Да' : 'Нет',
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:  [
                          Padding(
                            padding: EdgeInsets.only(bottom: 10.0),
                            child: TextView(
                                text: 'Получатель',
                                fs: 20.0,
                                fw: FontWeight.w800
                            ),
                          ),
                          TextViewField(
                            name: 'ФИО',
                            ///????????? где заполняем?
                            info: 'Захаров Вячеслав Олегович',
                          ),
                          TextViewField(
                            name: 'Телефон',
                            info: userReceiver.username,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:  [
                          Padding(
                            padding: EdgeInsets.only(bottom: 10.0),
                            child: TextView(
                                text: 'Отправитель',
                                fs: 20.0,
                                fw: FontWeight.w800
                            ),
                          ),
                          TextViewField(
                            name: 'ФИО',
                            info: '${user.second_name} ${user.first_name} ${user.last_name}',
                          ),
                          TextViewField(
                            name: 'Телефон',
                            info: user.username,
                          ),
                          TextViewField(
                            name: 'Адрес',
                            info: user.address,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
        )
    );
  }
}

