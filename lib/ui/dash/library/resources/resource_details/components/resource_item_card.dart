import "package:flutter/material.dart";
import 'package:flutter_svg/svg.dart';
import 'package:line_icons/line_icons.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:nas_academy/core/helpers/helper_functions.dart';
import 'package:nas_academy/core/modules/library/resource/resource_item.dart';
import 'package:nas_academy/core/utils/color_plate.dart';
import 'package:nas_academy/ui/dash/library/resources/components/share_bottom_sheet.dart';
import 'package:url_launcher/url_launcher.dart';

class ResourceItemCard extends StatelessWidget {
  const ResourceItemCard({Key? key, required this.item, required this.color})
      : super(key: key);
  final ResourceItem item;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(20)),
      margin: const EdgeInsets.symmetric(vertical: 12),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      width: double.infinity,
      child: InkWell(
        onTap: () async {
          await launchUrl(Uri.parse(item.link!));
        },
        child: Stack(
          children: [
            Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Expanded(
                flex: 3,
                child: Center(
                  child: SvgPicture.network(
                    item.icon.toString(),
                    height: 64,
                    width: 64,
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                flex: 8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      getItemTypeText(),
                      style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: ColorPlate.secondaryLightBG),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      item.title.toString(),
                      maxLines: 2,
                      overflow: TextOverflow.visible,
                      softWrap: true,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: ColorPlate.primaryLightBG),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .55,
                      child: Text(
                        item.description.toString(),
                        maxLines: 3,
                        style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: ColorPlate.secondaryLightBG),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              const Expanded(
                flex: 1,
                child: SizedBox(),
              )
            ]),
            Positioned(
              top: 0,
              right: -10,
              child: InkWell(
                  onTap: () {
                    showBarModalBottomSheet(
                      expand: false,
                      context: context,
                      duration: const Duration(milliseconds: 300),
                      animationCurve: Curves.easeInOut,
                      backgroundColor: Colors.transparent,
                      builder: (ctx) {
                        return ShareBottomSheet(
                          link: item.shortUrl!,
                          title: item.topic,
                        );
                      },
                    );
                  },
                  child: const Icon(
                    LineIcons.verticalEllipsis,
                    color: ColorPlate.tertiaryLightBG,
                    size: 28,
                  )),
            ),
          ],
        ),
      ),
    );
  }

  String getItemTypeText() {
    if (item.type.toString() == 'external_link') {
      var restRegExp = RegExp(r'[a-zA-Z]');
      if (item.link != null &&
          item.link!.startsWith(restRegExp) &&
          Uri.parse(item.link!).isAbsolute) {
        return getHostFromUrl(item.link!);
      } else {
        return "External Link";
      }
    } else {
      return item.type.toString();
    }
  }
}
