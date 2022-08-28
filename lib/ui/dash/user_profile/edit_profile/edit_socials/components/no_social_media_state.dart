import "package:flutter/material.dart";
import 'package:flutter_svg/flutter_svg.dart';

import 'package:nas_academy/core/utils/assets.dart';
import 'package:nas_academy/core/utils/color_plate.dart';



class NoSocialMediaState extends StatelessWidget {
  const NoSocialMediaState({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 50,),
        SvgPicture.asset(Assets.tipsAndUpdates, width: 100, height: 100, color: ColorPlate.yellow90,),
        const SizedBox(height: 5,),
        const Text("No socials yet",  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),),
        const SizedBox(height: 40,),
      ],
    );
  }
}
