 import 'package:dostavka/screens/sendings/single_item.dart';
import 'package:dostavka/widgets/cards.dart';
import 'package:dostavka/widgets/progress_bar.dart';
import 'package:dostavka/widgets/text_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../connectors/api.dart';
import '../../models/hive_connection/getters.dart';
import '../../models/hive_connection/update.dart';

class Received extends StatelessWidget {
  const Received({Key? key,
    required this.tab
  }) : super(key: key);

  final int tab;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _test_data(tab),
        builder: (BuildContext context,
            AsyncSnapshot<List<List<String>>> snapshot) {
          if (snapshot.hasData && snapshot.data != null)  {
            if (snapshot.data!.isNotEmpty) {
              List<List<String>> entries = snapshot.data!;
              return ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                itemCount: entries.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                      title: DCardSending(
                        id: entries[index][0],
                        title: entries[index][1],
                        name: entries[index][2],
                        status: entries[index][3],
                      ),
                      onTap: () {
                        Navigator.of(context).push(SingleItemReceive.route(
                            id: entries[index][0],
                            tab: tab,
                            draft: entries[index]));
                      }
                  );
                },
              );
            } else {
              return Center(
                child: TextView(
                  fs: 16,
                  text: (tab == 0)
                      ? 'Нет активных получений'
                      : 'Нет активных отправлений',
                  fw: FontWeight.w600,
                  color: CupertinoColors.inactiveGray,
                ),
              );
            }
          } else if (snapshot.hasError) {
            return Container();
          } else {
            return const ProgressBar();
          }
        }
    );
  }
}

Future<List<List<String>>> _test_data(int tab) async{
  var response = Api.create();
  var cookies = Getters.getCookie().values.first;
  var user = Getters.getUser().values.first;

  final List<String> entry1 = <String>[
    '#4232552517902',
    'Очень секретные документы',
    'от Захаров Вячеслав'
  ];
  final List<String> entry2 = <String>[
    '#42325524354353',
    'Документы',
    'от Захаров Вячеслав'
  ];
  List<List<String>> entries = [];
  if (tab == 0) {
    var result = await response.getDrafts("csrftoken=${user.csrftoken}; sessionid=${user.sessionid}", "inbox");
    print(result.bodyString);
    final data = new Map<String, dynamic>.from(result.body);
    print(data["data"].toString());
    if(data["data"].isNotEmpty){
      entries.clear();
      print(data.length);
      for (int i = 0; i < data.length; i++){
        print("append");
        entries.add(<String>[
          '#${data["data"][i]["number"]}',
          '${data["data"][i]["cargo"]}',
          'для ${data["data"][i]["user_to"]}',
          '${data["data"][i]["status"]}'
        ]);
      }
    }
    else{
      entries = [
      ];
    }
  } else {
    var result = await response.getDrafts("csrftoken=${user.csrftoken}; sessionid=${user.sessionid}", "outbox");
    print(result.bodyString);
    final data = new Map<String, dynamic>.from(result.body);
    print(data["data"].toString());
    if(data["data"].isNotEmpty){
      entries.clear();
      for (int i = 0; i < data.length; i++){
        entries.add(<String>[
          '#${data["data"][i]["number"]}',
          '${data["data"][i]["cargo"]}',
          'для ${data["data"][i]["user_to"]}',
          '${data["data"][i]["status"]}'
        ]);
      }
    }
    else{
      entries = [
      ];
    }
  }
  return entries;
}
