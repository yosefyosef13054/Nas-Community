import 'package:flutter/material.dart';
import 'package:nas_academy/core/modules/contentfull/contentfull_model.dart';
import 'package:nas_academy/core/utils/color_plate.dart';
import 'package:nas_academy/ui/dash/discover/community_page/components/custom_textfield.dart';
import 'package:nas_academy/ui/dash/discover/community_page/components/shared_widgets/bullet_text.dart';

class ExclusiveSpaceSection extends StatelessWidget {
  const ExclusiveSpaceSection({
    required this.items,
    Key? key,
  }) : super(key: key);
  final List<Item> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CustomTextField(
            text: items[0].fields!.whoIsThisForSection!.title,
            fontsize: 24,
            fontWeight: FontWeight.w600,
            textcolor: ColorPlate.primaryLightBG),
        const SizedBox(
          height: 24,
        ),
        ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items[0].fields!.whoIsThisForSection!.ctaItems.length,
          itemBuilder: (BuildContext context, int i) {
            return BulletText(
              bulletColor: ColorPlate.yellow70,
              text: items[0].fields!.whoIsThisForSection!.ctaItems[i].title,
            );
          },
        ),
      ],
    );
  }
}
