import 'dart:async';

import 'package:dostavka/screens/webview/web_view_stack.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


class WebViewApp extends StatefulWidget {
  const WebViewApp({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const WebViewApp());
  }

  @override
  State<WebViewApp> createState() => _WebViewAppState();
}

class _WebViewAppState extends State<WebViewApp> {
  final controller = Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            WebViewStack(controller: controller),
            Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.only(left: 20.0),
              child: Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: Colors.white70, width: 1),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Container(
                  color: const Color(0x00ffffff).withOpacity(0),
                  width: 50,
                  height: 50,
                  child: Column(
                    children: <Widget>[
                      IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () => Navigator.of(context).pop(true),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}