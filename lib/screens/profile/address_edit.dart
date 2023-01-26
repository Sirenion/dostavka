import 'dart:convert';

import 'package:dostavka/blocs/profile/profile_bloc.dart';
import 'package:dostavka/main.dart';
import 'package:dostavka/widgets/bottom_nav.dart';
import 'package:dostavka/widgets/modals.dart';
import 'package:dostavka/widgets/navbar.dart';
import 'package:dostavka/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dostavka/models/hive_connection/getters.dart';
import 'package:dostavka/models/hive_connection/update.dart';

import '../../connectors/api.dart';
import '../../connectors/suggest.dart';

class AddressEdit extends StatelessWidget {
  const AddressEdit({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(builder: (_) => const AddressEdit());
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
    var user = Getters.getUser().values.first;
    return BlocProvider<ProfileBloc>(
      create: (_) => ProfileBloc(),
      child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Scaffold(
            appBar: const Navbar(title: 'Редактирование', buttonLeft: 0),
            bottomNavigationBar: BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state) {
                  controller.addListener(() {
                    userCity = controller.text.toString();

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
              VoidCallback? callback = (state is ProfileAddressSuccess)
                  ? () async{
                print("USER STREET ${userStreet}")
                var newStr = userStreet.split(",");
                var Str = newStr[1];
                Update.EditUser(user,
                    address: 'г. ' +
                        userCity +
                        ', ' +
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
                    Navigator.of(context).pushReplacement(MyApp.route(3));
                  }
                }
                else{
                  var res = await response.setAddress(
                      "csrftoken=${tok}; sessionid=${user.sessionid}", tok,
                      body);
                  if (res.bodyString != null) {
                    print("RESPONSE");
                    print(res.bodyString);
                    Navigator.of(context).pushReplacement(MyApp.route(3));
                  }
                }

              }
                  : null;
              return BottomNavSoloButton(
                label: 'Сохранить изменения',
                onPressed: callback,
              );
            }),
            body: Container(
              padding: const EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 0.0),
              child: SingleChildScrollView(
                  child: BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      DModalCityButton(
                        controller: controller,
                        isError: (userCity == 'ξ')
                            ? false
                            : (state is ProfileAddressError &&
                                    state.city.isEmpty)
                                ? true
                                : false,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
                        child: DModalStreetButton(controller: controller2, city: userCity == 'ξ' ? '' : userCity, isError: (userStreet == 'ξ')
                            ? false
                            : (state is ProfileAddressError &&
                            state.street.isEmpty)
                            ? true
                            : false,),
                      ),
                      // Container(
                      //   margin: const EdgeInsets.symmetric(vertical: 10.0),
                      //   child: DTextField(
                      //     isError: (userStreet == 'ξ')
                      //         ? false
                      //         : (state is ProfileAddressError &&
                      //                 state.street.isEmpty)
                      //             ? true
                      //             : false,
                      //     label: 'Улица',
                      //     maxLength: 40,
                      //     onChanged: (value) {
                      //       userStreet = value;
                      //       BlocProvider.of<ProfileBloc>(context).add(
                      //           ProfileAddressConfirm(
                      //               city: userCity,
                      //               street: value,
                      //               building: userBuilding));
                      //     },
                      //  ),
                      //),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: DTextField(
                              isError: (userBuilding == 'ξ')
                                  ? false
                                  : (state is ProfileAddressError &&
                                          state.building.isEmpty)
                                      ? true
                                      : false,
                              label: 'Дом',
                              maxLength: 5,
                              typeFormat: 2,
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                userBuilding = value;
                                BlocProvider.of<ProfileBloc>(context).add(
                                    ProfileAddressConfirm(
                                        city: userCity,
                                        street: userStreet,
                                        building: value));
                              },
                            ),
                          ),
                          const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5.0)),
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
                              padding: EdgeInsets.symmetric(horizontal: 5)),
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
                },
              )),
            ),
          )),
    );
  }
}
