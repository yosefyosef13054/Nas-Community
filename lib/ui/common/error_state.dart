import "package:flutter/material.dart";
import 'package:nas_academy/core/utils/color_plate.dart';

class ErrorState extends StatelessWidget {
  const ErrorState({Key? key, this.title, this.icon}) : super(key: key);
  final String? title;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(
          height: 50,
        ),
        Icon(
          icon ?? Icons.error,
          size: 100,
          color: ColorPlate.tertiaryLightBG,
        ),
        const SizedBox(
          height: 50,
        ),
        Text(
          title ?? "Failed to complete request, try again later",
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: ColorPlate.tertiaryLightBG),
        ),
      ],
    );
  }
}
