import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Terms extends StatelessWidget {
  const Terms({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height:MediaQuery.of(context).size.height,
      child: WebView(
          initialUrl: 'https://strice.flycricket.io/terms.html',
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          }
          ),
    );
  }
}
