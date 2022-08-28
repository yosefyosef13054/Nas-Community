class VideoPreview {
  String? id;
  String? objectId;
  String? thumbnail;
  String? topic;
  int? topicIndex;
  int? videoCount;
  bool? isNew;


  VideoPreview(
      {this.id,
      this.objectId,
      this.thumbnail,
      this.topic,
      this.topicIndex,
      this.videoCount,
      this.isNew});


  factory VideoPreview.fromMap (Map<String, dynamic> data){
    return VideoPreview(
      id: data["_id"]?.toString(),
      topicIndex: int.tryParse(data["topicIndex"].toString()),
      topic: data["topic"]?.toString(),
      thumbnail: data["thumbnail"]?.toString(),
      isNew: data["isNew"] == true,
      objectId: data["objectId"]?.toString(),
      videoCount: int.tryParse(data["videoCount"].toString()),
    );
  }

  Map<String, dynamic> toMap (){
    return {
      "_id": id,
      "objectId": objectId,
      "thumbnail": thumbnail,
      "topic": topic,
      "topicIndex": topicIndex,
      "videoCount": videoCount,
      "isNew": isNew
    };
  }
}