import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:dostavka/blocs/create_sending/create_sending_bloc.dart';
import 'package:dostavka/models/hive_connection/getters.dart';
import 'package:dostavka/models/hive_connection/update.dart';
import 'package:dostavka/screens/sendings_create/nearest.dart';
import 'package:dostavka/widgets/bottom_nav.dart';
import 'package:dostavka/widgets/navbar.dart';
import 'package:dostavka/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../connectors/api.dart';
import 'package:dostavka/connectors/suggest.dart';

class ReceiverAddress extends StatelessWidget {
  const ReceiverAddress({Key? key,

  }) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const ReceiverAddress());
  }

  @override
  Widget build(BuildContext context) {

    String userStreet = 'ξ';
    String userBuilding = 'ξ';
    String userBuildingAdd = '';
    String userApartment = '';

//     String userStreet = ' ';
//     String userBuilding = ' ';
//     String userBuildingAdd = ' ';
//     String userApartment = ' ';
    var userReceiver = Getters.getUser().values.last;
    var draft = Getters.getDraft().values.first;

    return BlocProvider<CreateSendingBloc>(
        create: (_) => CreateSendingBloc(),
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Scaffold(
            appBar: const Navbar(
              title: 'Адрес получателя',
              buttonLeft: 0,
            ),
            bottomNavigationBar: BlocBuilder<CreateSendingBloc,
                CreateSendingState>(
                builder: (context, state) {
                  VoidCallback? callback = (state is CreateSendingReceiverAddressSuccess)
                      ? () async {
                    var usr = Getters.getUser().values.last;
                    var cargodat = Getters.getCreateOrder().values.first;
                    Update.EditUser(userReceiver,
                        address: 'г. ' +
                            draft.user_to +
                            ', ул. ' +
                            userStreet +
                            ', д. ' +
                            userBuilding +
                            (userBuildingAdd != ''
                                ? ', к. $userBuildingAdd'
                                : '') +
                            (userApartment != ''
                                ? ', кв. $userApartment'
                                : ''));
                    var sugg = Getters
                        .getSuggest()
                        .values
                        .first;
                    var ordTaker = Getters.getOrdTaker().values.first;
                    // var suggestionResponse = Suggest.create();
                    // final data = await suggestionResponse.getAddressSuggest(
                    //     "Token ${sugg.token}", usr.address, {}, {});
                    // final result = Map<String, List<dynamic>>.from(data.body);
                    var body;
                    var user = Getters
                        .getUser()
                        .values
                        .first;
                    var cook = Getters
                        .getCookie()
                        .values
                        .first;
                    var tok = cook.csrftoken.replaceAll("csrftoken=", "");
                    var phoneInf = user.username;
                    phoneInf = phoneInf.replaceAll(" ", "");
                    phoneInf = phoneInf.replaceAll("-", "");
                    var phoneInf2 = usr.username;
                    phoneInf2 = phoneInf2.replaceAll(" ", "");
                    phoneInf2 = phoneInf2.replaceAll("-", "");
                    var delivery = Getters.getDraft().values.first;
                    var suggestionResponse = Suggest.create();
                    final suggdata = await suggestionResponse.getAddressSuggest(
                        "Token ${sugg.token}", usr.address, {}, {});

                    final suggresult = Map<String, List<dynamic>>.from(suggdata.body);

                    var suggbody;
                    if (suggresult != null && suggresult["suggestions"]!.isNotEmpty) {
                      suggbody = {
                        "username": phoneInf2,
                        "address": usr.address,
                        "address_data": json.encode(suggresult["suggestions"]![0]["data"]),
                      };

                    }
                    else {
                      suggbody = {"username": phoneInf2, "address": usr.address};
                    }
                    var response = Api.create();

                    var inf = await response.getUser("csrftoken=${user.csrftoken}; sessionid=${user.sessionid}", phoneInf);
                    print("HOLA AMIGO");
                    print("NEW INFO FROM SERVER ${inf.bodyString}");
                    final userdata1 = new Map<String, dynamic>.from(inf.body);
                    if (userdata1["addresses"].isEmpty){
                      var res = await response.createAddress(
                          "csrftoken=${tok}; sessionid=${user.sessionid}", tok,
                          body);
                      if (res.bodyString != null) {
                        print("RESPONSE");
                        print(res.bodyString);
                        body = {
                          "user_from": phoneInf,
                          "user_to": phoneInf2,
                          "by_user_to": false,
                          // "delivery": json.encode(delivery.delivery),
                        };
                        // }
                        // else {
                        //   // body = {"username": phoneInf, "address": usr.address};
                        // }

                        final createDraft = await response.createDraft("csrftoken=${tok}; sessionid=${cook.sessionid}", tok, body);
                        print(createDraft.bodyString);
                        var draftData = new Map<String, dynamic>.from(createDraft.body);



                        var carg = Getters.getCargo().values.first;
                        var cargobody = {
                          "need_pack": false,
                          "name": carg.name,
                          "height": carg.height,
                          "width": carg.width,
                          "length": carg.length,
                          "weigh": carg.weigh,
                          "declaired_value": carg.declared_value,
                          "draft": draftData["number"]
                        }
                        var data = await response.createCargo("sessionid=${cook.sessionid}; ${cook.csrftoken}", tok, cargobody);
                        var resp = new Map<String, dynamic>.from(data.body);
                        print (resp);
                        Update.editCargo(carg,
                            uuid: resp["uiid"]);
                        Navigator.of(context).push(NearestPoint.route(int.parse(draftData["number"])));
                      }
                    }
                    else{
                      var res = await response.setAddress(
                          "csrftoken=${tok}; sessionid=${user.sessionid}", tok,
                          body);
                      if (res.bodyString != null) {
                        print("RESPONSE");
                        print(res.bodyString);
                        body = {
                          "user_from": phoneInf,
                          // "user_to": phoneInf2,
                          "by_user_to": false,
                          // "delivery": json.encode(delivery.delivery),
                        };
                        print("BODY OF DRAFT++++++++++++ ${body}")
                        // }
                        // else {
                        //   // body = {"username": phoneInf, "address": usr.address};
                        // }

                        final createDraft = await response.createDraft("csrftoken=${tok}; sessionid=${cook.sessionid}", tok, body);
                        print(createDraft.bodyString);
                        var draftData = new Map<String, dynamic>.from(createDraft.body);
                        var dr = Getters.getDraft().values.first;
                        var recb = {
                          "number" : draftData["number"],
                          "user_to": phoneInf2,
                          "delivery": json.encode(dr.delivery)

                        }
                        final addreciever = await response.changeDraft("csrftoken=${tok}; sessionid=${cook.sessionid}", tok, recb)
                        var recdat = new Map<String, dynamic>.from(addreciever.body);
                        print(recdat);

                        var carg = Getters.getCargo().values.first;
                        var cargobody = {
                          "need_pack": false,
                          "name": carg.name,
                          "height": carg.height,
                          "width": carg.width,
                          "length": carg.length,
                          "weigh": carg.weigh,
                          "declaired_value": carg.declared_value,
                          "draft": draftData["number"],
                        }
                        var data = await response.createCargo("sessionid=${cook.sessionid}; ${cook.csrftoken}", tok, cargobody);
                        var resp = new Map<String, dynamic>.from(data.body);
                        print (resp);
                        Update.editCargo(carg,
                            uuid: resp["uiid"]);
                        Navigator.of(context).push(NearestPoint.route(draftData["number"]));
                      }
                    }

                    // if (result != null && result["suggestions"]!.isNotEmpty) {

                  } : null;
                  return BottomNavWithSteps(
                    step: 2,
                    label: 'Далее',
                    onPressed: callback,
                  );
                }
            ),
            body: Container(
                margin: const EdgeInsets.all(20.0),
                child: BlocBuilder<CreateSendingBloc, CreateSendingState>(
                    builder: (context, state) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 10.0),
                            child: DTextField(
                                isError: (userStreet == 'ξ')
                                    ? false : (state is CreateSendingReceiverAddressError &&
                                    state.street.isEmpty)
                                    ? true : false,
                                label: 'Улица',
                                maxLength: 40,
                                onChanged: (value) {
                                  userStreet = value;
                                  BlocProvider.of<CreateSendingBloc>(context).add(
                                      CreateSendingReceiverAddressConfirm(
                                          street: value,
                                          building: userBuilding)
                                  );
                                }
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: DTextField(
                                    isError: (userBuilding == 'ξ')
                                        ? false : (state is CreateSendingReceiverAddressError &&
                                        state.building.isEmpty)
                                        ? true : false,
                                    label: 'Дом',
                                    maxLength: 5,
                                    typeFormat: 2,
                                    keyboardType: TextInputType.number,
                                    onChanged: (value) {
                                      userBuilding = value;
                                      BlocProvider.of<CreateSendingBloc>(context).add(
                                          CreateSendingReceiverAddressConfirm(
                                              street: userStreet,
                                              building: value)
                                      );
                                    }
                                ),
                              ),
                              const Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 5.0)
                              ),
                              Expanded(
                                child: DTextField(
                                  label: 'Корп.',
                                  maxLength: 5,
                                  typeFormat: 2,
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    userBuildingAdd = value;
                                  },
                                ),
                              ),
                              const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 5)
                              ),
                              Expanded(
                                child: DTextField(
                                  label: 'Кв.',
                                  maxLength: 5,
                                  typeFormat: 3,
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    userApartment = value;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    }
                )
            ),
          ),
        )
    );
  }
}

