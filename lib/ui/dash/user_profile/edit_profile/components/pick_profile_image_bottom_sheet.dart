import "package:flutter/material.dart";
import 'package:image_picker/image_picker.dart';
import 'package:nas_academy/core/providers/dash/profile_provider.dart';
import 'package:nas_academy/core/utils/color_plate.dart';
import 'package:provider/provider.dart';



class PickProfileImageBottomSheet extends StatelessWidget {
  const PickProfileImageBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<ProfileProvider>(context);
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
                        'Change image',
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
                          foregroundColor: MaterialStateProperty.all(Colors.black)
                      ),
                      child: const Text("Take a photo"),
                      onPressed: ()async{
                        await profile.pickProfileImage(ImageSource.camera);
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 15,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 48,
                    child: OutlinedButton(
                      style: ButtonStyle(
                          side: MaterialStateProperty.all(const BorderSide(color: ColorPlate.secondaryLightBG)),
                          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(100))),
                          foregroundColor: MaterialStateProperty.all(Colors.black)
                      ),
                      child: const Text("Choose from library"),
                      onPressed: ()async{
                        await profile.pickProfileImage(ImageSource.gallery);
                        Navigator.pop(context);
                      },
                    ),
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
