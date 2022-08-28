import 'package:nas_academy/core/modules/community/subs/subscription.dart';
import 'package:nas_academy/core/modules/community/active_community/thumb_nail_image.dart';
import 'package:nas_academy/core/utils/data_types.dart';

class Community {
  String? id;
  String? code;
  String? title;
  ApplicationStatusType status;
  ThumbnailImgData? thumbnailImgData;
  List<Subscription> subscriptions;

  Community(
      {this.id,
      this.code,
      this.title,
      this.status = ApplicationStatusType.inactive,
      this.thumbnailImgData,
      this.subscriptions = const []});

  factory Community.fromMap(Map<String, dynamic> data) {
    return Community(
        title: data["title"],
        code: data["code"],
        id: data["_id"],
        subscriptions: List.from(data["subscriptions"] ?? [])
            .map((e) => Subscription.fromMap(e))
            .toList(),
        thumbnailImgData: data["thumbnailImgData"] != null
            ? ThumbnailImgData.fromMap(data["thumbnailImgData"])
            : null);
  }
  Map<String, dynamic> toMap() {
    return {
      "_id": id,
      "code": code,
      "title": title,
      "thumbnailImgData": thumbnailImgData?.toMap(),
      "subscriptions": subscriptions.map((e) => e.toMap()).toList()
    };
  }
}
