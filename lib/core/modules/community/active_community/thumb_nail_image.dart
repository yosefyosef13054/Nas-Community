import 'package:nas_academy/core/modules/common/image_data.dart';

class ThumbnailImgData {
  String? alt;
  ImageData? mobileImageData;


  ThumbnailImgData({this.alt, this.mobileImageData});

  factory ThumbnailImgData.fromMap (Map<String, dynamic> data){
    return ThumbnailImgData(
      alt: data["alt"],
      mobileImageData: data["mobileImgData"] != null? ImageData.fromMap(data["mobileImgData"]) : null
    );
  }

  Map<String, dynamic> toMap (){
    return {
      "alt": alt,
      "mobileImgData": mobileImageData?.toMap()
    };
  }
}