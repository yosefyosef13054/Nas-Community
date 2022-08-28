import 'package:nas_academy/core/utils/data_types.dart';

class SocialMedia {
  String? iconLink;
  String? link;
  String? type;


  SocialMedia({this.iconLink, this.link, this.type});

  factory SocialMedia.fromMap (Map<String, dynamic> data){
    return SocialMedia(
      iconLink: data["iconLink"],
      link: data["link"],
      type: data["type"]
    );
  }

  Map<String, dynamic> toMap  (){
    return {
      "iconLink": iconLink,
      "link": link,
      "type": type
    };
  }

  String activeIcon (){
    return socialMediaActiveIcon(SocialMediaTypes.values.where((element) => element.name.toLowerCase() == type!.toLowerCase()).first);
  }


  String inactiveIcon (){
    final list = SocialMediaTypes.values.where((element) => element.name.toLowerCase() == type!.toLowerCase()).toList();
    if(list.isNotEmpty){
      return socialMediaInActiveIcon(list.first);
    }else {
      return socialMediaInActiveIcon(SocialMediaTypes.other);
    }
  }
}