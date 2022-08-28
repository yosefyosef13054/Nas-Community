class MediaPlatform {
  String? name;
  String? link;


  MediaPlatform({this.name, this.link});

  factory MediaPlatform.fromMap (Map<String, dynamic> data){
    return MediaPlatform(
      link: data["link"]?.toString().replaceAll(" ", ""),
      name: data["name"]?.toString()
    );
  }

  Map<String, dynamic> toMap (){
    return {
      "name": name,
      "link": link
    };
  }
}