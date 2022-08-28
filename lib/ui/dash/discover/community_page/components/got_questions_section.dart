import 'package:flutter/material.dart';
import 'package:nas_academy/core/modules/contentfull/contentfull_model.dart';
import 'package:nas_academy/core/utils/color_plate.dart';
import 'package:nas_academy/ui/dash/discover/community_page/components/custom_textfield.dart';


class GotQuestionsSection extends StatelessWidget {
  const GotQuestionsSection({
    required this.items,
    Key? key,
  }) : super(key: key);
  final List<Item> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Text(
          'Got questions? We have answers.',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 24,
            color: ColorPlate.primaryLightBG,
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items[0].fields!.faq!.faqs.length,
          itemBuilder: (BuildContext context, int i) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                i != 0 ? const SizedBox(height: 12.0) : const SizedBox(),
                Theme(
                  data: Theme.of(context).copyWith(
                    dividerColor: Colors.transparent,
                  ),
                  child: ExpansionTile(
                    tilePadding: EdgeInsets.zero,
                    title: Text(
                      items[0].fields!.faq!.faqs[i].title.toString(),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    children: [
                      CustomTextField(
                        text: items[0].fields!.faq!.faqs[i].content,
                        nomaxLines: true,
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
