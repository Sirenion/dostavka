import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PhoneField extends StatelessWidget {
  const PhoneField({Key? key,
      this.onCompleted,
  }) : super(key: key);
  final ValueChanged<String>? onCompleted;
  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      appContext: context,
      length: 5,
      obscureText: false,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(12),
        fieldHeight: 60,
        fieldWidth: 60,
        borderWidth: 2,
        activeColor: Colors.black,
        activeFillColor: Colors.black,
        selectedColor: Colors.black,
        selectedFillColor: Colors.black,
        inactiveColor: Colors.black,
        inactiveFillColor: Colors.black,
        errorBorderColor: Colors.black,
        disabledColor: Colors.black,
      ),
      cursorColor: Colors.black,
      backgroundColor: Colors.white,
      enableActiveFill: false,
      onCompleted: onCompleted,
      onChanged: (String value) { },
    );
  }
}
