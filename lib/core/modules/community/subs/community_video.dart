
class CommunityVideo {

  int? id;
  String? objectId;
  String? thumbnail;
  String? link;
  String? hlsLink;
  int? duration;
  String? topic;
  int? topicIndex;


  CommunityVideo(
      {this.id,
      this.objectId,
      this.thumbnail,
      this.link,
      this.hlsLink,
      this.duration,
      this.topic,
      this.topicIndex});

  factory CommunityVideo.fromMap (Map<String, dynamic> data){
    return CommunityVideo(
      id: data["_id"],
      topic: data["topic"],
      topicIndex: data["topicIndex"],
      thumbnail: data["thumbnail"],
      duration: data["duration"],
      link: data["link"],
      hlsLink: data["hlsLink"],
      objectId: data["objectId"]
    );
  }

  Map<String, dynamic> toMap (){
    return {
      "_id": id,
      "objectId": objectId,
      "thumbnail": thumbnail,
    "link": link,
      "hlsLink": hlsLink,
      "duration": duration,
      "topic": topic,
      "topicIndex": topicIndex
    };
  }
}