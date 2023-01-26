import 'package:dostavka/blocs/create_sending/create_sending_bloc.dart';
import 'package:dostavka/widgets/bottom_nav.dart';
import 'package:dostavka/widgets/navbar.dart';
import 'package:dostavka/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dostavka/models/hive_connection/getters.dart';

import '../../connectors/api.dart';

class BoxSize extends StatelessWidget {
  const BoxSize({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(builder: (_) => const BoxSize());
  }

  @override
  Widget build(BuildContext context) {
    String length = 'ξ';
    String width = 'ξ';
    String height = 'ξ';
    String weight = 'ξ';
    return BlocProvider<CreateSendingBloc>(
        create: (_) => CreateSendingBloc(),
        child: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: BlocBuilder<CreateSendingBloc, CreateSendingState>(
                builder: (context, state) {
                  VoidCallback? callback = (state is CreateSendingParamsSuccess)
                      ? (){
                    Navigator.pop(context,
                        '${length}x${width}x$heightсм Вес: $weightкг');
                  } : null;
                  return Scaffold(
                      appBar: const Navbar(title: 'Габариты', buttonLeft: 0),
                      bottomNavigationBar: BottomNavWithSteps(
                        label: 'Подтвердить',
                        step: 0,
                        onPressed: callback,
                      ),
                      body: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
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
                                          isError: (length == 'ξ') ? false
                                              : (state is CreateSendingParamsError &&
                                              state.cargoLength.isEmpty)
                                              ? true : false,
                                          keyboardType: const TextInputType
                                              .numberWithOptions(decimal: true),
                                          label: 'Длина, см',
                                          maxLength: 5,
                                          typeFormat: 3,
                                          onChanged: (value) {
                                            length = value;
                                            BlocProvider.of<CreateSendingBloc>(
                                                context).add(
                                                CreateSendingParamsConfirm(
                                                    cargoLength: value,
                                                    cargoWidth: width,
                                                    cargoHeight: height,
                                                    cargoWeight: weight)
                                            );
                                          },
                                        ),
                                      ),
                                      const Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 5)),
                                      Expanded(
                                        child: DTextField(
                                          isError: (width == 'ξ') ? false
                                              : (state is CreateSendingParamsError &&
                                              state.cargoWidth.isEmpty)
                                              ? true : false,
                                          keyboardType: const TextInputType
                                              .numberWithOptions(decimal: true),
                                          label: 'Ширина, см',
                                          maxLength: 5,
                                          typeFormat: 3,
                                          onChanged: (value) {
                                            width = value;
                                            BlocProvider.of<CreateSendingBloc>(
                                                context).add(
                                                CreateSendingParamsConfirm(
                                                    cargoLength: length,
                                                    cargoWidth: value,
                                                    cargoHeight: height,
                                                    cargoWeight: weight)
                                            );
                                          },
                                        ),
                                      ),
                                    ]),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10.0),
                                child: DTextField(
                                  isError: (height == 'ξ') ? false
                                      : (state is CreateSendingParamsError &&
                                      state.cargoHeight.isEmpty)
                                      ? true : false,
                                  keyboardType: const TextInputType
                                      .numberWithOptions(
                                      decimal: true),
                                  label: 'Высота, см',
                                  maxLength: 5,
                                  typeFormat: 3,
                                  onChanged: (value) {
                                    height = value;
                                    BlocProvider.of<CreateSendingBloc>(
                                        context).add(
                                        CreateSendingParamsConfirm(
                                            cargoLength: length,
                                            cargoWidth: width,
                                            cargoHeight: value,
                                            cargoWeight: weight)
                                    );
                                  },
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10.0),
                                child: DTextField(
                                  isError: (weight == 'ξ') ? false
                                      : (state is CreateSendingParamsError &&
                                      state.cargoWeight.isEmpty)
                                      ? true : false,
                                  keyboardType: const TextInputType
                                      .numberWithOptions(
                                      decimal: true),
                                  label: 'Вес, кг',
                                  maxLength: 5,
                                  typeFormat: 3,
                                  onChanged: (value) {
                                    weight = value;
                                    BlocProvider.of<CreateSendingBloc>(
                                        context).add(
                                        CreateSendingParamsConfirm(
                                            cargoLength: length,
                                            cargoWidth: width,
                                            cargoHeight: height,
                                            cargoWeight: value)
                                    );
                                  },
                                ),
                              )
                            ],
                          )
                      )
                  );
                }
            )
        )
    );
  }
}
