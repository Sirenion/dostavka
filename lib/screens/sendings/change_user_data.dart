import 'package:dostavka/blocs/sending_modal/sending_modal_bloc.dart';
import 'package:dostavka/widgets/modals.dart';
import 'package:dostavka/widgets/text_field.dart';
import 'package:dostavka/widgets/bottom_nav.dart';
import 'package:dostavka/widgets/navbar.dart';
import 'package:dostavka/widgets/text_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangeUserData extends StatelessWidget {
  const ChangeUserData({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const ChangeUserData());
  }

  bool check(String s) {
    RegExp exp = RegExp(r'(^[А-Яа-я]+$)');
    return exp.hasMatch(s);
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController c1 = TextEditingController();
    String surname = 'ξ';
    String name = 'ξ';
    String faName = 'ξ';
    String city = 'ξ';
    String street = 'ξ';
    String building = 'ξ';
    String buildingAdd = '';
    String apartment = '';
    return BlocProvider(
        create: (_) => SendingModalBloc(),
        child: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: BlocBuilder<SendingModalBloc, SendingModalState>(
                builder: (context, state) {
                  VoidCallback? callback = (state is SendingModalChangeInfoSuccess)
                      ? () {
                    Navigator.of(context).pop();
                  } : null;
                  c1.addListener(() {
                    city = c1.text;
                    BlocProvider.of<SendingModalBloc>(context).add(
                        SendingModalChangeInfoConfirm(
                            surname: surname,
                            name: name,
                            faName: faName,
                            city: city,
                            street: street,
                            building: building)
                    );
                  });
                  return Scaffold(
                      appBar: const Navbar(
                        title: 'Изменить данные получателя',
                        buttonLeft: 0,
                      ),
                      bottomNavigationBar: BottomNavSoloButton(
                        label: 'Сохранить',
                        onPressed: callback,
                      ),
                      body: SizedBox(
                          width: double.infinity,
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 20.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .stretch,
                                    children: [
                                      const TextView(
                                        text: 'Личные данные',
                                        fw: FontWeight.w800,
                                        fs: 20.0,
                                      ),
                                      Padding(
                                          padding: const EdgeInsets.only(
                                              top: 20.0),
                                          child: DTextField(
                                              isError: (surname == 'ξ')
                                                  ? false
                                                  : (state is SendingModalChangeInfoError)
                                                  ? ((check(surname)) ? false : true) : false,
                                              label: 'Фамилия',
                                              maxLength: 30,
                                              onChanged: (value) {
                                                surname = value;
                                                BlocProvider.of<
                                                    SendingModalBloc>(
                                                    context).add(
                                                    SendingModalChangeInfoConfirm(
                                                        surname: surname,
                                                        name: name,
                                                        faName: faName,
                                                        city: city,
                                                        street: street,
                                                        building: building)
                                                );
                                              }
                                          )
                                      ),
                                      Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10.0),
                                          child: DTextField(
                                              isError: (name == 'ξ')
                                                  ? false
                                                  : (state is SendingModalChangeInfoError)
                                                  ? ((check(name)) ? false : true) : false,
                                              label: 'Имя',
                                              maxLength: 30,
                                              onChanged: (value) {
                                                name = value;
                                                BlocProvider.of<
                                                    SendingModalBloc>(
                                                    context).add(
                                                    SendingModalChangeInfoConfirm(
                                                        surname: surname,
                                                        name: name,
                                                        faName: faName,
                                                        city: city,
                                                        street: street,
                                                        building: building)
                                                );
                                              }
                                          )
                                      ),
                                      DTextField(
                                          isError: (faName == 'ξ')
                                              ? false
                                              : (state is SendingModalChangeInfoError)
                                              ? ((check(faName)) ? false : true) : false,
                                          label: 'Отчество',
                                          maxLength: 30,
                                          onChanged: (value) {
                                            faName = value;
                                            BlocProvider.of<SendingModalBloc>(
                                                context).add(
                                                SendingModalChangeInfoConfirm(
                                                    surname: surname,
                                                    name: name,
                                                    faName: faName,
                                                    city: city,
                                                    street: street,
                                                    building: building)
                                            );
                                          }
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 20.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .stretch,
                                    children: [
                                      const TextView(
                                        text: 'Адрес',
                                        fw: FontWeight.w800,
                                        fs: 20.0,
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(
                                            top: 20.0),
                                        child: DModalCityButton(
                                          controller: c1,
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 10.0),
                                        child: DTextField(
                                            isError: (street == 'ξ')
                                                ? false
                                                : (state is SendingModalChangeInfoError &&
                                                state.street.isEmpty)
                                                ? true : false,
                                            label: 'Улица',
                                            maxLength: 40,
                                            onChanged: (value) {
                                              street = value;
                                              BlocProvider.of<SendingModalBloc>(
                                                  context).add(
                                                  SendingModalChangeInfoConfirm(
                                                      surname: surname,
                                                      name: name,
                                                      faName: faName,
                                                      city: city,
                                                      street: street,
                                                      building: building)
                                              );
                                            }
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceBetween,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Expanded(
                                            child: DTextField(
                                                isError: (building == 'ξ')
                                                    ? false
                                                    : (state is SendingModalChangeInfoError &&
                                                    state.building.isEmpty)
                                                    ? true : false,
                                                label: 'Дом',
                                                maxLength: 5,
                                                typeFormat: 2,
                                                keyboardType: TextInputType
                                                    .number,
                                                onChanged: (value) {
                                                  building = value;
                                                  BlocProvider.of<
                                                      SendingModalBloc>(
                                                      context).add(
                                                      SendingModalChangeInfoConfirm(
                                                          surname: surname,
                                                          name: name,
                                                          faName: faName,
                                                          city: city,
                                                          street: street,
                                                          building: building)
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
                                              keyboardType: TextInputType.text,
                                              onChanged: (value) {
                                                buildingAdd = value;
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
                                              keyboardType: TextInputType
                                                  .number,
                                              onChanged: (value) {
                                                apartment = value;
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                      )
                  );
                }
            )
        )
    );
  }
}
