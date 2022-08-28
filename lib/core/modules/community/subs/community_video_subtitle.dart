class VideoSubtitle {
  String? language;
  String? label;
  bool? isDefault;
  String? src;


  VideoSubtitle({this.language, this.label, this.isDefault, this.src});


  factory VideoSubtitle.fromMap (Map<String, dynamic> data){
    return VideoSubtitle(
      isDefault: data["isDefault"] == true,
      src: data["src"]?.toString(),
      label: data["label"]?.toString(),
      language: data["language"]?.toString()
    );
  }

  Map<String, dynamic> toMap (){
    return {
      "language": language,
      "label": label,
      "isDefault": isDefault,
      "src": src,
    };
  }
}