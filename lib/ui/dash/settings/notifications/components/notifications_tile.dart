import 'package:flutter/material.dart';
import 'package:nas_academy/ui/dash/settings/notifications/components/custom_cupertino_switch.dart';
import 'package:nas_academy/core/utils/color_plate.dart';

class NotificationsTile extends StatefulWidget {
  const NotificationsTile({
    Key? key,
    required this.text,
    required this.value,
    required this.onChanged
  }) : super(key: key);
  final String text;
  final bool value;
  final Function(bool) onChanged;
  @override
  State<NotificationsTile> createState() => _NotificationsTileState();
}

class _NotificationsTileState extends State<NotificationsTile> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.text,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: ColorPlate.primaryLightBG,
              ),
            ),
            CustomCupertinoSwitch(
              width: 52.0,
              height: 32.0,
              activeColor: ColorPlate.yellow70,
              inactiveColor: ColorPlate.neutral100,
              activeToggleColor: Colors.white,
              inactiveToggleColor: Colors.black,
              inactiveSwitchBorder: Border.all(
                width: 2.0,
                color: ColorPlate.neutral70,
              ),
              activeIcon: const Icon(Icons.check),
              valueFontSize: 25.0,
              toggleSize: 25.0,
              value: widget.value,
              borderRadius: 30.0,
              padding: 4.0,
              showOnOff: false,
              onToggle: (val)async{
                await widget.onChanged(val);
              },
            ),
          ],
        ),
        const Divider(
          height: 40,
          thickness: 1,
          endIndent: 0,
          color: ColorPlate.neutral90,
        ),
      ],
    );
  }
}
