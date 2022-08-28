import "package:flutter/material.dart";
import 'package:nas_academy/core/modules/library/class/video.dart';
import 'package:nas_academy/ui/dash/library/resources/resource_details/components/resource_item_card.dart';



class VideoResourcesTab extends StatelessWidget {
  const VideoResourcesTab({Key? key, required this.videoClass}) : super(key: key);
  final VideoClass videoClass;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: (videoClass.resource!.items).map((e) => ResourceItemCard(item: e, color: Colors.white,)).toList(),
    );
  }
}
