import 'dart:io';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class GiveUsFeedbackWebView extends StatefulWidget {
  const GiveUsFeedbackWebView({Key? key}) : super(key: key);

  @override
  GiveUsFeedbackWebViewState createState() => GiveUsFeedbackWebViewState();
}

class GiveUsFeedbackWebViewState extends State<GiveUsFeedbackWebView> {
  @override
  void initState() {
    super.initState();
    // Enable virtual display.
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 15,
            color: Colors.black,
          ),
        ),
      ),
      body: const WebView(
        initialUrl: 'https://nas.io/feedback',
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
