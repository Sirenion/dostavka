import 'package:dostavka/widgets/cards.dart';
import 'package:dostavka/widgets/progress_bar.dart';
import 'package:dostavka/widgets/text_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';

import '../connectors/api.dart';
import '../models/hive_connection/getters.dart';

class History extends StatelessWidget {
  const History({Key? key,
    required this.tab
  }) : super(key: key);

  final int tab;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _test_data(tab),
        builder: (BuildContext context,
            AsyncSnapshot<List<HT>> snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            if (snapshot.data!.isNotEmpty) {
              List<HT> entries = snapshot.data!;
              return GroupedListView(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                itemBuilder: (BuildContext context, HT element) {
                  return ListTile(
                    title: DCardSending(
                      id: element.id,
                      title: element.name,
                      name: element.from,
                      status: "",
                    ),
                  );
                },
                groupSeparatorBuilder: (DateTime date) =>
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      child: TextView(
                        text: date.toString(),
                        fw: FontWeight.w600,
                        fs: 17.0,
                      ),
                    ),

                order: GroupedListOrder.ASC,
                elements: entries,
                groupBy: (HT element) {
                  return element.date;
                },
              );
            }
            else {
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

class HT {
  final String id;
  final String name;
  final String from;
  final DateTime date;

  HT(this.id,this.name, this.from, this.date);
}

Future<List<HT>> _test_data(int tab) async{
  var response = Api.create();
  var cookies = Getters.getCookie().values.first;
  var user = Getters.getUser().values.first;
  List<HT> entries;
  if (tab == 0) {
    var result = await response.getOrders("csrftoken=${user.csrftoken}; sessionid=${user.sessionid}", "inbox", "history");
    print(result.bodyString);
    final data = new Map<String, dynamic>.from(result.body);
    print(data["data"].toString());
    if(data["data"].toString() != "[]"){
      entries = [];
      for (int i = 0; i < data.length; i++){
        entries.add(HT('#${data["data"][i]["number"]}', '${data["data"][i]["cargo"]}', 'от ${data["data"][i]["user_to"]}',
            DateTime.utc(2020, 7, 7)));
      }
    }
    else{
      entries = [
      ];
    }
  } else {
    var result = await response.getOrders("csrftoken=${user.csrftoken}; sessionid=${user.sessionid}", "outbox", "history");
    print(result.bodyString);
    final data = new Map<String, dynamic>.from(result.body);
    print(data["data"].toString());
    if(data["data"].toString() != "[]"){
        entries = [];
        for (int i = 0; i < data.length; i++){
          entries.add(HT('#${data["data"][i]["number"]}', '${data["data"][i]["cargo"]}', 'для ${data["data"][i]["user_from"]}',
              DateTime.utc(2020, 7, 7)));
        }
    }
    else{
      entries = [
      ];
    }
  }
  return entries;
}
