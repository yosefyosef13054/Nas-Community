import 'package:any_link_preview/any_link_preview.dart';
import "package:flutter/material.dart";
import 'package:flutter_svg/svg.dart';
import 'package:line_icons/line_icons.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:nas_academy/core/modules/user/sub/soptlight.dart';
import 'package:nas_academy/core/modules/user/user.dart';
import 'package:nas_academy/core/providers/dash/profile_provider.dart';
import 'package:nas_academy/core/services/navigator.dart';
import 'package:nas_academy/core/utils/assets.dart';
import 'package:nas_academy/core/utils/color_plate.dart';
import 'package:nas_academy/ui/dash/members/member_details_screen/components/spotlight.dart';
import 'package:nas_academy/ui/dash/user_profile/edit_profile/edit_spotlight/components/delete_spotlight_bottomsheet.dart';
import 'package:nas_academy/ui/dash/user_profile/edit_profile/edit_spotlight/components/edit_spotlight.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class SpotLightPreview extends StatelessWidget {
  const SpotLightPreview({Key? key, required this.spotLight}) : super(key: key);
  final SpotLight spotLight;

  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<ProfileProvider>(context);
    final user = Provider.of<User?>(context);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: FutureBuilder<Metadata?>(
        future: getLinkMetaData(spotLight.link!).timeout(const Duration(seconds: 3)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if(snapshot.hasData && snapshot.data != null){
              Metadata meta = snapshot.data!;
              String host = Uri.parse(meta.url ?? "").host;
              return Column(
                children: [
                  Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25)),
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25)),
                      child: Image.network(
                        spotLight.thumbnail ?? meta.image ?? "",
                        fit: BoxFit.cover,
                        errorBuilder: (context, child, error) {
                          return Container(
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(25),
                                    topRight: Radius.circular(25)),
                                color: ColorPlate.neutral80),
                            child: const Center(
                              child: Icon(
                                LineIcons.image,
                                size: 80,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Container(
                    padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(25),
                            bottomRight: Radius.circular(25)),
                        color: ColorPlate.neutral95),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "${spotLight.title ?? meta.title}",
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          host.replaceAll("www.", ""),
                          style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: ColorPlate.secondaryLightBG),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          "${spotLight.description ?? meta.desc}",
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            OutlinedButton.icon(
                                style: ButtonStyle(
                                    foregroundColor:
                                    MaterialStateProperty.all(Colors.black),
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(100))),
                                    side: MaterialStateProperty.all(
                                        const BorderSide(
                                            color: ColorPlate.secondaryLightBG))),
                                onPressed: () {
                                  Navigate.push(context, EditSpotLightFields(spotlight : spotLight, data: meta,));
                                },
                                icon: SvgPicture.asset(
                                  Assets.edit,
                                  height: 18,
                                  width: 18,
                                  color: Colors.black,
                                ),
                                label: const Text("Edit")),
                            const SizedBox(width: 15,),
                            OutlinedButton.icon(
                                style: ButtonStyle(
                                    foregroundColor:
                                    MaterialStateProperty.all(Colors.black),
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(100))),
                                    side: MaterialStateProperty.all(
                                        const BorderSide(
                                            color: ColorPlate.secondaryLightBG))),
                                onPressed: () {
                                  showBarModalBottomSheet(
                                    context: context,
                                    builder: (context){
                                      return  DeleteSpotlightBottomSheet(spotLight: spotLight,);
                                    }
                                  );
                                },
                                icon: SvgPicture.asset(
                                  Assets.delete,
                                  height: 15,
                                  width: 15,
                                  color: Colors.black,
                                ),
                                label: const Text("Delete")),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              );
            }else {
             return Container(
               width: MediaQuery.of(context).size.width,
               height: 300,
               decoration: BoxDecoration(
                 color: ColorPlate.neutral95,
                 borderRadius: BorderRadius.circular(30),
               ),
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   const SizedBox(),
                   Center(
                     child: Column(
                       mainAxisSize: MainAxisSize.min,
                       children: const [
                         Icon(
                           LineIcons.exclamationCircle,
                           size: 40,
                           color: ColorPlate.secondaryLightBG,
                         ),
                         SizedBox(
                           height: 20,
                         ),
                         Text(
                           "Unable to view link meta data",
                           style: TextStyle(
                               fontWeight: FontWeight.w600,
                               fontSize: 14,
                               color: ColorPlate.secondaryLightBG),
                         ),
                         SizedBox(
                           height: 20,
                         ),
                       ],
                     ),
                   ),
                   Padding(
                     padding: const EdgeInsets.all(20.0),
                     child: Row(
                       children: [
                         OutlinedButton.icon(
                             style: ButtonStyle(
                                 foregroundColor:
                                 MaterialStateProperty.all(Colors.black),
                                 shape: MaterialStateProperty.all(
                                     RoundedRectangleBorder(
                                         borderRadius:
                                         BorderRadius.circular(100))),
                                 side: MaterialStateProperty.all(
                                     const BorderSide(
                                         color: ColorPlate.secondaryLightBG))),
                             onPressed: () {
                               Navigate.push(context, EditSpotLightFields(spotlight : spotLight, data: null,));
                             },
                             icon: SvgPicture.asset(
                               Assets.edit,
                               height: 18,
                               width: 18,
                               color: Colors.black,
                             ),
                             label: const Text("Edit")),
                         const SizedBox(width: 15,),
                         OutlinedButton.icon(
                             style: ButtonStyle(
                                 foregroundColor:
                                 MaterialStateProperty.all(Colors.black),
                                 shape: MaterialStateProperty.all(
                                     RoundedRectangleBorder(
                                         borderRadius:
                                         BorderRadius.circular(100))),
                                 side: MaterialStateProperty.all(
                                     const BorderSide(
                                         color: ColorPlate.secondaryLightBG))),
                             onPressed: () {
                               if(user != null){
                                 user.learner.spotlights.removeWhere((element) => element.link == spotLight.link);
                                 profile.notify();
                               }
                             },
                             icon: SvgPicture.asset(
                               Assets.delete,
                               height: 15,
                               width: 15,
                               color: Colors.black,
                             ),
                             label: const Text("Delete")),
                       ],
                     ),
                   )
                 ],
               ),
             );
            }
          } else if (snapshot.hasError) {
            return Container(
              width: MediaQuery.of(context).size.width,
              height: 300,
              decoration: BoxDecoration(
                color: ColorPlate.neutral95,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(
                      LineIcons.exclamationCircle,
                      size: 40,
                      color: ColorPlate.secondaryLightBG,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Unable to view link meta data",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: ColorPlate.secondaryLightBG),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.white,
              child: Container(
                height: 300,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(30),
                ),
                width: MediaQuery.of(context).size.width,
              ),
            );
          }
        },
      ),
    );
  }
}
