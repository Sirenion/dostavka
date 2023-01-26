import 'package:dostavka/blocs/sending_modal/sending_modal_bloc.dart';
import 'package:dostavka/widgets/bottom_nav.dart';
import 'package:dostavka/widgets/navbar.dart';
import 'package:dostavka/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Other extends StatelessWidget {
  const Other({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const Other());
  }

  @override
  Widget build(BuildContext context) {
    String text = ' ';
    return BlocProvider(
        create: (_) => SendingModalBloc(),
        child: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: BlocBuilder<SendingModalBloc, SendingModalState>(
                builder: (context, state) {
                  VoidCallback? callback = (state is SendingModalOtherSuccess)
                      ? () {
                    Navigator.of(context).pop();
                  } : null;
                  return Scaffold(
                      appBar: const Navbar(
                        title: 'Другое',
                        buttonLeft: 0,
                      ),
                      bottomNavigationBar: BottomNavSoloButton(
                        label: 'Отправить',
                        onPressed: callback,
                      ),
                      body: Container(
                        margin: const EdgeInsets.all(20.0),
                        width: double.infinity,
                        child: DTextArea(
                            isError: (text == ' ')
                                ? false
                                : (state is SendingModalOtherError &&
                                state.text.isEmpty)
                                ? true : false,
                            label: 'Опишите проблему...',
                            onChanged: (value) {
                              text = value;
                              BlocProvider.of<SendingModalBloc>(context)
                                  .add(SendingModalOtherConfirm(
                                  text: value)
                              );
                            }
                        ),
                      )
                  );
                }
            )
        )
    );
  }
}