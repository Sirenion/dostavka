import 'dart:convert';
import 'dart:developer';

import 'package:dostavka/blocs/create_sending/create_sending_bloc.dart';
import 'package:dostavka/models/hive_connection/getters.dart';
import 'package:dostavka/screens/sendings_create/summary.dart';
import 'package:dostavka/widgets/bottom_nav.dart';
import 'package:dostavka/widgets/cards.dart';
import 'package:dostavka/widgets/navbar.dart';
import 'package:dostavka/widgets/progress_bar.dart';
import 'package:dostavka/widgets/text_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class NearestPoint extends StatelessWidget {
  const NearestPoint({Key? key,
    required this.DraftNumber

  }) : super(key: key);

  static Route route(int drn) {
    return MaterialPageRoute<void>(
        builder: (_) => NearestPoint(DraftNumber: drn,));
  }

  final int DraftNumber;

  @override
  Widget build(BuildContext context) {
    int selectedIndex = 1;
    List<Map<String, dynamic>> entries = [];
    var error = {};
    return BlocProvider<CreateSendingBloc>(
        create: (_) => CreateSendingBloc(),
        child: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Scaffold(
              appBar: PreferredSize(
                  preferredSize: const Size.fromHeight(65),
                  child: BlocBuilder<CreateSendingBloc, CreateSendingState>(
                      builder: (context, state) {
                        if (state is CreateSendingDeliveryTileSelected) {
                          selectedIndex = state.id;
                          print('ERROR ----- $error');
                        }
                        if (state is CreateSendingDeliveryDataDownloaded) {
                          entries = state.data;
                        }
                        return Navbar(
                          title: 'Ближайшие пункты',
                          buttonLeft: 0,
                          buttonRight: (selectedIndex != -2) ? 4 : null,
                          map: (entries.isNotEmpty) ? entries : null,
                        );
                      }
                  )
              ),
              bottomNavigationBar: BlocBuilder<CreateSendingBloc,
                  CreateSendingState>(
                  builder: (context, state) {
                    print('selectedIndex - $selectedIndex');
                    VoidCallback? callback = (state is CreateSendingDeliveryTileSelected)
                        ? () {
                      Navigator.of(context).push(Summary.route());
                    } : null;
                    return BottomNavWithSteps(
                      step: 2,
                      label: 'Далее',
                      onPressed: callback,
                    );
                  }
              ),
              body: StreamBuilder(
                  stream: nearest(DraftNumber),
                  builder: (BuildContext context,
                      AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data != null && snapshot.data != "__EOF__") {
                        log(snapshot.toString());
                        try {
                          entries.clear();
                          entries = List<Map<String, dynamic>>.from(
                              jsonDecode(snapshot.data));
                          log(entries.toString());
                          entries.sort((a, b) {
                            var aItem = a['distance'];
                            var bItem = b['distance'];
                            return aItem.compareTo(bItem);
                          });
                          BlocProvider.of<CreateSendingBloc>(
                              context).add(
                              CreateSendingDeliveryDataReceived(
                                  data: entries));
                          error.clear();
                        } on TypeError {
                          error =
                          Map<String, dynamic>.from(jsonDecode(snapshot.data));
                          selectedIndex = -2;
                          BlocProvider.of<CreateSendingBloc>(
                              context).add(
                              const CreateSendingDeliveryTileConfirm(
                                  id: -2));
                          print('Error - ${error['error']}');
                        }
                      } else {
                        error.clear();
                        entries.clear();
                      }
                      return error.isNotEmpty ?
                      Center(
                        child: Text(
                          error['error'],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: CupertinoColors.inactiveGray,
                          ),
                        ),
                      )
                          : BlocBuilder<CreateSendingBloc, CreateSendingState>(
                          builder: (context, state) {
                            if (state is CreateSendingDeliveryTileSelected) {
                              selectedIndex = state.id;
                            }
                            return ListView.builder(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5.0),
                              itemCount: entries.length,
                              itemBuilder: (BuildContext context, int index) {
                                return ListTile(
                                    title: DCardMap(
                                      range: entries[index]['distance'],
                                      address: entries[index]['addr'],
                                      selected: (selectedIndex ==
                                          entries[index]['lat'].toInt()),
                                    ),
                                    onTap: () {
                                      BlocProvider.of<CreateSendingBloc>(
                                          context).add(
                                          CreateSendingDeliveryTileConfirm(
                                              id: entries[index]['lat'].toInt()
                                          )
                                      );
                                    }
                                );
                              },
                            );
                          }
                      );
                    } else if (snapshot.hasError) {
                      return Container();
                    } else {
                      return ProgressBar();
                    }
                  }
              ),
            )
        )
    );
  }
}

Stream<dynamic> nearest(DraftNumber) {
  var id = Getters.getDraft().values.first.delivery['service']['id'];
  var data = {
    "number": DraftNumber,
    "service_id": id,
  };
  WebSocketChannel _channel = WebSocketChannel.connect(
      Uri.parse('wss://testarea.dostavka.info/mobile/ws/pvz_list')

  );
  _channel.sink.add(jsonEncode(data));
  return _channel.stream;
}




