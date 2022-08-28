import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nas_academy/app.dart';
import 'package:nas_academy/core/api/algolia_service/algolia.dart';
import 'package:nas_academy/core/appsflyer/appsflyer.dart';




void main() async {

  runZonedGuarded(()async{
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    AppsFlyerService().init();
    AlgoliaService.initalgolia;
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
    ));
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);
    runApp(const Restart(child: MainApp()));
  }, (Object error, StackTrace stack) {
    FlutterError.onError!
        .call(FlutterErrorDetails(exception: error, stack: stack));
  });
}




class Restart extends StatefulWidget {
  const Restart({Key? key, required this.child}) : super(key: key);

  final Widget child;

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_RestartState>()!.restartApp();
  }

  @override
  _RestartState createState() => _RestartState();
}

class _RestartState extends State<Restart> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child,
    );
  }
}
