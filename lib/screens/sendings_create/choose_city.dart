import 'package:dostavka/blocs/create_sending/create_sending_bloc.dart';
import 'package:dostavka/models/hive_connection/getters.dart';
import 'package:dostavka/models/hive_connection/update.dart';
import 'package:dostavka/screens/sendings_create/sendings_options.dart';
import 'package:dostavka/widgets/bottom_nav.dart';
import 'package:dostavka/widgets/modals.dart';
import 'package:dostavka/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ChooseCity extends StatelessWidget {
  const ChooseCity({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(builder: (_) => const ChooseCity());
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController c1 = TextEditingController();
    TextEditingController c2 = TextEditingController();
    var draft = Getters.getDraft().values.first;
    return BlocProvider<CreateSendingBloc>(
        create: (_) => CreateSendingBloc(),
        child: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: BlocBuilder<CreateSendingBloc, CreateSendingState>(
                builder: (context, state) {
                  c1.addListener(() {
                    BlocProvider.of<CreateSendingBloc>(context).add(
                        CreateSendingRouteConfirm(
                            from: c1.text, to: c2.text
                        )
                    );
                  });
                  c2.addListener(() {
                    BlocProvider.of<CreateSendingBloc>(context).add(
                        CreateSendingRouteConfirm(
                            from: c1.text, to: c2.text
                        )
                    );
                  });
                  VoidCallback? callback = (state is CreateSendingRouteSuccess)
                      ? () {
                    ///добавить привязку карго (в эдитдрафте ее нет)
                    print('========== user_from: ${c1.text}, user_to: ${c2.text}, date_create: ${DateFormat('d.M.y H:m').format(DateTime.now())}')
                    Update.editDraft(draft, user_from: c1.text, user_to: c2.text, date_create: DateFormat('d.M.y H:m').format(DateTime.now()));
                    print(Getters.getDraft().values.first.toString());
                    Navigator.of(context).push(SendingOptions.route());
                  } : null;
                  return Scaffold(
                      appBar: const Navbar(
                          title: 'Выбор маршрута', buttonLeft: 0),
                      bottomNavigationBar: BottomNavWithSteps(
                        label: 'Далее',
                        step: 1,
                        onPressed: callback,
                      ),
                      body: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(top: 20.0),
                                child: DModalCityButton(
                                  controller: c1,
                                  label: 'Город отправления',
                                  order: 1,
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 20.0),
                                child: DModalCityButton(
                                  controller: c2,
                                  label: 'Город назначения',
                                  order: 2,
                                ),
                              ),
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
