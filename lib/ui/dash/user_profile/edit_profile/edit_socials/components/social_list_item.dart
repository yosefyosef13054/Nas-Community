import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nas_academy/core/utils/data_types.dart';

import '../../../../../../core/services/navigator.dart';
import '../../../../../../core/utils/color_plate.dart';
import 'add_social_screen.dart';

class ListItem extends StatelessWidget {
  const ListItem({Key? key, required this.type})
      : super(key: key);
  final SocialMediaTypes type;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigate.push(
          context,
          AddUpdateSocial(
            type: type,
          ),
        );
      },
      child: Column(
        children: [
          Row(
            children: [
              const SizedBox(
                width: 26,
              ),
              SvgPicture.asset(
                socialMediaActiveIcon(type),
                width: 21,
                height: 28,
              ),
              const SizedBox(
                width: 18,
              ),
              Text(
                socialMediaTypesToString(type),
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: ColorPlate.primaryLightBG),
              ),
            ],
          ),
          const SizedBox(
            height: 31,
          )
        ],
      ),
    );
  }
}
