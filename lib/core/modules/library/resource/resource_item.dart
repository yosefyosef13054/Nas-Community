class ResourceItem {
  String? id;
  String? type;
  String? link;
  String? thumbnail;
  String? title;
  String? description;
  String? communityObjectId;
  int? topicIndex;
  int? subIndex;
  String? topic;
  DateTime? lastModifiedTimeStamp;
  String? shortUrl;
  String? icon;
  String? emoji;
  DateTime? createdAt;


  ResourceItem(
      {this.id,
      this.type,
      this.link,
      this.thumbnail,
      this.title,
      this.description,
      this.communityObjectId,
      this.topicIndex,
      this.subIndex,
      this.topic,
      this.lastModifiedTimeStamp,
      this.shortUrl,
      this.icon,
      this.emoji,
      this.createdAt});

  factory ResourceItem.fromMap (Map<String, dynamic> data){
    return ResourceItem(
       thumbnail: data["thumbnail"]?.toString(),
      topic: data["topic"]?.toString(),
      id: data["_id"]?.toString(),
      topicIndex: int.tryParse(data["topicIndex"].toString()),
      shortUrl: data["shortUrl"]?.toString(),
      createdAt: DateTime.tryParse(data["createdAt"].toString()),
      title: data["title"]?.toString(),
      type: data["type"]?.toString(),
      icon: data["icon"]?.toString(),
     lastModifiedTimeStamp: DateTime.tryParse(data["lastModifiedTimeStamp"].toString()),
     link: data["link"]?.toString(),
     description: data["description"]?.toString(),
      communityObjectId: data["communityObjectId"]?.toString(),
      emoji: data["emoji"]?.toString(),
      subIndex: int.tryParse(data["subIndex"].toString()),
    );
  }


  Map<String, dynamic> toMap (){
    return {
      "_id": id,
      "type": type,
      "link": link,
      "thumbnail": thumbnail,
      "title": title,
      "description": description,
      "communityObjectId": communityObjectId,
      "topicIndex": topicIndex,
      "subIndex": subIndex,
      "topic": topic,
      "lastModifiedTimeStamp": lastModifiedTimeStamp.toString(),
      "shortUrl": shortUrl,
      "icon": icon,
      "emoji": emoji,
      "createdAt": createdAt.toString()
    };
  }
}