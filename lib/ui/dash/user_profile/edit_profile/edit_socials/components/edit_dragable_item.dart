import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nas_academy/core/modules/user/sub/social_media.dart';
import 'package:nas_academy/core/services/navigator.dart';
import 'package:nas_academy/core/utils/color_plate.dart';
import 'package:nas_academy/ui/dash/user_profile/edit_profile/edit_socials/components/edit_social.dart';

class EditSocialItem extends StatelessWidget {
  const EditSocialItem({Key? key, required this.media})
      : super(key: key);
  final SocialMedia media;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 25,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 2,
              child: SvgPicture.asset(
                media.inactiveIcon(),
              ),
            ),
            Expanded(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    media.type!,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: ColorPlate.primaryLightBG),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: Text(
                      media.link!,
                      maxLines: 3,
                      overflow: TextOverflow.clip,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: ColorPlate.secondaryLightBG),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                onTap: () {
                  Navigate.push(
                    context,
                    EditSocialMediaScreen(media: media)
                  );
                },
                child: const Text(
                  'Edit',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: ColorPlate.primaryLightBG),
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
          ],
        ),
        const SizedBox(
          height: 25,
        ),
        const Divider(
          height: 0,
          thickness: 1,
          color: ColorPlate.neutral90,
        )
      ],
    );
  }
}
