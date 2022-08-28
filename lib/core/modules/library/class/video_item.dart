import 'package:nas_academy/core/modules/community/subs/community_video_subtitle.dart';

class VideoItem {

  String? id;
  int? topicIndex;
  int? subIndex;
  String? topic;
  String? title;
  String? shortUrl;
  DateTime? createdAt;
  String? link;
  String? hlsLink;
  String? thumbnail;
  int? duration;
  List<VideoSubtitle> subtitles;


  VideoItem(
      {this.id,
      this.topicIndex,
      this.subIndex,
      this.topic,
      this.title,
      this.shortUrl,
      this.createdAt,
      this.link,
      this.hlsLink,
      this.thumbnail,
      this.duration,
      this.subtitles = const []});


  factory VideoItem.fromMap (Map<String, dynamic> data){
    return VideoItem(
      title: data["title"]?.toString(),
      id: data["_id"]?.toString(),
      link: data["link"]?.toString(),
      createdAt: DateTime.tryParse(data["createdAt"].toString()),
      topicIndex: int.tryParse(data["topicIndex"].toString()),
      topic: data["topic"]?.toString(),
      thumbnail: data["thumbnail"]?.toString(),
      subtitles: List.from(data["subtitles"]?? []).map((e) => VideoSubtitle.fromMap(e)).toList(),
      shortUrl: data["shortUrl"]?.toString(),
      duration: int.tryParse(data["duration"].toString()),
      hlsLink: data["hlsLink"]?.toString(),
      subIndex: int.tryParse(data["subIndex"].toString()),
    );
  }

  Map<String, dynamic> toMap (){
    return {
      "_id": id,
      "topicIndex": topicIndex,
      "subIndex": subIndex,
      "topic": topic,
      "title": title,
      "shortUrl": shortUrl,
      "createdAt": createdAt.toString(),
      "link": link,
      "hlsLink": hlsLink,
      "thumbnail": thumbnail,
      "duration": duration,
      "subtitles": subtitles.map((e) => e.toMap()).toList()
    };
  }
}