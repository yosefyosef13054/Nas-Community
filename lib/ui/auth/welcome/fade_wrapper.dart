import 'package:flutter/material.dart';
import 'package:nas_academy/core/providers/boarding/intro.dart';
import 'package:provider/provider.dart';



class Fade extends StatelessWidget {
  const Fade({Key? key, required this.child}) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    final intro = Provider.of<IntroProvider>(context);
    return AnimatedOpacity(
      duration: intro.fadeDuration,
      curve: intro.fadeCurve,
      opacity: intro.showContent? 1 : 0,
      child: child,
    );
  }
}
