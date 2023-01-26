import 'dart:convert';
import 'dart:developer';

import 'package:dostavka/blocs/create_sending/create_sending_bloc.dart';
import 'package:dostavka/models/hive_connection/getters.dart';
import 'package:dostavka/models/hive_connection/update.dart';
import 'package:dostavka/screens/sendings_create/receiver.dart';
import 'package:dostavka/screens/sendings_create/sender_personal_data_1.dart';
import 'package:dostavka/widgets/bottom_nav.dart';
import 'package:dostavka/widgets/cards.dart';
import 'package:dostavka/widgets/navbar.dart';
import 'package:dostavka/widgets/progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class SendingOptions extends StatelessWidget {
  const SendingOptions({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(builder: (_) => const SendingOptions());
  }

  @override
  Widget build(BuildContext context) {
    int selectedIndex = -1;

    var transport = [];

    var draft = Getters
        .getDraft()
        .values
        .first;
    var user = Getters
        .getUser()
        .values
        .first;
    bool ch1 = false;
    bool ch2 = false;
    VoidCallback? callback;

    var i = 0;

    return BlocProvider<CreateSendingBloc>(
        create: (_) => CreateSendingBloc(),
        child: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Scaffold(
                appBar: const Navbar(
                  title: 'Варианты доставки',
                  buttonLeft: 0,
                  buttonRight: 5,
                ),
                bottomNavigationBar: BlocBuilder<CreateSendingBloc,
                    CreateSendingState>(
                    builder: (context, state) {
                      if (state is CreateSendingDeliveryCheckDoor) {
                        ch1 = state.toDoor;
                      }
                      if (state is CreateSendingDeliveryCheckPayment) {
                        ch2 = state.payment;
                      }
                      if (state is CreateSendingDeliveryTileSelected) {
                        callback = () {
                          log(Getters
                              .getDraft()
                              .values
                              .first
                              .toString());
                          Update.editDraft(
                              draft, courier_bring: ch1, payment: ch2, delivery: transport[i]);
                          log('${transport[i]} --------------- ${Getters
                              .getDraft()
                              .values
                              .first
                              .toString()}');

                          ///TODO: check user fields and nav to sender. mb new field?
                          user.last_name == '' ? Navigator.of(context).push(
                              SenderData1.route()) : Navigator.of(context).push(
                              ReceiverData.route());
                        };
                      }

                      return BottomNavWithSteps(
                        label: 'К выбору получателя',
                        isCheckBox: true,
                        ch1: ch1,
                        ch2: ch2,
                        step: 1,
                        onPressed: callback,
                      );
                    }
                ),
                body: StreamBuilder(
                    stream: deliveri(),
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.hasData) {
                        log(snapshot.data);
                        if(snapshot.data != "__EOF__"){
                          var transportItem = List<Map<String, dynamic>>.from(json.decode(snapshot.data));
                          if (transportItem.length > 1){
                            for(int j = 0; j < transportItem.length; j++){
                              if(transportItem[j]["error_message"] != null){

                              }
                              else{
                                transport.add(transportItem[j]);
                              }
                            }
                          }
                          else{
                            if(transportItem[0]["error_message"] != null){

                            }
                            else{
                              transport.add(transportItem[0]);
                            }
                          }
                        }
                        return BlocBuilder<CreateSendingBloc, CreateSendingState>(
                            builder: (context, state) {
                              if (state is CreateSendingDeliveryTileSelected) {
                                selectedIndex = state.id;
                              }
                              return ListView.builder(
                                itemCount: transport.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return ListTile(
                                    title: DCardDelivery(
                                        name: transport[index]['name'],
                                        days: transport[index]['time'],
                                        cost: transport[index]['cost']['total_cost']['cost'].toString(),
                                        logo: transport[index]['logo'],
                                        selected: (selectedIndex == transport[index]['service']['id'])
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 20.0, vertical: 0.0),
                                    onTap: () {
                                      i = index;
                                      BlocProvider.of<CreateSendingBloc>(context).add(
                                          CreateSendingDeliveryTileConfirm(
                                              id: transport[index]['service']['id'])
                                      );
                                    },
                                  );
                                },
                              );
                            }
                        );
                      } else if (snapshot.hasError) {
                        return Container();
                      } else {
                        return const ProgressBar();
                      }
                    }
                )

            )
        )
    );
  }
}

Stream<dynamic> deliveri() {
  var croco = Getters
      .getCreateOrder()
      .values
      .first;
  var cargo = Getters
      .getCargo()
      .values
      .first;
  var data = {
    'ad_from': croco.from["data"],
    'ad_to': croco.to["data"],
    'courierUp' : false,
    'courierBring': false,
    'cargo': [{
      'heig': cargo.height.toInt(),
      'len': cargo.length.toInt(),
      'dep': cargo.width.toInt(),
      'weig': cargo.weigh,
    }]
  };
  WebSocketChannel _channel = WebSocketChannel.connect(
      Uri.parse('wss://testarea.dostavka.info/mobile/ws/price')

  );
  _channel.sink.add(jsonEncode(data));
  return _channel.stream;
}


// {number: 5333077187419,
// user_from: +79021385527,
// user_to: +79026156359,
// date_create: 2022-04-15T23:02:19.674532+04:00,
// payment: false,
// office_from: null,
// submit: false,
// cargo: [
//   {draft: 5333077187419,
//   uuid: 372ba837-0dc5-4b48-9844-4c97fcf47899,
//   editable: true,
//   need_pack: false,
//   name: Ватные палочки,
//   height: 30.0,
//   width: 35.0,
//   length: 42.0,
//   weigh: 15.0,
//   declared_value: 0.0,
//   photos: null}],
// by_user_to: false,
// delivery_by_user_to: true,
// courier_bring: false,
// delivery: null,
// returned: false,
// free_keep: null,
//
//
