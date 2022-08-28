import 'package:flutter/material.dart';
import 'package:nas_academy/core/utils/color_plate.dart';

class BulletText extends StatelessWidget {
  const BulletText({Key? key, this.bulletColor, this.text}) : super(key: key);
  final String? text;
  final Color? bulletColor;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.check,
          color: bulletColor ?? ColorPlate.yellow60,
        ),
        const SizedBox(
          width: 12,
        ),
        Text(
          text == null ? 'Applications will be here' : text.toString(),
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14,
            color: ColorPlate.neutral10,
          ),
        ),
      ],
    );
  }
}
