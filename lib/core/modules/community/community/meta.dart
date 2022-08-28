class Meta {
  double? width;
  double? height;

  Meta({this.width, this.height});

  factory Meta.fromMap (Map<String, dynamic> data){
    return Meta(width: double.tryParse(data['width'].toString()), height: double.tryParse(data["height"].toString()));
  }

  Map<String, dynamic> toMap  (){
    return {
      "width" : width,
      "height" : height
    };
  }
}