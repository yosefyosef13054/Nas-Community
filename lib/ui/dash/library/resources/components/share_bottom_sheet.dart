import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nas_academy/core/services/share.dart';
import 'package:nas_academy/core/utils/color_plate.dart';

class ShareBottomSheet extends StatelessWidget {
  const ShareBottomSheet({Key? key, required this.link, this.title, }) : super(key: key);
  final String link;
  final String? title;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28),
        ),
        child: Material(
          color: ColorPlate.neutral100,
          child: SafeArea(
            top: false,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 32,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      height: 45,
                      width: double.infinity,
                      child: OutlinedButton(

                        style: ButtonStyle(
                            side: MaterialStateProperty.all(const BorderSide(width: 1.0, color: ColorPlate.secondaryLightBG)),
                            shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(48)))
                        ),
                        onPressed: (){
                          ShareHandler.shareLink(link: link, title: title);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              "assets/svg/Share.svg",
                            ),
                            const Text(
                              'Share',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: ColorPlate.primaryLightBG),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Center(
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: ColorPlate.primaryLightBG),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 55,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
