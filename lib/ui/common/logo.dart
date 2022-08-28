import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Logo extends StatelessWidget {
  const Logo({Key? key, required this.width, required this.height})
      : super(key: key);
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      "assets/svg/Logo Unit.svg",
      height: height,
      width: width,
    );
  }
}
