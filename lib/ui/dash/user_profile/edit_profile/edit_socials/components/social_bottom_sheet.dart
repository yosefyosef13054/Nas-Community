import 'package:flutter/material.dart';

import 'package:nas_academy/core/utils/color_plate.dart';
import 'package:nas_academy/core/utils/data_types.dart';
import 'package:nas_academy/ui/dash/user_profile/edit_profile/edit_socials/components/social_list_item.dart';

class SocialBottomSheet extends StatelessWidget {
  const SocialBottomSheet({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28),
        ),
        child: Material(
          color: ColorPlate.neutral100,
          child: SafeArea(
            top: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24, right: 16),
                  child: Row(
                    children: [
                      const Text(
                        'Add social platform',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: ColorPlate.primaryLightBG),
                      ),
                      const Spacer(),
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.close,
                            color: ColorPlate.neutral70,
                          ))
                    ],
                  ),
                ),
                const Divider(
                  height: 30,
                  thickness: 1,
                  color: ColorPlate.neutral90,
                ),
                ListView.builder(
                    padding: const EdgeInsets.only(top: 25),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: SocialMediaTypes.values.length,
                    itemBuilder: (context, index) {
                      return ListItem(
                        type: SocialMediaTypes.values[index],
                      );
                    }),
              ],
            ),
          ),
        ));
  }
}
