import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nas_academy/core/utils/color_plate.dart';


class TrainerBadge extends StatelessWidget {
  const TrainerBadge({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(top: 5),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
          color: ColorPlate.blurple60,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset("assets/svg/nas_badge.svg"),
            const SizedBox(width: 8,),
            const Text("Trainer", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.white),)
          ],
        ),
      ),
    );
  }
}
