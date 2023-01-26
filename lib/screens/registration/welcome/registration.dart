import 'package:dostavka/connectors/api.dart';
import 'package:dostavka/main.dart';
import 'package:dostavka/models/hive_connection/getters.dart';
import 'package:dostavka/models/hive_connection/update.dart';
import 'package:dostavka/repositories/temporary_repository.dart';
import 'package:dostavka/screens/registration/code/code.dart';
import 'package:dostavka/widgets/buttons.dart';
import 'package:dostavka/widgets/text_field.dart';
import 'package:dostavka/widgets/text_view.dart';
import 'package:flutter/material.dart';
import 'package:dostavka/blocs/registration/reg_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Registration extends StatelessWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: colorPrimary,
          scaffoldBackgroundColor: const Color(0xFFFFFFFF),
          backgroundColor: const Color(0xFFFFFFFF),
          dividerColor: Colors.transparent,
        ),
        home: BlocProvider<RegBloc>(
          create: (_) => RegBloc(),
          child: const RegHome(),
        )
    );
  }
}

class RegHome extends StatefulWidget {
  const RegHome({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RegistrationState();
}

class _RegistrationState extends State<RegHome> {
  @override
  Widget build(BuildContext context) {

    TextEditingController phoneController = TextEditingController();
    String n = '';
    var user = Getters.getUser().values.first;

    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
            body: Container(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: (MediaQuery
                        .of(context)
                        .viewInsets
                        .bottom != 0) ? MediaQuery
                        .of(context)
                        .size
                        .width * 0 : double.infinity,
                    child: const Padding(
                      padding: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 0),
                      child: Image(
                          image: AssetImage('images/reg_1.png'),
                          fit: BoxFit.contain
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TextView(
                          text: "Добро пожаловать!",
                          fs: 30.0,
                          fw: FontWeight.w800
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 15.0, 0, 29.0),
                        child: TextView(
                          text: 'Введите свой номер телефона,\nчтобы продолжить.',
                          fs: 17.0,
                          fw: FontWeight.w400,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 65),
                        child: DTextField(
                          label: 'Телефон',
                          keyboardType: TextInputType.phone,
                          typeFormat: 1,
                          onChanged: (value) {
                            n = value;

                            Update.EditUser(user, username: n);

                            BlocProvider.of<RegBloc>(context).add(
                                RegPhoneConfirm(phone: value));
                          },
                        ),
                      ),
                      Container(
                          padding: const EdgeInsets.only(top: 20.0),
                          width: double.infinity,
                          child: BlocBuilder<RegBloc, RegState>(
                            builder: (context, state) {
                              VoidCallback? callback = (state is RegPhoneSuccess)
                                  ? () async {
                                var response = Api.create();
                                print('HOLA');
                                var phone = n.replaceAll(' ', '');
                                phone = phone.replaceAll('-', '');
                                var body = {"username": phone};
                                print(phone);
                                final result = await response.SendSMS(body);
                                final data = new Map<String, dynamic>.from(result.body);
                                print(data['sms_is_sent']);
                                if (data['sms_is_sent'] == true){
                                  addItem(n, 'UserPhone');
                                  Navigator.of(context).push(Code.route());
                                }
                              } : null;
                              return CupertinoButtonPrimary(
                                  callback: callback,
                                  textLabel: 'Продолжить',
                                  proceed: true
                              );
                            },
                          )
                      )
                    ],
                  ),
                ],
              ),
            )
        )
    );
  }
}

void addItem(String text, String key) async{
  HiveTemporaryRepository temporaryRepository = HiveTemporaryRepository();
  temporaryRepository.addSolo(text, key);
}
