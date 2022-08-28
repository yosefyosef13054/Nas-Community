import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nas_academy/core/utils/assets.dart';
import 'package:nas_academy/core/utils/color_plate.dart';

class DraggableItem extends StatelessWidget {
  const DraggableItem({
    Key? key,
    required this.label,
    required this.onDelete,
  }) : super(key: key);

  final String label;
  final Function onDelete;
  @override
  Widget build(BuildContext context) {
    return Column(
      key: Key(label),
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Chip(
              label: Text(
                label,
                style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: ColorPlate.primaryLightBG),
              ),
              backgroundColor: ColorPlate.yellow90,
            ),
            const Spacer(),
            IconButton(
              splashColor: Colors.red.withOpacity(0.1),
              highlightColor: Colors.red.withOpacity(0.1),
              onPressed: (){
                onDelete();
              },
              icon: SvgPicture.asset(
                Assets.delete,
                height: 18,
                width: 14,
                color: ColorPlate.tertiaryLightBG,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
          ],
        ),
        const SizedBox(
          height: 10,
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
