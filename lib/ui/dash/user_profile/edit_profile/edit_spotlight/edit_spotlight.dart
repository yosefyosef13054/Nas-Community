import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:nas_academy/core/modules/user/user.dart';
import 'package:nas_academy/core/providers/dash/profile_provider.dart';
import 'package:nas_academy/core/services/navigator.dart';
import 'package:nas_academy/core/utils/color_plate.dart';
import 'package:nas_academy/ui/common/loading.dart';
import 'package:nas_academy/ui/dash/user_profile/edit_profile/edit_spotlight/components/add_new_spotlight.dart';
import 'package:nas_academy/ui/dash/user_profile/edit_profile/edit_spotlight/components/no_spotlight_state.dart';
import 'package:nas_academy/ui/dash/user_profile/edit_profile/edit_spotlight/components/spot_light_preview.dart';
import 'package:provider/provider.dart';


class EditSpotlight extends StatelessWidget {
  const EditSpotlight({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<ProfileProvider>(context);
    final user = Provider.of<User?>(context);
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        foregroundColor: Colors.black,
        leadingWidth: 65,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: TextButton(
            child: const Text("Done", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: Colors.black),),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
        ),
        actions: [
          Center(
            child: OutlinedButton.icon(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(Colors.black),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(100))),
                side: MaterialStateProperty.all(const BorderSide(color: ColorPlate.secondaryLightBG))
              ),
              onPressed: (){
                Navigate.push(context, const AddNewSpotlight());
              },
              label: const Text("Add",style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: Colors.black),),
              icon: const Icon(Icons.add, size: 18,),
            ),
          ),
          const SizedBox(width: 10,),
        ],
      ),
      body: Stack(
        children: [
          ListView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(25),
            children: [
              const Text("Spotlight", style: TextStyle(fontWeight: FontWeight.w600,fontSize: 24),),
              const SizedBox(height: 15,),
              const Text(
                "Feature your best work, portfolio, or anything you like. Other members use this section to share their creative work, website or NFT collection.",
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: ColorPlate.secondaryLightBG),
              ),
              user == null || user.learner.spotlights.isEmpty? const NoSpotlightState() : Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  children: user.learner.spotlights.map((e) => SpotLightPreview(spotLight: e)).toList(),
                ),
              ),
            ],
          ),
          profile.loading ? const Loading() : const SizedBox()
        ],
      ),
    );
  }
}
