import 'package:flutter/material.dart';
import 'package:nas_academy/core/modules/contentfull/contentfull_model.dart';
import 'package:nas_academy/core/utils/color_plate.dart';
import 'package:nas_academy/ui/dash/discover/community_page/components/custom_textfield.dart';


class AboutSection extends StatelessWidget {
  const AboutSection({
    required this.items,
    Key? key,
  }) : super(key: key);
  final List<Item> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'About',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 24,
            color: ColorPlate.primaryLightBG,
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        CustomTextField(
          text: items[0].fields!.descriptionSection!.descriptionItems,
        )
        // ...items[0].fields!.descriptionSection!.descriptionItems.map(
        //       (e) => Text(
        //         e.first.text.toString(),
        //         style: const TextStyle(
        //           fontWeight: FontWeight.w500,
        //           fontSize: 16,
        //           color: ColorPlate.primaryLightBG,
        //         ),
        //       ),
        //     )
      ],
    );
  }
}
