import 'package:flutter/material.dart';
import 'package:nas_academy/core/utils/color_plate.dart';

class BillingCard extends StatelessWidget {
  const BillingCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              'dd/mm/yy',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: ColorPlate.primaryLightBG,
              ),
            ),
            Text(
              'USD 29',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: ColorPlate.primaryLightBG,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        const Text(
          'Community Name',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: ColorPlate.primaryLightBG,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        const Text(
          '4242 42424242',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: ColorPlate.neutral50,
          ),
        ),
        const Divider(
          height: 30,
          thickness: 1,
          indent: 0,
          endIndent: 0,
          color: ColorPlate.neutral90,
        ),
      ],
    );
  }
}
