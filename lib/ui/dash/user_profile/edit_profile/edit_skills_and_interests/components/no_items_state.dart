import "package:flutter/material.dart";
import 'package:flutter_svg/flutter_svg.dart';

import 'package:nas_academy/core/utils/assets.dart';
import 'package:nas_academy/core/utils/color_plate.dart';




class NoItemsState extends StatelessWidget {
  const NoItemsState({Key? key, required this.label, required this.onAdd}) : super(key: key);
  final String label;
  final Function onAdd;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 50,),
        SvgPicture.asset(Assets.tipsAndUpdates, width: 100, height: 100, color: ColorPlate.yellow90,),
        const SizedBox(height: 5,),
        Text("No $label yet",  style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),),
        const SizedBox(height: 15,),
        ElevatedButton.icon(
          style: ButtonStyle(
              shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(100))),
              elevation: MaterialStateProperty.all(0)
          ),
          onPressed: (){
           onAdd();
          },
          label: const Text("Add"),
          icon: const Icon(Icons.add, size: 18,),
        ),
        const SizedBox(height: 40,),
      ],
    );
  }
}
