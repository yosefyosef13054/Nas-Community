import 'package:flutter/material.dart';
import 'package:nas_academy/core/utils/color_plate.dart';

class PasswordGuide extends StatelessWidget {
  const PasswordGuide({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: ColorPlate.neutral200,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Your password must be have at least:',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: ColorPlate.primaryLightBG,
              ),
            ),
            Text(
              '• 8 characters',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: ColorPlate.primaryLightBG,
              ),
            ),
            Text(
              '• 1 uppercase & 1 lowercase character',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: ColorPlate.primaryLightBG,
              ),
            ),
            Text(
              '• 1 number',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: ColorPlate.primaryLightBG,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
