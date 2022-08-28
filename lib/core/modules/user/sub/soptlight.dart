class SpotLight {
  String? link;
  String? thumbnail;
  String? title;
  String? description;
  SpotLight({this.link, this.description, this.title, this.thumbnail});


  factory SpotLight.fromMap(Map<String, dynamic> data) {
    return SpotLight(
      link: data["link"]?.toString(),
      title: data["title"]?.toString(),
      thumbnail: data["thumbnail"]?.toString(),
      description: data["description"]?.toString(),
    );
  }

  Map<String, dynamic> toMap (){
    return {
      "link" : link ?? "",
      "title" : title ?? "",
      "thumbnail" : thumbnail ?? "",
      "description" : description ?? ""
    };
  }
}