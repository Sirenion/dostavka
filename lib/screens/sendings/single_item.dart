import 'dart:convert';
import 'dart:developer';

import 'package:dostavka/models/hive_connection/getters.dart';
import 'package:dostavka/screens/map/google_map_screen_third.dart';
import 'package:dostavka/screens/sendings/slider.dart';
import 'package:dostavka/screens/sendings/tracking.dart';
import 'package:dostavka/widgets/buttons.dart';
import 'package:dostavka/widgets/cards.dart';
import 'package:dostavka/widgets/navbar.dart';
import 'package:dostavka/widgets/progress_bar.dart';
import 'package:dostavka/widgets/text_view.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../connectors/api.dart';

class SingleItemReceive extends StatelessWidget {
  SingleItemReceive({Key? key,
    required this.id,
    required this.tab,
    required this.draft
  }) : super(key: key);

  final String id;
  final int tab;
  final List<dynamic> draft;

  static Route route({id, tab, draft}) {
    return MaterialPageRoute<void>(
        builder: (_) => SingleItemReceive(id: id, tab: tab, draft: draft));
  }

  @override
  Widget build(BuildContext context) {
    final s = getStatus(1, draft[3]);
    // List images = [
    // ];
    List images = [];
    // List images = [
    // ];
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
            appBar: Navbar(
              title: (tab == 0) ? 'Получение' : 'Отправление',
              buttonLeft: 0,
              buttonRight: 2,
            ),
            body: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  width: double.infinity,
                  child: FutureBuilder(
                      future: getDraft(),
                      builder: (BuildContext context,
                          AsyncSnapshot<Map<String, dynamic>> snapshot) {
                        if (snapshot.hasData) {
                          images.clear();
                          if (snapshot.data!["cargo"][0]["photos"] != null) {
                            if (snapshot.data!["cargo"][0]["photos"]
                                .toString() != "[]") {
                              for (var i = 0; i <
                                  snapshot.data!["cargo"][0]["photos"]
                                      .length; i++) {
                                images.add(
                                    "https://testarea.dostavka.info" + snapshot
                                        .data!["cargo"][0]["photos"][i]["url"]);
                              }
                            }
                          }
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.only(top: 25.0,
                                    bottom: 10.0),
                                child: TextView(
                                  text: id,
                                  fw: FontWeight.w600,
                                  fs: 17.0,
                                ),
                              ),
                              TextView(
                                text: '${draft[1]}',
                                fs: 25.0,
                                fw: FontWeight.w800,
                              ),
                              Container(
                                padding: const EdgeInsets.only(top: 15.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextView(
                                        text: s.item1,
                                        color: s.item2,
                                        fs: 17.0,
                                        fw: FontWeight.w600
                                    ),
                                    const TextView(
                                        text: 'Ожидается 15 сентября в 17:00',
                                        color: Color.fromRGBO(45, 58, 82, .5),
                                        fs: 13.0,
                                        fw: FontWeight.w600
                                    ),
                                  ],
                                ),
                              ),
                              if (images.isNotEmpty) ...[
                                CarouselSlide(
                                    listImages: images
                                ),
                              ],
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 10.0),
                                      child: TextView(
                                          text: 'Посылка',
                                          fs: 20.0,
                                          fw: FontWeight.w800
                                      ),
                                    ),
                                    TextViewField(
                                      name: 'Размеры',
                                      info: '${snapshot
                                          .data!["cargo"][0]["length"]}х${snapshot
                                          .data!["cargo"][0]["width"]}х${snapshot
                                          .data!["cargo"][0]["height"]}см',
                                      // "height":9.0,"width":12.0,"length":17.0,"weigh":1.0
                                    ),
                                    TextViewField(
                                      name: 'Вес',
                                      info: '${snapshot
                                          .data!["cargo"][0]["weigh"]} кг',
                                    ),
                                    TextViewField(
                                      name: 'Стоимость',
                                      info: '${snapshot
                                          .data!["cargo"][0]["declared_value"]}',
                                      isPrice: true,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 10.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment
                                            .center,
                                        children: [
                                          const TextView(
                                              text: 'Маршрут',
                                              fs: 20.0,
                                              fw: FontWeight.w800
                                          ),
                                          DTextButton(
                                            text: 'Отслеживать',
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                  Tracking.route());
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                    TextViewField(
                                      name: 'Откуда',
                                      info: '${snapshot
                                          .data!["user_1"]["addresses"][0]["address"]}',
                                    ),
                                    TextViewField(
                                      name: 'Куда',
                                      info: '${snapshot
                                          .data!["user_2"]["addresses"][0]["address"]}',
                                    ),
                                    const TextViewField(
                                      name: 'Служба доставки',
                                      info: 'СДЭК',
                                    ),
                                    TextViewField(
                                      name: 'Офис выдачи',
                                      info: '${snapshot.data!["office_from"]}',
                                      showOnMap: true,
                                      actionOnMap: () {
                                        Navigator.of(context).push(
                                            GoogleMapScreenThird.route());
                                      },
                                    ),
                                    TextViewField(
                                      name: 'До двери',
                                      info: snapshot.data!["courierBring"] ==
                                          true ? "Да" : "Нет",
                                    ),
                                    TextViewField(
                                      name: 'Оплата наличными',
                                      info: snapshot
                                          .data!["delivery_by_user_to"] == true
                                          ? "Да"
                                          : "Нет",
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
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
                                      info: '${snapshot
                                          .data!["user_1"]["first_name"]} ${snapshot
                                          .data!["user_1"]["last_name"]}',
                                    ),
                                    TextViewField(
                                      name: 'Телефон',
                                      info: '${snapshot
                                          .data!["user_1"]["username"]}',
                                    ),
                                    TextViewField(
                                      name: 'Адрес',
                                      info: '${snapshot
                                          .data!["user_1"]["addresses"][0]["address"]}',
                                    ),
                                  ],
                                ),
                              ),
                              // Container(
                              //   padding: const EdgeInsets.symmetric(
                              //       vertical: 20),
                              //   child: Column(
                              //     crossAxisAlignment: CrossAxisAlignment.start,
                              //     children: [
                              //       Padding(
                              //         padding: EdgeInsets.only(bottom: 10.0),
                              //         child: TextView(
                              //             text: 'Паспорт отправителя',
                              //             fs: 20.0,
                              //             fw: FontWeight.w800
                              //         ),
                              //       ),
                              //       TextViewField(
                              //         name: 'Серия',
                              //         info: '${snapshot
                              //             .data!["user_1"]["passport_number"][0]}${snapshot
                              //             .data!["user_1"]["passport_number"][1]}${snapshot
                              //             .data!["user_1"]["passport_number"][2]}${snapshot
                              //             .data!["user_1"]["passport_number"][3]}',
                              //       ),
                              //       TextViewField(
                              //         name: 'Номер',
                              //         info: '${snapshot
                              //             .data!["user_1"]["passport_number"][4]}${snapshot
                              //             .data!["user_1"]["passport_number"][5]}${snapshot
                              //             .data!["user_1"]["passport_number"][6]}${snapshot
                              //             .data!["user_1"]["passport_number"][7]}${snapshot
                              //             .data!["user_1"]["passport_number"][8]}${snapshot
                              //             .data!["user_1"]["passport_number"][9]}',
                              //       ),
                              //     ],
                              //   ),
                              // ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
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
                                      info: '${snapshot
                                          .data!["user_2"]["first_name"]} ${snapshot
                                          .data!["user_2"]["last_name"]}',
                                    ),
                                    TextViewField(
                                      name: 'Телефон',
                                      info: '${snapshot
                                          .data!["user_2"]["username"]}',
                                    ),
                                  ],
                                ),
                              ),
                              // StreamBuilder(stream: paymentUrl(int.parse(snapshot.data!["number"])),
                              //     builder: (BuildContext context,
                              //     AsyncSnapshot<dynamic> snapshot) {
                              //       print('hallow');
                              //   log('UR UR ----------- ${snapshot.toString()}');
                              //       if (snapshot.hasData) {
                              //         log('URL -------- ${snapshot.data}');
                              //         return Container();
                              //       } else if (snapshot.hasError) {
                              //         return Container();
                              //       } else {
                              //         return const ProgressBar();
                              //       }
                              //     })
                            ],
                          );
                        } else if (snapshot.hasError) {
                          return Container();
                        } else {
                          return const ProgressBar();
                        }
                      }
                  ),

                )
            )
        )
    );
  }

  Future<Map<String, dynamic>> getDraft() async{
    var sugg = Getters.getUser().values.first;
    var body = id.replaceAll("#", "");
    var response = Api.create();
    final data = await response.getDraft("sessionid=${sugg.sessionid}; csrftoken=${sugg.csrftoken}", body);
    print(data.bodyString);

    final res = new Map<String, dynamic>.from(data.body);
    final usr1d = await response.getUser("sessionid=${sugg.sessionid}; csrftoken=${sugg.csrftoken}", res["user_from"]);
    final usr2d = await response.getUser("sessionid=${sugg.sessionid}; csrftoken=${sugg.csrftoken}", res["user_to"]);
    final usr1 = new Map<String, dynamic>.from(usr1d.body);
    final usr2 = new Map<String, dynamic>.from(usr2d.body);
    res["user_1"] = usr1;
    res["user_2"] = usr2;
    print("AADSADSADAS ${res["cargo"][0]["photos"]}");

    print(res);
    return res;
  }
}

Stream<dynamic> paymentUrl(int number) {
  var data = {
    "number": number,
    };

  print("NUMBER ${data}");
  WebSocketChannel _channel = WebSocketChannel.connect(
      Uri.parse('wss://testarea.dostavka.info/mobile/ws/pay')

  );
  _channel.sink.add(jsonEncode(data));
  print('nasral v rakovinu');
  return _channel.stream;
}



