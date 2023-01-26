import 'package:dostavka/widgets/text_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DSwitch extends StatelessWidget {
  const DSwitch(
      {Key? key,
      required this.value,
      required this.text,
      required this.onChanged})
      : super(key: key);

  final bool value;
  final String text;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(!value);
      },
      child: SizedBox(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextView(
              text: text,
              fw: FontWeight.w600,
            ),
            SizedBox(
                height: 30.0,
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: CupertinoSwitch(
                    value: value,
                    onChanged: (bool newvalue) {
                      onChanged(newvalue);
                    },
                    activeColor: const Color(0xffF0674C),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
