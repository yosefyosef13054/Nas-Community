import 'package:flutter/material.dart';
import 'package:nas_academy/core/utils/color_plate.dart';
import 'package:nas_academy/core/utils/constants.dart';


class Loading extends StatelessWidget {
  const Loading ({ Key? key,this.borderRadius, this.color, this.text, this.spinnerColor}) : super(key: key);
  final double? borderRadius;
  final Color? color;
  final Color? spinnerColor;
  final String? text;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
            color: color ??  Colors.black54,
            borderRadius: BorderRadius.circular(borderRadius ?? 0.0)
        ),
        child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(ColorPlate.yellow70),
                  strokeWidth: 2,
                ),
                Visibility(
                  visible: text != null,
                  child: Column(
                    children: [
                      const SizedBox(height: 20,),
                      Text(text ?? "", style: Constants.titleStyle.copyWith(color: ColorPlate.yellow70),)
                    ],
                  ),
                ),
              ],
            )
        ),
      ),
    );
  }
}
