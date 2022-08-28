import "package:flutter/material.dart";
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nas_academy/core/services/navigator.dart';
import 'package:nas_academy/core/utils/assets.dart';
import 'package:nas_academy/core/utils/color_plate.dart';
import 'package:nas_academy/ui/dash/user_profile/edit_profile/edit_spotlight/components/add_new_spotlight.dart';



class NoSpotlightState extends StatelessWidget {
  const NoSpotlightState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 50,),
        SvgPicture.asset(Assets.tipsAndUpdates, width: 160, height: 160, color: ColorPlate.yellow90,),
        const SizedBox(height: 35,),
        const Text("Nothing to spotlight yet", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),),
       const SizedBox(height: 15,),
        ElevatedButton.icon(
          style: ButtonStyle(
            shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(100))),
            elevation: MaterialStateProperty.all(0)
          ),
            onPressed: (){
            Navigate.push(context, const AddNewSpotlight());
            },
            label: const Text("Add"),
            icon: const Icon(Icons.add, size: 18,),
        ),
      ],
    );
  }
}
