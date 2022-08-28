import '../community/community/meta.dart';
class ImageData{
  String ? src;
  Meta? meta;


  ImageData({this.src, this.meta});

  factory ImageData.fromMap (Map<String, dynamic> data){
    return ImageData(
      meta: data["meta"] != null ? Meta.fromMap(data["meta"]) : null,
      src: data["src"]
    );
  }

  Map<String, dynamic> toMap (){
    return {
      "src": src,
      "meta": meta?.toMap(),
    };
  }
}