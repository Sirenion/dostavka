import 'package:dostavka/custom_icons.dart';
import 'package:dostavka/screens/map/google_map_screen_second.dart';
import 'package:dostavka/screens/notifications.dart';
import 'package:dostavka/widgets/modals.dart';
import 'package:dostavka/widgets/text_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class CupertinoButtonPrimary extends StatelessWidget {
  const CupertinoButtonPrimary(
      {Key? key, required this.textLabel, required this.proceed, this.callback})
      : super(key: key);

  final String textLabel;
  final bool proceed;
  final VoidCallback? callback;

  @override
  Widget build(BuildContext context) {
    Color buttonColor =
        proceed ? const Color(0xFFF0674C) : const Color(0xFFF4F4F4);
    Color textColor = proceed ? Colors.white : const Color(0xFFF0674C);
    return CupertinoButton(
      onPressed: callback,
      color: buttonColor,
      disabledColor: proceed ? const Color.fromRGBO(240, 103, 76, 0.3)
          : const Color.fromRGBO(244, 244, 244, 0.3),
      pressedOpacity: 0.4,
      padding: const EdgeInsets.all(17.0),
      borderRadius: const BorderRadius.all(Radius.circular(12.0)),
      child: TextView(
        text: textLabel,
        color: textColor,
        fs: 17,
        fw: FontWeight.w600,
      ),
    );
  }
}

class DTextButton extends StatelessWidget {
  const DTextButton({Key? key,
    required this.text,
    this.onPressed
  }) : super(key: key);

  final String text;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
        onPressed: onPressed,
        color: Colors.transparent,
        minSize: 25.0,
        padding: const EdgeInsets.all(5.0),
        disabledColor: CupertinoColors.quaternarySystemFill,
        pressedOpacity: 0.5,
        child: TextView(
          text: text,
          fs: 15.0,
          fw: FontWeight.w600,
          color: const Color(0xFFF0674C),
        ));
  }
}

class DNavButton extends StatelessWidget {
  const DNavButton({Key? key,
    required this.itemCode,
    this.map = const [],
  }) : super(key: key);

  final int itemCode;
  final List<Map<String, dynamic>>? map;
  @override
  Widget build(BuildContext context) {
    IconData i;
    VoidCallback? action;
    switch (itemCode) {
      case 0:
        {
          action = () {
            Navigator.pop(context);
          };
          i = CustomIcons.arrowBack;
          break;
        }
      case 1:
        {
          action = (){
            //Navigator.of(context).push(Biometric.route());
            showError(context, DateFormat('d.M.y H:m').format(DateTime.now()));
          };
          i = CustomIcons.search;
          break;
        }
      case 2:
        {
          i = CustomIcons.more;
          action = () {
            showModalBottomSheet(
                context: context,
                backgroundColor: Colors.transparent,
                builder: (BuildContext context) {
                  return Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    ),
                    margin: const EdgeInsets.all(20.0),
                    child: Wrap(
                      children: const [
                        DBottomSheetMoreItem(num: 0),
                        DBottomSheetMoreItem(num: 1),
                        DBottomSheetMoreItem(num: 2),
                        DBottomSheetMoreItem(num: 3, border: false),
                      ],
                    ),
                  );
                }
            );
          };
          break;
        }
      case 3:
        {
          i = CustomIcons.notifications;
          action = () {
            Navigator.of(context).push(Notifications.route());
          };
          break;
        }
      case 4:
        {
          i = CustomIcons.mapPin;
          action = () {
            Navigator.of(context).push(GoogleMapScreenSecond.route(map));
          };
          break;
        }
      case 5:
        {
          i = CustomIcons.discount;
          action = () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const DModalDiscount();
                }
            );
          };
          break;
        }
      default:
        i = CustomIcons.arrowBack;
        action = () {
          Navigator.pop(context);
        };
        break;
    }
    return CupertinoButton(
        color: const Color(0xFFF6F7F9),
        padding: const EdgeInsets.all(15.0),
        child: Icon(
          i,
          color: const Color(0xFF2D3A52),
        ),
        onPressed: action,
    );
  }
}

class ButtonOfNumPad extends StatelessWidget {
  const ButtonOfNumPad({Key? key,
    required this.num,
    this.type = 0,
    this.onPressed})
      : super(key: key);

  final String num;
  final int type;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    IconData i;
    switch (type) {
      case 1:
        {
          i = CustomIcons.arrowBack;
          break;
        }
      case 2:
        {
          i = Icons.fingerprint;
          break;
        }
      case 3:
        {
          i = CupertinoIcons.person_crop_square;
          break;
        }
      default:
        i = CustomIcons.arrowBack;
        break;
    }
    return CupertinoButton(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 35.0),
      color: const Color(0xFFF6F7F9),
      onPressed: onPressed,
      child: (type != 0) ? Icon(
        i,
        color: const Color(0xFF2D3A52),
      ) : TextView(
        text: num,
        fs: 20.0,
        fw: FontWeight.w600,
      ),
    );
  }
}
