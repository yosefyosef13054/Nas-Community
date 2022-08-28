class ResourcePreview {
  String? topic;
  int? topicIndex;
  String? emoji;
  int? resourceCount;
  bool? isNew;


  ResourcePreview(
      {this.topic,
      this.topicIndex,
      this.emoji,
      this.resourceCount,
      this.isNew});


  factory ResourcePreview.fromMap (Map<String, dynamic> data){
    return ResourcePreview(
      topic: data["topic"]?.toString(),
      isNew: data["isNew"] == true,
      topicIndex: int.tryParse(data["topicIndex"].toString()),
      emoji: data["emoji"]?.toString(),
      resourceCount: int.tryParse(data["resourceCount"].toString()),
    );
  }

  Map<String, dynamic> toMap (){
    return {
      "topic": topic,
      "topicIndex": topicIndex,
      "emoji": emoji,
      "resourceCount": resourceCount,
      "isNew": isNew
    };
  }
}