import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nas_academy/core/providers/dash/dash_provider.dart';
import 'package:nas_academy/core/utils/color_plate.dart';
import 'package:provider/provider.dart';

class DrawerListItem extends StatelessWidget {
  const DrawerListItem({
    Key? key,
    required this.index,
    required this.text,
  }) : super(key: key);

  final int index;
  final String text;
  @override
  Widget build(BuildContext context) {
    final dash = Provider.of<DashProvider>(context);
    final bool selected = dash.communityViewIndex == index;
    return InkWell(
      onTap: () async {
        dash.drawerController.close!();
        dash.communityViewPageController.jumpToPage(index);
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        width: double.infinity,
        decoration: BoxDecoration(
            color: selected ? ColorPlate.neutral95 : ColorPlate.primaryDarkBG,
            borderRadius: BorderRadius.circular(12)),
        child: Row(children: [
          SvgPicture.asset(
              "assets/svg/${_icon(index)}_${selected ? "selected" : "stroke"}.svg"),
          const SizedBox(
            width: 20,
          ),
          Text(
            text,
            style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: ColorPlate.primaryLightBG),
          )
        ]),
      ),
    );
  }

  String _icon(int index) {
    switch (index) {
      case 0:
        return "Home";
      case 1:
        return "live_sessions";
      case 2:
        return "library";
      case 3:
        return "members";
      case 4:
        return "trainer";
      default:
        return "";
    }
  }
}
