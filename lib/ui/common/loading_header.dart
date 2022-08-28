import "package:flutter/material.dart";
import 'package:nas_academy/core/utils/color_plate.dart';



class LoadingHeader extends StatelessWidget {
  const LoadingHeader({Key? key,required this.loading}) : super(key: key);
  final bool loading;
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size(MediaQuery.of(context).size.width, 1),
      child: Visibility(
        visible: loading,
        child: const LinearProgressIndicator(
          minHeight: 1.5,
          backgroundColor: Colors.transparent,
          valueColor:
          AlwaysStoppedAnimation<Color>(ColorPlate.yellow70),
        ),
      ),
    );
  }
}
