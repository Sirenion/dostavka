import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewStack extends StatefulWidget {
  const WebViewStack({required this.controller, Key? key}) : super(key: key);

  final Completer<WebViewController> controller;

  @override
  State<WebViewStack> createState() => _WebViewStackState();
}

class _WebViewStackState extends State<WebViewStack> {
  var loadingPercentage = 0;
  String initialUrl = "https://www.google.com/search?gs_ssp=eJzj4tTP1TcwNi8oKFBgNGB0YPDiSMxJS0xKzMsGAFJ1Bt0&q=alfabank&oq=alfaba&aqs=chrome.1.0i131i355i433i512j46i131i199i291i433i512j0i512j69i57j0i512l3j69i60.4055j0j9&sourceid=chrome&ie=UTF-8";

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WebView(
          initialUrl: initialUrl,
          onWebViewCreated: (webViewController) {
            widget.controller.complete(webViewController);
          },
          onPageStarted: (url) {
            setState(() {
              loadingPercentage = 0;
            });
          },
          onProgress: (progress) {
            setState(() {
              loadingPercentage = progress;
            });
          },
          onPageFinished: (url) {
            setState(() {
              loadingPercentage = 100;
            });
          },
          navigationDelegate: (navigation) {
            final host = Uri.parse(navigation.url).host;
            if (host.contains('alfabank') || host.contains('alfa-bank') || host.contains('альфа банк') || host.contains('альфабанк')) {
              return NavigationDecision.navigate;
            }
            else
              {
                Navigator.of(context).pop(true);
                return NavigationDecision.prevent;
              }

          },
          javascriptMode: JavascriptMode.unrestricted,        // Add this line
        ),
        if (loadingPercentage < 100)
          LinearProgressIndicator(
            value: loadingPercentage / 100.0,
          ),
      ],
    );
  }
}