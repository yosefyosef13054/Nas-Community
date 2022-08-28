import 'dart:io';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ForgetPassWebView extends StatefulWidget {
  const ForgetPassWebView({Key? key}) : super(key: key);

  @override
  ForgetPassWebViewState createState() => ForgetPassWebViewState();
}

class ForgetPassWebViewState extends State<ForgetPassWebView> {
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
        initialUrl: 'https://learn.nasacademy.com/forget-password',
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
