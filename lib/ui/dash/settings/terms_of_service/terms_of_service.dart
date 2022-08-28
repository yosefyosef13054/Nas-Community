import 'dart:io';
import 'package:flutter/material.dart';
import 'package:nas_academy/core/utils/color_plate.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TermsOfServiceWebView extends StatefulWidget {
  const TermsOfServiceWebView({Key? key}) : super(key: key);

  @override
  TermsOfServiceWebViewState createState() => TermsOfServiceWebViewState();
}

class TermsOfServiceWebViewState extends State<TermsOfServiceWebView> {
  @override
  void initState() {
    super.initState();
    // Enable virtual display.
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }
  bool _loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
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
        bottom: PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width, 1),
          child: Visibility(
            visible: _loading,
            child: const LinearProgressIndicator(
              minHeight: 1.5,
              backgroundColor: Colors.transparent,
              valueColor:
              AlwaysStoppedAnimation<Color>(ColorPlate.yellow70),
            ),
          ),
        ),
      ),
      body: WebView(
        initialUrl: 'https://nas.io/enrollment-terms',
        javascriptMode: JavascriptMode.unrestricted,
        onProgress: (progress){
          if(progress == 100){
            setState(()=> _loading = false);
          }else {
            if(!_loading){
              setState(()=> _loading = true);
            }
          }
        },
      ),
    );
  }
}
