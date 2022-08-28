import 'package:nas_academy/core/modules/library/resource/resource_item.dart';

class VideoResource {
  String? topic;
  int? topicIndex;
  List<ResourceItem> items;

  VideoResource({this.topic, this.topicIndex, this.items = const []});

  factory VideoResource.fromMap (Map<String, dynamic> data){
    return VideoResource(
      topic: data["topic"],
      items: List.from(data["items"] ?? []).map((e) => ResourceItem.fromMap(e)).toList(),
      topicIndex:   int.tryParse(data["topicIndex"].toString())
     );
  }

  Map<String, dynamic> toMap (){
    return {
      "topic": topic,
      "topicIndex": topicIndex,
      "items": items.map((e) => e.toMap()).toList()
    };
  }
}