import "package:flutter/material.dart";
import 'package:flutter_svg/svg.dart';
import 'package:nas_academy/core/modules/user/sub/social_media.dart';
import 'package:nas_academy/core/utils/color_plate.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialMediaButton extends StatelessWidget {
  const SocialMediaButton({Key? key, required this.media}) : super(key: key);
  final SocialMedia media;
  @override
  Widget build(BuildContext context) {
    if (media.iconLink != null &&
        media.iconLink!.isNotEmpty &&
        media.link != null &&
        media.link!.isNotEmpty) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 6),
        child: InkWell(
          onTap: () async {
            await launchUrl(Uri.parse(media.link!));
          },
          overlayColor: MaterialStateProperty.all(Colors.transparent),
          child: SizedBox(
            height: 20,
            width: 20,
            child: SvgPicture.network(media.iconLink!,
                fit: BoxFit.cover, color: ColorPlate.secondaryLightBG),
          ),
        ),
      );
    } else {
      return const SizedBox(
        height: 0,
        width: 0,
      );
    }
  }
}
