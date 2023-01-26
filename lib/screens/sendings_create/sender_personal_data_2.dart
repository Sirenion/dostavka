import 'dart:convert';

import 'package:dostavka/blocs/registration/reg_bloc.dart';
import 'package:dostavka/models/hive_connection/getters.dart';
import 'package:dostavka/models/hive_connection/update.dart';
import 'package:dostavka/screens/sendings_create/receiver.dart';
import 'package:dostavka/widgets/bottom_nav.dart';
import 'package:dostavka/widgets/modals.dart';
import 'package:dostavka/widgets/navbar.dart';
import 'package:dostavka/widgets/text_field.dart';
import 'package:dostavka/widgets/text_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../connectors/api.dart';
import '../../connectors/suggest.dart';

class SenderData2 extends StatelessWidget {
  const SenderData2({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(builder: (_) => const SenderData2());
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController c1 = TextEditingController();
    String userCity = 'ξ';
    String userStreet = 'ξ';
    String userBuilding = 'ξ';
    String userBuildingAdd = '';
    String userApartment = '';
    return BlocProvider<RegBloc>(
        create: (_) => RegBloc(),
        child: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Scaffold(
                appBar: const Navbar(title: 'Отправитель (2/2)', buttonLeft: 0),
                bottomNavigationBar:
                    BlocBuilder<RegBloc, RegState>(builder: (context, state) {
                  VoidCallback? callback = (state is RegAddressSuccess)
                      ? () async{
                    var user = Getters
                        .getUser()
                        .values
                        .first;
                    Update.EditUser(user,
                        address: 'г. ' +
                            userCity +
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
                    var response = Api.create();

                    var cook = Getters
                        .getCookie()
                        .values
                        .first;
                    var tok = cook.csrftoken.replaceAll("csrftoken=", "");
                    var middlecsrf = {"csrfmiddlewaretoken"};
                    var usr = Getters
                        .getUser()
                        .values
                        .first;
                    var phoneInf = usr.username;
                    phoneInf = phoneInf.replaceAll(" ", "");
                    phoneInf = phoneInf.replaceAll("-", "");
                    var sugg = Getters
                        .getSuggest()
                        .values
                        .first;
                    var param = { 'value': 'city'};
                    var suggestionResponse = Suggest.create();
                    final data = await suggestionResponse.getAddressSuggest(
                        "Token ${sugg.token}", usr.address, {}, {});
                    final result = Map<String, List<dynamic>>.from(data.body);
                    var body;
                    if (result != null && result["suggestions"]!.isNotEmpty) {
                      body = {
                        "username": phoneInf,
                        "address": usr.address,
                        "address_data": json.encode(result["suggestions"]![0]["data"]),
                      };
                    }
                    else {
                      body = {"username": phoneInf, "address": usr.address};
                    }
                    print("QUERY INFO ======================");
                    print("${body}")
                    print("END QUERY INFO ======================");
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
                        var info = await response.getUser("csrftoken=${user.csrftoken}; sessionid=${user.sessionid}", phoneInf);
                        final userdata11 = new Map<String, dynamic>.from(info.body);
                        Update.EditUser(user, address: userdata11["addresses"][0]["address"]);
                        Navigator.of(context).push(ReceiverData.route());
                      }
                    }
                    else{
                      var res = await response.setAddress(
                          "csrftoken=${tok}; sessionid=${user.sessionid}", tok,
                          body);
                      if (res.bodyString != null) {
                        print("RESPONSE");
                        var info = await response.getUser("csrftoken=${user.csrftoken}; sessionid=${user.sessionid}", phoneInf);
                        final userdata11 = new Map<String, dynamic>.from(info.body);
                        Update.EditUser(user, address: userdata11["addresses"][0]["address"]);
                        print(res.bodyString);
                        Navigator.of(context).push(ReceiverData.route());
                      }
                    }

                  }
                      : null;
                  return BottomNavWithSteps(
                    label: 'Далее',
                    step: 2,
                    onPressed: callback,
                  );
                }),
                body: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: BlocBuilder<RegBloc, RegState>(
                        builder: (context, state) {

                          c1.addListener(() {
                            userCity = c1.text;
                            BlocProvider.of<RegBloc>(context).add(
                                RegAddressConfirm(
                                    city: c1.text,
                                    street: userStreet,
                                    building: userBuilding)
                            );
                          });
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const TextView(
                                text: 'Поскольку Вас ещё нет в системе, нужно указать свои личные данные. \nЭто делается всего один раз.',
                                fs: 17,
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 20.0),
                                child: DModalCityButton(
                                  controller: c1,
                                  isError: (userCity == 'ξ')
                                      ? false : (state is RegAddressError &&
                                      state.city.isEmpty)
                                      ? true : false,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10.0),
                                child: DTextField(
                                    isError: (userStreet == 'ξ')
                                        ? false : (state is RegAddressError &&
                                        state.street.isEmpty)
                                        ? true : false,
                                    label: 'Улица',
                                    maxLength: 40,
                                    onChanged: (value) {
                                      userStreet = value;
                                      BlocProvider.of<RegBloc>(context).add(
                                          RegAddressConfirm(city: userCity,
                                              street: value,
                                              building: userBuilding)
                                      );
                                    }
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10.0),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(
                                        child: DTextField(
                                          isError: (userBuilding == 'ξ')
                                              ? false
                                              : (state is RegAddressError &&
                                              state.building.isEmpty)
                                              ? true : false,
                                          label: 'Дом',
                                          maxLength: 5,
                                          typeFormat: 2,
                                          keyboardType: TextInputType.number,
                                          onChanged: (value) {
                                            userBuilding = value;
                                            BlocProvider.of<RegBloc>(context)
                                                .add(
                                                RegAddressConfirm(
                                                    city: userCity,
                                                    street: userStreet,
                                                    building: value)
                                            );
                                          },
                                        ),
                                      ),
                                      const Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 5)),
                                      Expanded(
                                        child: DTextField(
                                          label: 'Корп.',
                                          maxLength: 5,
                                          typeFormat: 2,
                                          keyboardType: TextInputType.text,
                                          onChanged: (value) {
                                            userBuildingAdd = value;
                                          },
                                        ),
                                      ),
                                      const Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 5)),
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
                                    ]
                                ),
                              )
                            ],
                          );
                        }
                    )
                )
            )
        )
    );

//                       c1.addListener(() {
//                         userCity = c1.text;
//                         BlocProvider.of<RegBloc>(context).add(RegAddressConfirm(
//                             city: c1.text,
//                             street: userStreet,
//                             building: userBuilding));
//                       });
//                       return Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           const TextView(
//                             text:
//                                 'Поскольку Вас ещё нет в системе, нужно указать свои личные данные. \nЭто делается всего один раз.',
//                             fs: 17,
//                           ),
//                           Container(
//                             margin: const EdgeInsets.only(top: 20.0),
//                             child: DModalCityButton(
//                               controller: c1,
//                               isError: (userCity == ' ')
//                                   ? false
//                                   : (state is RegAddressError &&
//                                           state.city.isEmpty)
//                                       ? true
//                                       : false,
//                             ),
//                           ),
//                           Container(
//                             padding: const EdgeInsets.symmetric(vertical: 10.0),
//                             child: DTextField(
//                                 isError: (userStreet == ' ')
//                                     ? false
//                                     : (state is RegAddressError &&
//                                             state.street.isEmpty)
//                                         ? true
//                                         : false,
//                                 label: 'Улица',
//                                 onChanged: (value) {
//                                   userStreet = value;
//                                   BlocProvider.of<RegBloc>(context).add(
//                                       RegAddressConfirm(
//                                           city: userCity,
//                                           street: value,
//                                           building: userBuilding));
//                                 }),
//                           ),
//                           Container(
//                             padding: const EdgeInsets.symmetric(vertical: 10.0),
//                             child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 mainAxisSize: MainAxisSize.max,
//                                 children: [
//                                   Expanded(
//                                     child: DTextField(
//                                       isError: (userBuilding == ' ')
//                                           ? false
//                                           : (state is RegAddressError &&
//                                                   state.building.isEmpty)
//                                               ? true
//                                               : false,
//                                       label: 'Дом',
//                                       keyboardType: TextInputType.number,
//                                       onChanged: (value) {
//                                         userBuilding = value;
//                                         BlocProvider.of<RegBloc>(context).add(
//                                             RegAddressConfirm(
//                                                 city: userCity,
//                                                 street: userStreet,
//                                                 building: value));
//                                       },
//                                     ),
//                                   ),
//                                   const Padding(
//                                       padding:
//                                           EdgeInsets.symmetric(horizontal: 5)),
//                                   Expanded(
//                                     child: DTextField(
//                                       label: 'Корп.',
//                                       keyboardType: TextInputType.number,
//                                       onChanged: (value) {
//                                         userBuildingAdd = value;
//                                       },
//                                     ),
//                                   ),
//                                   const Padding(
//                                       padding:
//                                           EdgeInsets.symmetric(horizontal: 5)),
//                                   Expanded(
//                                     child: DTextField(
//                                       label: 'Кв.',
//                                       keyboardType: TextInputType.number,
//                                       onChanged: (value) {
//                                         userApartment = value;
//                                       },
//                                     ),
//                                   ),
//                                 ]),
//                           )
//                         ],
//                       );
//                     })))));

  }
}
