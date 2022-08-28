import 'package:nas_academy/core/modules/common/image_data.dart';

class CardImageData {
  String? alt;
  ImageData? mobileImgData;
  ImageData? desktopImgData;


  CardImageData({this.alt, this.mobileImgData, this.desktopImgData});

  factory CardImageData.fromMap (Map<String, dynamic> data){
    return CardImageData(
      alt: data["alt"],
      mobileImgData: data["mobileImgData"] != null? ImageData.fromMap(data["mobileImgData"]) : null,
      desktopImgData: data["desktopImgData"] != null? ImageData.fromMap(data["desktopImgData"]) : null,
    );
  }

  Map<String, dynamic> toMap (){
    return {
      "alt": alt,
      "mobileImgData": mobileImgData?.toMap(),
      "desktopImgData": desktopImgData?.toMap()
    };
  }
}