import 'package:flutter_svg/svg.dart';
import 'package:nas_academy/core/modules/library/class/video.dart';
import "package:flutter/material.dart";
import 'package:nas_academy/core/utils/color_plate.dart';

class VideoClassDetailsHeader extends StatelessWidget {
  const VideoClassDetailsHeader({Key? key, required this.videoClass})
      : super(key: key);
  final VideoClass videoClass;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            videoClass.topic ?? "",
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 15,),
          Row(
            children: [
              Container(
                height: 24,
                margin: const EdgeInsets.symmetric(horizontal: 5),
                padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 7),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: ColorPlate.dark50,
                ),
                child: const Text("Script writing", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12, color: Colors.white),),
              ),
              Container(
                height: 24,
                margin: const EdgeInsets.symmetric(horizontal: 5),
                padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 7),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: ColorPlate.dark50,
                ),
                child: const Text("Editing", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12, color: Colors.white),),
              ),
              Visibility(
                visible: videoClass.items.isNotEmpty == true,
                child: Container(
                  height: 24,
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 7),
                  decoration: BoxDecoration(
                    border: Border.all(color: ColorPlate.secondaryLightBG),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    children: [
                      Text(
                        "${videoClass.items.length}",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: ColorPlate.dark50),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      SvgPicture.asset(
                        "assets/svg/video_lib.svg",
                        color: ColorPlate.dark50,
                      ),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: videoClass.resource?.items.isNotEmpty == true,
                child: Container(
                  height: 24,
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 7),
                  decoration: BoxDecoration(
                    border: Border.all(color: ColorPlate.secondaryLightBG),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    children: [
                      Text(
                        "${videoClass.resource?.items.length}",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: ColorPlate.dark50),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      SvgPicture.asset(
                        "assets/svg/collections_bookmark.svg",
                        color: ColorPlate.dark50,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          Visibility(
            visible: false,
            child: Container(
              margin: const EdgeInsets.only(top: 25, bottom: 10),
              child: Text(
                "Description on why this is helpful for a content creator. : ${videoClass.id}",
                style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
              ),
            ),
          ),
          const SizedBox(height: 20,),
        ],
      ),
    );
  }
}
