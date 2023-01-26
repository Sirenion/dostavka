import 'package:dostavka/blocs/bottom_nav/bottom_nav_bloc.dart';
import 'package:dostavka/blocs/bottom_nav/bottom_nav_events.dart';
import 'package:dostavka/blocs/bottom_nav/bottom_nav_states.dart';
import 'package:dostavka/blocs/create_sending/create_sending_bloc.dart';
import 'package:dostavka/custom_icons.dart';
import 'package:dostavka/screens/sendings_create/general_information.dart';
import 'package:dostavka/widgets/buttons.dart';
import 'package:dostavka/widgets/steps.dart';
import 'package:dostavka/widgets/text_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class BottomNav extends StatelessWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavBloc, BottomNavState>(
        builder: (context, state) {
          return Container(
            height: 75,
            decoration: const BoxDecoration(
              color: CupertinoColors.white,
              boxShadow: [
                BoxShadow(
                  color: Color(0xFFE2E5EA),
                  spreadRadius: 2,
                  blurRadius: 2,
                  offset: Offset(0, 1), // changes position of shadow
                ),
              ],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    onPressed: () {
                      BlocProvider.of<BottomNavBloc>(context).getItem(
                          BottomNavEvents.sending);
                    },
                    enableFeedback: false,
                    icon: Icon(
                      CustomIcons.board,
                      color: state.page == BottomNavEvents.sending
                          ? const Color(0xFFF0674C) : const Color(0xFF364662),
                      size: 30,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      BlocProvider.of<BottomNavBloc>(context).getItem(
                          BottomNavEvents.history);
                    },
                    enableFeedback: false,
                    icon: Icon(
                      CustomIcons.clock,
                      color: state.page == BottomNavEvents.history
                          ? const Color(0xFFF0674C) : const Color(0xFF364662),
                      size: 30,
                    ),
                  ),
                  CupertinoButton(
                    onPressed: () {
                      Navigator.of(context).push(GeneralInformation.route());
                    },
                    color: const Color(0xFFF0674C),
                    padding: const EdgeInsets.all(20.0),
                    child: const Icon(
                      CustomIcons.plus,
                      color: Colors.white,
                      size: 17,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      BlocProvider.of<BottomNavBloc>(context).getItem(
                          BottomNavEvents.map);
                    },
                    enableFeedback: false,
                    icon: Icon(
                      CustomIcons.mapPin,
                      color: state.page == BottomNavEvents.map
                          ? const Color(0xFFF0674C) : const Color(0xFF364662),
                      size: 30,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      BlocProvider.of<BottomNavBloc>(context).getItem(
                          BottomNavEvents.profile);
                    },
                    enableFeedback: false,
                    icon: Icon(
                      CustomIcons.user,
                      color: state.page == BottomNavEvents.profile
                          ? const Color(0xFFF0674C) : const Color(0xFF364662),
                      size: 30,
                    ),
                  ),
                ]
            ),
          );
        }
    );
  }
}

class BottomNavSoloButton extends StatelessWidget {
  const BottomNavSoloButton({Key? key,
    required this.label,
    this.onPressed,
  }) : super(key: key);

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 102,
      padding: const EdgeInsets.all(20.0),
      decoration: const BoxDecoration(
        color: CupertinoColors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0xFFE2E5EA),
            spreadRadius: 2,
            blurRadius: 2,
            offset: Offset(0, 1), // changes position of shadow
          ),
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: CupertinoButtonPrimary(
        proceed: true,
        callback: onPressed,
        textLabel: label,
      ),
    );
  }
}


class BottomNavWithSteps extends StatelessWidget {
  const BottomNavWithSteps({Key? key,
    required this.label,
    required this.step,
    this.isCheckBox = false,
    this.ch1 = false,
    this.ch2 = false,
    this.labelSecond = '',
    this.onPressed,
    this.onPressedSecond,
  }) : super(key: key);

  final bool isCheckBox, ch1, ch2;
  final int step;
  final String label, labelSecond;
  final VoidCallback? onPressed, onPressedSecond;

  @override
  Widget build(BuildContext context) {
    int v1 = 0,
        v2 = 0,
        v3 = 0;
    switch (step) {
      case 0:
        {
          v1 = 2;
          break;
        }
      case 1:
        {
          v1 = 1;
          v2 = 2;
          break;
        }
      case 2:
        {
          v1 = 1;
          v2 = 1;
          v3 = 2;
          break;
        }
      default:
        break;
    }
    return Container(
        height: isCheckBox ? 246 : (labelSecond != '' ? 209 : 145),
        padding: const EdgeInsets.all(20.0),
        decoration: const BoxDecoration(
          color: CupertinoColors.white,
          boxShadow: [
            BoxShadow(
              color: Color(0xFFE2E5EA),
              spreadRadius: 2,
              blurRadius: 2,
              offset: Offset(0, 1), // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            if(isCheckBox) ...[
              Container(
                padding: const EdgeInsets.only(bottom: 10),
                child: Column(
                  children: [
                    DCheckBox(text: 'Доставка до двери',
                        value: ch1,
                        callback: () {
                          BlocProvider.of<CreateSendingBloc>(context).add(
                              CreateSendingDeliveryCheckDoorConfirm(
                                  toDoor: !ch1));
                        }),
                    DCheckBox(text: 'Оплата при получении (+5%)',
                      value: ch2,
                      callback: () {
                        BlocProvider.of<CreateSendingBloc>(context).add(
                            CreateSendingDeliveryCheckPaymentConfirm(
                                payment: !ch2));
                      },
                    ),
                  ],
                ),
              )
            ],
            if(labelSecond != '') ...[
              Container(
                padding: const EdgeInsets.only(bottom: 10),
                width: double.infinity,
                child: CupertinoButtonPrimary(
                  proceed: false,
                  callback: onPressedSecond,
                  textLabel: labelSecond,
                ),
              ),
            ],
            SizedBox(
              child: CupertinoButtonPrimary(
                proceed: true,
                callback: onPressed,
                textLabel: label,
              ),
              width: double.infinity,
            ),
            Container(
                padding: const EdgeInsets.only(top: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 1,
                      child: DStep(state: v1, value: 1),
                    ),
                    Expanded(
                      flex: 1,
                      child: DStep(state: v2, value: 2),
                    ),
                    Expanded(
                      flex: 1,
                      child: DStep(state: v3, value: 3),
                    ),
                  ],
                )
            )
          ],
        )
    );
  }
}

class DCheckBox extends StatelessWidget {
  const DCheckBox({
    Key? key,
    required this.text,
    required this.value,
    required this.callback,
  }) : super(key: key);

  final String text;
  final bool value;
  final VoidCallback? callback;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      child: Row(
        children: [
          Transform.scale(
            scale: 1.3,
            child: Checkbox(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.0),
                ),
                activeColor: const Color(0xffF0674C),
                value: value,
                onChanged: (bool? newValue) {
                  callback!();
                }
            ),
          ),
          TextView(text: text,
            fw: FontWeight.w600,)
        ],
      ),
    );
  }
}