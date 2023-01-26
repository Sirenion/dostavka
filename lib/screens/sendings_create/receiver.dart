import 'package:dostavka/blocs/create_sending/create_sending_bloc.dart';
import 'package:dostavka/connectors/api.dart';
import 'package:dostavka/models/hive_connection/getters.dart';
import 'package:dostavka/models/hive_connection/rep_data.dart';
import 'package:dostavka/models/hive_connection/update.dart';
import 'package:dostavka/screens/sendings_create/receiver_code.dart';
import 'package:dostavka/widgets/bottom_nav.dart';
import 'package:dostavka/widgets/navbar.dart';
import 'package:dostavka/widgets/text_field.dart';
import 'package:dostavka/widgets/text_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReceiverData extends StatelessWidget {
  const ReceiverData({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(builder: (_) => const ReceiverData());
  }

  @override
  Widget build(BuildContext context) {
    VoidCallback? callback;
    String receiverPhone = '';
    bool b = true;

    var response = Api.create();

    return BlocProvider<CreateSendingBloc>(
        create: (_) => CreateSendingBloc(),
        child: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: BlocBuilder<CreateSendingBloc, CreateSendingState>(
                builder: (context, state) {
                  if (state is CreateSendingReceiverPhoneSuccess) {
                    b = state.isRegistered;
                    callback = () async {
                      Getters.getUser().add(User());
                      var response = Api.create();
                      print('HOLA');
                      var phone = receiverPhone.replaceAll(' ', '');
                      phone = phone.replaceAll('-', '');
                      var body = {"username": phone};
                      print(phone);
                      final result = await response.SendSMS(body);
                      final data = new Map<String, dynamic>.from(result.body);
                      print(data['sms_is_sent']);
                      if (data['sms_is_sent'] == true){
                        var userReceiver = Getters.getUser().values.last;
                        Update.EditUser(userReceiver, username: receiverPhone);
                        Navigator.of(context).push(ReceiverCode.route(b));
                      }
                    };
                  } else {
                    b = true;
                    callback = null;
                  }
                  return Scaffold(
                      appBar: const Navbar(title: 'Получатель', buttonLeft: 0),
                      bottomNavigationBar: BottomNavWithSteps(
                        label: 'Отправить уведомление',
                        step: 2,
                        onPressed: callback,
                      ),
                      body: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: DTextField(
                                  label: 'Телефон получателя',
                                  keyboardType: TextInputType.phone,
                                  typeFormat: 1,
                                  onChanged: (value) {
                                    receiverPhone = value;
                                    receiverPhone = receiverPhone.replaceAll(" ", "");
                                    receiverPhone = receiverPhone.replaceAll("-", "");
                                    if (receiverPhone.length == 12) {
                                      var user = Getters.getUser().values.first;
                                      response.getUser("csrftoken=${user.csrftoken}; sessionid=${user.sessionid}", receiverPhone).then((inf) {
                                        if (inf.body != null){
                                          final userdata1 = Map<String, dynamic>.from(inf.body);
                                          BlocProvider.of<CreateSendingBloc>(context).add(
                                              CreateSendingReceiverPhoneConfirm(phone: value, isRegistered: true));
                                        } else {
                                          BlocProvider.of<CreateSendingBloc>(context).add(
                                              CreateSendingReceiverPhoneConfirm(phone: value, isRegistered: false));
                                        }
                                      });
                                    } else {
                                      BlocProvider.of<CreateSendingBloc>(context).add(
                                          CreateSendingReceiverPhoneConfirm(phone: value));
                                    }
                                  },
                                ),
                              ),
                              if (!b) ...[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    TextView(
                                      text: 'Внимание!',
                                      fs: 17,
                                      fw: FontWeight.w600,
                                      color: Color(0xFFF0674C),
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(bottom: 10)),
                                    TextView(
                                      text: 'Пользователя с таким номером ещё нет в системе. Пользователю будет отправлено смс-сообщение с подтверждением, после чего необходимо будет заполнить данные пользователя.',
                                    ),
                                  ],
                                )
                              ],
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
