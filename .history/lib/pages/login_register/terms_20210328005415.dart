import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Terms extends StatelessWidget {
  // const Terms({Key key}) : super(key: key);
  final Completer<WebViewController> _controller = Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      // height:MediaQuery.of(context).size.height,
      child: SafeArea(
              child: WebView(
            initialUrl: 'https://strice.flycricket.io/terms.html',
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              _controller.complete(webViewController);
            }),
      ),
    );
  }
}
