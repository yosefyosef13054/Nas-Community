import 'package:nas_academy/core/modules/community/subs/community_video_subtitle.dart';

class CommunityVideoItem {
  String? id;
  int? topicIndex;
  String? topic;
  String? title;
  String? shortUrl;
  String? link;
  String? hlsLink;
  String? thumbnail;
  int? duration;
  List<VideoSubtitle> subtitles;


  CommunityVideoItem(
      {this.id,
      this.topicIndex,
      this.topic,
      this.title,
      this.shortUrl,
      this.link,
      this.hlsLink,
      this.thumbnail,
      this.duration,
      this.subtitles = const []});


  factory CommunityVideoItem.fromMap (Map<String, dynamic> data){
    return CommunityVideoItem(
      id: data["_id"].toString(),
      title: data["title"],
      link: data["link"],
      duration: data["duration"],
      hlsLink: data["hlsLink"],
      shortUrl: data["shortUrl"],
      subtitles: List.from(data["subtitles"] ?? []).map((e) => VideoSubtitle.fromMap(e)).toList(),
      thumbnail: data["thumbnail"],
      topic: data["topic"],
      topicIndex: data["topicIndex"],
    );
  }

  Map<String, dynamic> toMap (){
    return {
      "_id": id,
      "topicIndex": topicIndex,
      "topic": topic,
      "title": title,
      "shortUrl": shortUrl,
      "link": link,
      "hlsLink": hlsLink,
      "thumbnail": thumbnail,
      "duration": duration,
      "subtitles": subtitles.map((e) => e.toMap()).toList()
    };
  }
}