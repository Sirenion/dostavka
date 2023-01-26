import 'package:dostavka/screens/pin/authentication_pin_page.dart';
import 'package:dostavka/screens/pin/create_pin_page.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  static const String createPINCode = "Create PIN code";
  static const String authenticationByPINCode = "Authentication by PIN code";

  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            TextButton(
              onPressed: (){
                Navigator.push(context,CreatePIN.route());
              },
              child: const Center(
                  child: Text(createPINCode)
              ),
            ),
            TextButton(
              onPressed: (){
                Navigator.push(context,AuthenticationPIN.route());
              },
              child: const Center(
                  child: Text(authenticationByPINCode)
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const Home());
  }
}
