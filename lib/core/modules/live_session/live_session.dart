import 'package:nas_academy/core/modules/common/card_image_data.dart';
import 'package:nas_academy/core/modules/common/host.dart';

class LiveSession {
  bool? startOfList;
  String? title;
  String? description;
  bool? status;
  List<String> communities;
  String? id;
  String? eventId;
  DateTime? startTime;
  DateTime? endTime;
  String? liveLink;
  String? recordingLink;
  bool? isActive;
  String? type;
  Host? host;
  DateTime? lastModifiedTimeStamp;
  int? attendees;
  bool? registered;
  CardImageData? cardImgData;


  LiveSession(
      {this.startOfList,
      this.title,
      this.description,
      this.status,
      this.communities = const [],
      this.id,
      this.eventId,
      this.startTime,
      this.endTime,
      this.liveLink,
      this.recordingLink,
      this.isActive,
      this.type,
      this.host,
      this.lastModifiedTimeStamp,
      this.attendees,
      this.registered,
      this.cardImgData});

  factory LiveSession.fromMap (Map<String, dynamic> data){
    return LiveSession(
      id: (data["_id"] ?? data["id"]).toString(),
      startTime: DateTime.tryParse(data["startTime"].toString()),
      recordingLink: data["recordingLink"],
      liveLink: data["liveLink"],
      isActive: data["isActive"] == true,
      eventId: data["eventId"],
      endTime: DateTime.tryParse(data["endTime"]),
      communities: List.from(data["communities"] ?? []).map((e) => e.toString()).toList(),
      type: data["type"].toString(),
      status: data["status"] == true,
      title: data["title"],
      description: data["description"],
      startOfList: data["startOfList"] == true,
      registered: data["registered"] == true,
      lastModifiedTimeStamp: DateTime.tryParse(data["lastModifiedTimeStamp"].toString()),
      host: data["host"] != null ? Host.fromMap(data["host"]) : null,
      cardImgData: data["cardImgData"] != null? CardImageData.fromMap(data["cardImgData"]) : null,
      attendees: data["attendees"]
    );
  }

  Map<String, dynamic> toMap (){
    return {
      "startOfList": startOfList,
      "title": title,
      "description":description,
      "status": status,
      "communities":communities,
      "_id": id,
      "eventId": eventId,
      "startTime": startTime.toString(),
      "endTime": endTime.toString(),
      "liveLink": liveLink,
      "recordingLink": recordingLink,
      "isActive": isActive,
      "type": type,
      "host": host?.toMap(),
      "lastModifiedTimeStamp": lastModifiedTimeStamp.toString(),
      "attendees": attendees,
      "id": id,
      "registered": registered,
      "cardImgData": cardImgData?.toMap(),
    };
  }
}