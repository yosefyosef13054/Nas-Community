import 'package:flutter/material.dart';
import 'package:nas_academy/core/utils/color_plate.dart';

class SelectedReasonItem extends StatelessWidget {
  const SelectedReasonItem({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: Row(
        children: [
          const Expanded(
              flex: 1,
              child: Icon(Icons.check, color: ColorPlate.yellow60,)),
          const SizedBox(width: 15,),
          Expanded(
              flex: 10,
              child: Text(title, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),)),
        ],
      ),
    );
  }
}
