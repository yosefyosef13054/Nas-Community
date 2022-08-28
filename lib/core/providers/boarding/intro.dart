import 'dart:async';
import 'package:flutter/material.dart';
import 'package:nas_academy/auth_wrapper.dart';
import 'package:nas_academy/core/api/app_compatibility/app_compatibility.dart';
import 'package:nas_academy/core/local_db/user/user_local_db.dart';
import 'package:nas_academy/core/modules/user/user.dart';
import 'package:nas_academy/core/providers/dash/dash_provider.dart';

class IntroProvider extends ChangeNotifier {
  final Duration logoDuration = const Duration(milliseconds: 1500);
  final Duration fadeDuration = const Duration(milliseconds: 500);
  final Duration slideDuration = const Duration(milliseconds: 4000);
  final Duration slideTransitionDuration = const Duration(milliseconds: 150);
  final Curve logoCurve = Curves.easeInOut;
  final Curve fadeCurve = Curves.easeOut;
  // late Timer _timer;
  late TabController _slidesTabController;

  TabController get slidesTabController => _slidesTabController;

  set setSlidesTabController(TabController value) {
    _slidesTabController = value;
  }

  int _currentIndex = -1;
  bool _showContent = false;

  int get currentIndex => _currentIndex;

  set setCurrentIndex(int value) {
    _currentIndex = value;
    notifyListeners();
  }

  bool get showContent => _showContent;

  set setShowContent(bool value) {
    _showContent = value;
    notifyListeners();
  }


  Future splashLogoTransition(BuildContext context, DashProvider dash) async {
    // final bool compatible = await AppCompatibilityAPI().isCompatible();
    const bool compatible = true;
    if(compatible == true){
      final User? user = await UserLocalDB.currentUser();
      if(user != null){
        await dash.init();
      }else {
        await Future.delayed(const Duration(seconds: 1));
      }
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
            transitionDuration: user == null? logoDuration : const Duration(milliseconds: 600),
            reverseTransitionDuration: user == null? logoDuration : const Duration(milliseconds: 600),
            transitionsBuilder: (context, a1, a2, child){
              return FadeTransition(
                opacity: a1,
                child: child,
              );
            },
            pageBuilder: (_, __, ___) => const AuthWrapper()),
      );
      await Future.delayed(logoDuration);
      setShowContent = true;
      setCurrentIndex = 0;
    }else{
     AppCompatibilityAPI().showUpdateDialog(context);
    }
  }

}
