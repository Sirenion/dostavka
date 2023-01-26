import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

enum _MenuOptions {
  navigationDelegate,
  userAgent,                                          // Add this line
}

class Menu extends StatelessWidget {
  const Menu({required this.controller, Key? key}) : super(key: key);

  final Completer<WebViewController> controller;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WebViewController>(
      future: controller.future,
      builder: (context, controller) {
        return PopupMenuButton<_MenuOptions>(
          onSelected: (value) async {
            switch (value) {
              case _MenuOptions.navigationDelegate:
                controller.data!.loadUrl('https://www.google.com/search?gs_ssp=eJzj4tTP1TcwNi8oKFBgNGB0YPDiSMxJS0xKzMsGAFJ1Bt0&q=alfabank&oq=alfaba&aqs=chrome.1.0i131i355i433i512j46i131i199i291i433i512j0i512j69i57j0i512l3j69i60.4055j0j9&sourceid=chrome&ie=UTF-8');
                break;
            // Add from here ...
              case _MenuOptions.userAgent:
                final userAgent = await controller.data!
                    .runJavascriptReturningResult('navigator.userAgent');
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(userAgent),
                ));
                break;
            // ... to here.
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem<_MenuOptions>(
              value: _MenuOptions.navigationDelegate,
              child: Text('Navigate to Google Search'),
            ),
            // Add from here ...
            const PopupMenuItem<_MenuOptions>(
              value: _MenuOptions.userAgent,
              child: Text('Show user-agent'),
            ),
            // ... to here.
          ],
        );
      },
    );
  }
}