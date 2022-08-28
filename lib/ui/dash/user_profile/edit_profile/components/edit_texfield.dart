import 'package:flutter/material.dart';
import 'package:nas_academy/core/utils/color_plate.dart';

class EdiTextField extends StatelessWidget {
  const EdiTextField({
    required this.label,
    Key? key,
  }) : super(key: key);
  final String label;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: TextField(
        decoration: InputDecoration(
          label: Text(
            label,
            style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: ColorPlate.primaryLightBG),
          ),
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
