import 'dart:convert';

import 'package:dostavka/blocs/registration/reg_bloc.dart';
import 'package:dostavka/screens/pin/create_pin_page.dart';
import 'package:dostavka/models/hive_connection/getters.dart';
import 'package:dostavka/models/hive_connection/update.dart';
import 'package:dostavka/widgets/buttons.dart';
import 'package:dostavka/widgets/modals.dart';
import 'package:dostavka/widgets/text_field.dart';
import 'package:dostavka/widgets/text_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/profile/profile_bloc.dart';
import '../../../connectors/api.dart';
import '../../../connectors/suggest.dart';

class PersonalData2 extends StatelessWidget {
  const PersonalData2({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const PersonalData2());
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    TextEditingController controller2 = TextEditingController();
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
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                leadingWidth: 74.0,
                leading: const Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: DNavButton(
                    itemCode: 0,
                  ),
                ),
              ),
              body: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        BlocBuilder<RegBloc, RegState>(
                            builder: (context, state) {
                              controller.addListener(() {
                                userCity = controller.text;
                                BlocProvider.of<RegBloc>(context).add(
                                    RegAddressConfirm(
                                        city: controller.text,
                                        street: userStreet,
                                        building: userBuilding));
                              });
                              controller2.addListener(() {

                                userStreet = controller2.text.toString();
                                var Str;
                                if (userStreet != ""){
                                  var newStreet = userStreet.split(",");
                                  Str = newStreet[1];
                                }
                                BlocProvider.of<ProfileBloc>(context).add(
                                    ProfileAddressConfirm(
                                        city: userCity,
                                        street: userStreet,
                                        building: userBuilding));
                              });
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const TextView(
                                      text: 'Адрес',
                                      fs: 30.0,
                                      fw: FontWeight.w800),
                                  const Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        0, 15.0, 0, 15.0),
                                    child: TextView(
                                      text: 'Шаг 2 из 2',
                                      fs: 25.0,
                                      fw: FontWeight.w600,
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 10),
                                    child: DModalCityButton(
                                      controller: controller,
                                      isError: (userCity == ' ')
                                          ? false
                                          : (state is RegAddressError &&
                                          state.city.isEmpty)
                                          ? true
                                          : false,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
                                    child: DModalStreetButton(controller: controller2, city: userCity == 'ξ' ? '' : userCity, isError: (userStreet == 'ξ')
                                        ? false
                                        : (state is RegAddressError &&
                                        state.street.isEmpty)
                                        ? true
                                        : false,),
                                  ),
                                  // Container(
                                  //   margin: const EdgeInsets.only(bottom: 10),
                                  //   child: DTextField(
                                  //     isError: (userStreet == ' ')
                                  //         ? false
                                  //         : (state is RegAddressError &&
                                  //         state.street.isEmpty)
                                  //         ? true
                                  //         : false,
                                  //     label: 'Улица',
                                  //     onChanged: (value) {
                                  //       userStreet = value;
                                  //       BlocProvider.of<RegBloc>(context).add(
                                  //           RegAddressConfirm(
                                  //               city: userCity,
                                  //               street: value,
                                  //               building: userBuilding));
                                  //     },
                                  //   ),
                                  // ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(
                                        child: DTextField(
                                          isError: (userBuilding == ' ')
                                              ? false
                                              : (state is RegAddressError &&
                                              state.building.isEmpty)
                                              ? true
                                              : false,
                                          label: 'Дом',
                                          keyboardType: TextInputType.number,
                                          onChanged: (value) {
                                            userBuilding = value;
                                            BlocProvider.of<RegBloc>(context)
                                                .add(
                                                RegAddressConfirm(
                                                    city: userCity,
                                                    street: userStreet,
                                                    building: value));
                                          },
                                        ),
                                      ),
                                      const Padding(
                                          padding:
                                          EdgeInsets.symmetric(horizontal: 5)),
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
                                              horizontal: 5)
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
                            })
                      ])
              ),
              persistentFooterButtons: [
                Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    child: BlocBuilder<RegBloc, RegState>(
                        builder: (context, state) {
                          VoidCallback? callback = (state is RegAddressSuccess)
                              ? () async{
                            var user = Getters
                                .getUser()
                                .values
                                .first;
                            var newStr = userStreet.split(",");
                            var Str = newStr[1];
                            Update.EditUser(user,
                                address: 'г. ' +
                                    userCity +
                                    ', ул. ' +
                                    Str +
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
                                Navigator.of(context).push(CreatePIN.route());
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
                                Navigator.of(context).push(CreatePIN.route());
                              }
                            }

                          }
                              : null;
                          return CupertinoButtonPrimary(
                            textLabel: 'Сохранить',
                            proceed: true,
                            callback: callback,
                          );
                        })
                )
              ],
            )
        )
    );
  }
}

// {
// "query": "Пет",
// "from_bound": { "value": "city" },
// "to_bound": { "value": "city" }
// }



