import 'package:dostavka/blocs/sending_modal/sending_modal_bloc.dart';
import 'package:dostavka/widgets/bottom_nav.dart';
import 'package:dostavka/widgets/navbar.dart';
import 'package:dostavka/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Pretension extends StatelessWidget {
  const Pretension({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const Pretension());
  }

  @override
  Widget build(BuildContext context) {
    var entries = [
      "Food",
      "Transport",
      "Personal",
      "Shopping",
      "Medical",
      "Rent",
      "Movie",
      "Salary"
    ];
    String type = ' ';
    String text = ' ';
    return BlocProvider(
        create: (_) => SendingModalBloc(),
        child: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: BlocBuilder<SendingModalBloc, SendingModalState>(
                builder: (context, state) {
                  VoidCallback? callback = (state is SendingModalPretensionSuccess)
                      ? () {
                    Navigator.of(context).pop();
                  } : null;
                  return Scaffold(
                    appBar: const Navbar(
                      title: 'Претензия по отправлению',
                      buttonLeft: 0,
                    ),
                    bottomNavigationBar: BottomNavSoloButton(
                      label: 'Отправить',
                      onPressed: callback,
                    ),
                    body: Container(
                      margin: const EdgeInsets.all(20.0),
                      width: double.infinity,
                      height: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          DTextFieldDropdown(
                            label: 'Тип претензии',
                            entries: entries,
                            controller: (value) {
                              type = value;
                              BlocProvider.of<SendingModalBloc>(context)
                                  .add(
                                  SendingModalPretensionConfirm(
                                      type: value,
                                      text: text)
                              );
                            },
                          ),
                          const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 7.5)
                          ),
                          Expanded(
                            child: DTextArea(
                                isError: (text == ' ')
                                    ? false
                                    : (state is SendingModalPretensionError &&
                                    state.text.isEmpty)
                                    ? true : false,
                                label: 'Комментарий...',
                                onChanged: (value) {
                                  text = value;
                                  BlocProvider.of<SendingModalBloc>(context)
                                      .add(
                                      SendingModalPretensionConfirm(
                                          type: type,
                                          text: value)
                                  );
                                }
                            ),
                          ),
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