import 'dart:math';

import 'package:dostavka/blocs/create_sending/create_sending_bloc.dart';
import 'package:dostavka/models/hive_connection/getters.dart';
import 'package:dostavka/models/hive_connection/update.dart';
import 'package:dostavka/screens/sendings_create/choose_city.dart';
import 'package:dostavka/widgets/bottom_nav.dart';
import 'package:dostavka/widgets/modals.dart';
import 'package:dostavka/widgets/navbar.dart';
import 'package:dostavka/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../connectors/api.dart';

class GeneralInformation extends StatelessWidget {
  const GeneralInformation({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(builder: (_) => const GeneralInformation());
  }

  @override
  Widget build(BuildContext context) {
    String cargoName = ' ';
    String cargoParams = ' ';
    String cargoPrice = ' ';

    ///uuid pattern?
    String uuid = '${Random().nextInt(900000) + 100000}';

    var params;

    var cargo = Getters.getCargo();
    TextEditingController controller = TextEditingController();
    return BlocProvider<CreateSendingBloc>(
        create: (_) => CreateSendingBloc(),
        child: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: BlocBuilder<CreateSendingBloc, CreateSendingState>(
                builder: (context, state) {
                  controller.addListener(() {
                    params = controller.text.replaceAll(RegExp(r'x'), ':').replaceAll(RegExp(r'[^0-9,.:]+'), '').split(':');
                    cargoParams = controller.text;
                    BlocProvider.of<CreateSendingBloc>(context).add(
                        CreateSendingGeneralInfoConfirm(
                            cargoName: cargoName,
                            cargoParams: controller.text,
                            cargoPrice: cargoPrice)
                    );
                  });
                  VoidCallback? callback =
                  (state is CreateSendingGeneralInfoSuccess)
                      ? () async {
                    Update.editCargo(cargo.values.first,
                        uuid: uuid,
                        name: cargoName,
                        declared_value: double.parse(cargoPrice),
                        length: double.parse(params[0]),
                        width: double.parse(params[1]),
                        height: double.parse(params[2]),
                        weigh: double.parse(params[3]));

                    // var usr = Getters.getUser().values.first;
                    // var cook = Getters.getCookie().values.first;
                    // var carg = Getters.getCargo().values.first;
                    // var response = Api.create();
                    // var tok = cook.csrftoken.replaceAll("csrftoken=", "");
                    // var phoneInf = usr.username;
                    // phoneInf = phoneInf.replaceAll(" ", "");
                    // phoneInf = phoneInf.replaceAll("-", "");
                    // var body = {
                    //   "need_pack": false,
                    //   "name": carg.name,
                    //   "height": carg.height,
                    //   "width": carg.width,
                    //   "length": carg.length,
                    //   "weigh": carg.weigh,
                    //   "declaired_value": carg.declared_value
                    // }
                    // var data = await response.createCargo("sessionid=${cook.sessionid}; ${cook.csrftoken}", tok, body);
                    // var resp = new Map<String, dynamic>.from(data.body);
                    // print (resp);
                    // Update.editCargo(cargo.values.first,
                    //     uuid: resp["uiid"]);
                    Navigator.of(context).push(ChooseCity.route());
                  } : null;
                  return Scaffold(
                    appBar: const Navbar(
                        title: 'Общая информация',
                        buttonLeft: 0
                    ),
                    bottomNavigationBar: BottomNavWithSteps(
                      label: 'Далее',
                      step: 0,
                      onPressed: callback,
                    ),
                    body: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: DTextField(
                              isError: (cargoName == ' ')
                                  ? false
                                  : (state is CreateSendingGeneralInfoError &&
                                  state.cargoName.isEmpty)
                                  ? true : false,
                              label: 'Название груза',
                              maxLength: 50,
                              keyboardType: TextInputType.name,
                              onChanged: (value) {
                                cargoName = value;
                                BlocProvider.of<CreateSendingBloc>(context).add(
                                    CreateSendingGeneralInfoConfirm(
                                        cargoName: value,
                                        cargoParams: cargoParams,
                                        cargoPrice: cargoPrice
                                    )
                                );
                              },
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: GeneralBottomModalButton(
                              isError: (cargoParams == ' ')
                                  ? false
                                  : (state is CreateSendingGeneralInfoError &&
                                  state.cargoParams.isEmpty)
                                  ? true : false,
                              controller: controller,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: DTextField(
                              isError: (cargoPrice == ' ')
                                  ? false
                                  : (state is CreateSendingGeneralInfoError &&
                                  state.cargoPrice.isEmpty)
                                  ? true : false,
                              label: 'Стоимость, руб',
                              maxLength: 10,
                              typeFormat: 3,
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                cargoPrice = value;
                                BlocProvider.of<CreateSendingBloc>(context).add(
                                    CreateSendingGeneralInfoConfirm(
                                        cargoName: cargoName,
                                        cargoParams: cargoParams,
                                        cargoPrice: value
                                    )
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }
            )
        )
    );
  }
}
