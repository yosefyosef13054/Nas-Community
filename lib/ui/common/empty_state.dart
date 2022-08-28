import "package:flutter/material.dart";
import 'package:line_icons/line_icons.dart';
import 'package:nas_academy/core/utils/color_plate.dart';



class EmptyState extends StatelessWidget {
  const EmptyState({Key? key, this.title, this.icon}) : super(key: key);
  final String? title;
  final IconData? icon;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const  SizedBox(height: 50,),
        Icon(icon ?? LineIcons.wind, size: 100, color: ColorPlate.tertiaryLightBG,),
        const  SizedBox(height: 50,),
        Text(title ?? "Empty List ..", style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: ColorPlate.tertiaryLightBG),),
      ],
    );
  }
}
