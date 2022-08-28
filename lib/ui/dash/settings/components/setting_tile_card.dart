import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nas_academy/core/utils/color_plate.dart';

class SettingTileCard extends StatelessWidget {
  const SettingTileCard({
    Key? key,
    required this.onTap,
    required this.icon,
    required this.text,
  }) : super(key: key);

  final Function onTap;
  final String icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          minLeadingWidth: 20,
          contentPadding: const EdgeInsets.all(0),
          leading: SvgPicture.asset(icon),
          title: Text(
            text,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: ColorPlate.primaryLightBG,
            ),
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            color: Colors.black,
            size: 14,
          ),
          selected: true,
          onTap: () {
            onTap();
            // Navigate.push(context, const HelpDeskScreen());
          },
        ),
        const Divider(
          height: 10,
          thickness: 1,
          indent: 40,
          endIndent: 0,
          color: ColorPlate.neutral90,
        ),
      ],
    );
  }
}
