
import 'package:nas_academy/core/modules/library/class/video_item.dart';
import 'package:nas_academy/core/modules/library/class/video_preview.dart';
import 'package:nas_academy/core/modules/library/resource/video_resource.dart';

class VideoClass {
  String? id;
  String? topic;
  int? topicIndex;
  List<VideoItem> items;
  VideoPreview? preview;
  VideoResource? resource;


  VideoClass({
    this.id,
    this.topic,
    this.topicIndex,
    this.preview,
    this.resource,
    this.items = const [],
  });


  factory VideoClass.fromMap (Map<String, dynamic> data){
    return VideoClass(
      topic: data["topic"]?.toString(),
      topicIndex: int.tryParse(data["topicIndex"].toString()),
      id: data["_id"]?.toString(),
      items: List.from(data["items"] ?? []).map((e) => VideoItem.fromMap(e)).toList(),
    );
  }

  Map <String, dynamic> toMap (){
    return {
      "_id": id,
      "topic": topic,
      "topicIndex": topicIndex,
      "items": items.map((e) => e.toMap()).toList()
    };
  }
}