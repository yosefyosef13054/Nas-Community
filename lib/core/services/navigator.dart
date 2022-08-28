
import 'package:flutter/material.dart';

class Navigate {
  Navigate._();


  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static void push (BuildContext context, Widget to , {Offset? offset}){
    Navigator.of(context).push(PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 150),
        transitionsBuilder: (context, a1, a2, child){
          return SlideTransition(
            position: Tween<Offset>(begin: offset ?? const Offset(0, 1), end: Offset.zero).animate(a1),
            child: FadeTransition(
                opacity: a1,
                child: child),
          );
        },
        pageBuilder: (_,__,___)=> to));
  }

  static void pushReplace (BuildContext context, Widget to){
    Navigator.of(context).pushReplacement(PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 150),
        transitionsBuilder: (context, a1, a2, child){
        return SlideTransition(
          position: Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero).animate(a1),
          child: FadeTransition(
              opacity: a1,
              child: child),
        );
        },
        pageBuilder: (_,__,___)=> to));
  }

}