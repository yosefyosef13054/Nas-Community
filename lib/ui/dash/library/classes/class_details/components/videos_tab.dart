import 'package:nas_academy/core/modules/library/class/video.dart';
import 'package:flutter/material.dart';
import 'package:nas_academy/ui/dash/library/classes/class_details/components/video_item_card.dart';

class VideosTab extends StatelessWidget {
  const VideosTab({Key? key, required this.videoClass}) : super(key: key);
  final VideoClass videoClass;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: videoClass.items.map((e) => VideoItemCard(video: e)).toList(),
    );
  }
}
