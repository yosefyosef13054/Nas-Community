import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:nas_academy/core/modules/library/resource/resource_preview.dart';
import 'package:nas_academy/core/providers/dash/dash_provider.dart';
import 'package:nas_academy/core/services/navigator.dart';
import 'package:nas_academy/core/utils/color_plate.dart';
import 'package:nas_academy/ui/dash/library/classes/components/new_badge.dart';
import 'package:nas_academy/ui/dash/library/resources/resource_details/resource_details_screen.dart';
import 'package:provider/provider.dart';

class ResourceCard extends StatelessWidget {
  const ResourceCard({Key? key,required this.preview}) : super(key: key);
  final ResourcePreview preview;
  @override
  Widget build(BuildContext context) {
    final dash = Provider.of<DashProvider>(context);
    return InkWell(
      onTap: ()=> Navigate.push(context,  ResourceDetailsScreen(
        resource: dash.libraryResources.firstWhere((element) => element.topicIndex == preview.topicIndex),
      )),
      child: Container(
        height: 175,
        padding: const EdgeInsets.all(16),
        width: (MediaQuery.of(context).size.width - 60) / 2,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: ColorPlate.neutral95
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(preview.emoji ?? "", style: const TextStyle(fontSize: 25),),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: LibraryNewBadge(visible: preview.isNew == true),
                    ),
                  ],
                ),
                const Icon(LineIcons.verticalEllipsis, color: ColorPlate.tertiaryLightBG, size: 28,),
              ],
            ),
            Text(
              preview.topic ?? "",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),),
          ],
        ),
      ),
    );
  }
}
