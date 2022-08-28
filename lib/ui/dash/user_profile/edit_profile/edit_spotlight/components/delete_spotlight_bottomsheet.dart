import "package:flutter/material.dart";
import 'package:nas_academy/core/modules/user/sub/soptlight.dart';
import 'package:nas_academy/core/modules/user/user.dart';
import 'package:nas_academy/core/providers/dash/profile_provider.dart';
import 'package:nas_academy/core/utils/color_plate.dart';
import 'package:provider/provider.dart';



class DeleteSpotlightBottomSheet extends StatelessWidget {
  const DeleteSpotlightBottomSheet({Key? key, required this.spotLight}) : super(key: key);
  final SpotLight spotLight;
  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<ProfileProvider>(context);
    final user = Provider.of<User?>(context);
    return ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28),
        ),
        child: Material(
          color: ColorPlate.neutral100,
          child: SafeArea(
            top: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24, right: 16),
                  child: Row(
                    children: [
                      const Text(
                        'Confirm delete?',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: ColorPlate.primaryLightBG),
                      ),
                      const Spacer(),
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.close,
                            color: ColorPlate.neutral70,
                          ))
                    ],
                  ),
                ),
                const Divider(
                  height: 10,
                  thickness: 1,
                  color: ColorPlate.neutral90,
                ),
                const SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 48,
                    child: OutlinedButton(
                      style: ButtonStyle(
                          side: MaterialStateProperty.all(const BorderSide(color: ColorPlate.secondaryLightBG)),
                          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(100))),
                          foregroundColor: MaterialStateProperty.all(Colors.red[900])
                      ),
                      child: const Text("Delete"),
                      onPressed: ()async{
                        if(user != null){
                          user.learner.spotlights.removeWhere((element) => element.link == spotLight.link);
                          profile.notify();
                          Navigator.pop(context);
                          await profile.editSpotlight(spotLight, null, user,context);
                        }
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 15,),
                Center(
                  child: TextButton(
                    child: const Text("Cancel", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15, color: Colors.black),),
                    onPressed: ()=> Navigator.pop(context),
                  ),
                ),
                const SizedBox(
                  height: 55,
                ),
              ],
            ),
          ),
        ));
  }
}
