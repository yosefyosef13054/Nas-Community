import 'dart:io';

import 'package:appsflyer_sdk/appsflyer_sdk.dart';

class AppsFlyerService {
  AppsflyerSdk? _appsflyerSdk;

  void init() {
    final AppsFlyerOptions options = AppsFlyerOptions(
        afDevKey: 'fpnduNQJpFxG5To4ftc7C9',
        appId: Platform.isAndroid ? "com.nas.nas_academy" : '1620466874',
        showDebug: true,
        timeToWaitForATTUserAuthorization: 15);
    _appsflyerSdk = AppsflyerSdk(options);

    _appsflyerSdk!.initSdk(
        registerConversionDataCallback: true,
        registerOnAppOpenAttributionCallback: true,
        registerOnDeepLinkingCallback: true);
  }
}
