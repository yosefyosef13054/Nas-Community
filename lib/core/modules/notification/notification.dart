import 'package:nas_academy/core/modules/notification/notification_data.dart';
import 'package:nas_academy/core/utils/data_types.dart';

class UserNotification {
  String? id;
  bool seen;
  String? status;
  DateTime? sentDate;
  String? userId;
  String? title;
  String? body;
  NotificationType type;
  String? icon;
  String? phase;
  NotificationData? data;



  UserNotification(
      {this.id,
      this.seen = false,
      this.status,
      this.sentDate,
      this.userId,
      this.title,
      this.body,
      this.type = NotificationType.other,
      this.phase,
      this.icon,
      this.data});

  factory UserNotification.fromMap (Map<String, dynamic> data){
    final list = NotificationType.values.where((element) => element.name == data["type"].toString());
    return UserNotification(
      type: list.isNotEmpty? list.first : NotificationType.other,
      body: data["body"]?.toString(),
      title: data["title"]?.toString(),
      id: data["_id"]?.toString(),
      status: data["status"]?.toString(),
      icon: data["icon"]?.toString(),
      phase: data["phase"]?.toString(),
      seen: data["seen"] == true,
      sentDate: DateTime.tryParse(data["sentDate"].toString())?.toLocal(),
      userId: data["userId"]?.toString(),
      data: data["data"] != null ? NotificationData.fromMap(data["data"]) : null
    );
  }

  Map<String, dynamic> toMap (){
    return {
      "_id": id,
      "seen": seen,
      "status": status,
      "sentDate": sentDate.toString(),
      "userId": userId,
      "title": title,
      "body": body,
      "type": type,
      "icon": icon,
      "phase": phase,
      "data": data?.toMap()
    };
  }
}