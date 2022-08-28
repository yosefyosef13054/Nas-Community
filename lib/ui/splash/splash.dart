import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nas_academy/core/providers/boarding/intro.dart';
import 'package:nas_academy/core/providers/dash/dash_provider.dart';
import 'package:nas_academy/core/utils/color_plate.dart';
import 'package:nas_academy/ui/common/logo.dart';
import 'package:provider/provider.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);
  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    final dash = Provider.of<DashProvider>(context, listen: false);
    final intro = Provider.of<IntroProvider>(context, listen: false);
    AppTrackingTransparency.requestTrackingAuthorization();
    intro.splashLogoTransition(context, dash);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: ColorPlate.primaryLightBG,
          systemOverlayStyle: SystemUiOverlayStyle.light,
          toolbarHeight: 0,
        ),
        body: const Material(
          color: ColorPlate.primaryLightBG,
          child: Center(
            child: Hero(
              tag: "logo",
              child: Logo(
                height: 80,
                width: 80,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
