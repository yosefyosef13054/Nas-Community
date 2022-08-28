import 'package:flutter/material.dart';
import 'package:nas_academy/core/modules/common/card_image_data.dart';
import 'package:nas_academy/core/modules/common/host.dart';
import 'package:nas_academy/core/modules/live_session/main_live_sessions.dart';
import 'package:nas_academy/core/utils/color_plate.dart';
import 'package:nas_academy/core/utils/time_formatter.dart';

class UpcomingEvent {
  String? title;
  String? description;
  String? status;
  List<String> communities;
  String? id;
  DateTime? startTime;
  DateTime? endTime;
  String? liveLink;
  String? recordingLink;
  bool? isActive;
  String? type;
  DateTime? createdAt;
  DateTime? lastModifiedTimeStamp;
  int? eventId;
  int? v;
  int? attendees;
  List<String> profileImages;
  CardImageData? cardImgData;
  bool? registered;
  Host? host;

  UpcomingEvent(
      {this.title,
      this.description,
      this.status,
      this.communities = const [],
      this.id,
      this.startTime,
      this.endTime,
      this.liveLink,
      this.recordingLink,
      this.isActive,
      this.type,
      this.createdAt,
      this.lastModifiedTimeStamp,
      this.eventId,
      this.v,
      this.attendees,
      this.profileImages = const [],
      this.cardImgData,
      this.registered,
      this.host});

  factory UpcomingEvent.fromMap(Map<String, dynamic> data) {
    return UpcomingEvent(
        description: data["description"],
        id: data["id"] ?? data["_id"],
        title: data["title"],
        status: data["status"],
        createdAt: DateTime.tryParse(data["createdAt"].toString()),
        type: data["type"],
        attendees: data["attendees"],
        cardImgData: data["cardImgData"] != null
            ? CardImageData.fromMap(data["cardImgData"])
            : null,
        communities: List.from(data["communities"] ?? [])
            .map((e) => e.toString())
            .toList(),
        endTime: DateTime.tryParse(data["endTime"]),
        eventId: data["eventId"],
        host: data["host"] != null ? Host.fromMap(data["host"]) : null,
        isActive: data["isActive"] == true,
        lastModifiedTimeStamp: DateTime.tryParse(data["lastModifiedTimeStamp"]),
        liveLink: data["liveLink"],
        profileImages: List.from(data["profileImages"] ?? [])
            .map((e) => e.toString())
            .toList(),
        recordingLink: data["recordingLink"],
        registered: data["registered"] == true,
        startTime: DateTime.tryParse(data["startTime"]),
        v: data["__v"]);
  }

  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "description": description,
      "status": status,
      "communities": communities.map((e) => e.toString()).toList(),
      "_id": id,
      "startTime": startTime.toString(),
      "endTime": endTime.toString(),
      "liveLink": liveLink,
      "recordingLink": recordingLink,
      "isActive": isActive == true,
      "type": type,
      "createdAt": createdAt.toString(),
      "lastModifiedTimeStamp": lastModifiedTimeStamp.toString(),
      "eventId": eventId,
      "__v": v,
      "attendees": attendees,
      "profileImages": profileImages.map((e) => e.toString()).toList(),
      "registered": registered == true,
      "cardImgData": cardImgData?.toMap(),
      "host": host?.toMap(),
    };
  }

  Widget dateToString() {
    if (startTime != null && endTime != null) {
      if (startTime!.isBefore(DateTime.now()) &&
          endTime!.isAfter(DateTime.now())) {
        return Row(
          children: [
            Container(
              height: 8,
              width: 8,
              decoration: BoxDecoration(
                  color: Colors.red, borderRadius: BorderRadius.circular(30)),
            ),
            const SizedBox(
              width: 8,
            ),
            const Text(
              'Happening now',
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: Colors.orange),
            ),
            Text(
              ', ${endTime!.day} ${monthAsString(endTime!.month)}',
              style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: ColorPlate.primaryLightBG),
            ),
          ],
        );
      } else {
        return Text(
          '${endTime!.day} ${monthAsString(endTime!.month)}',
          style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: ColorPlate.primaryLightBG),
        );
      }
    } else {
      return const Text(
        "Error getting event timeline",
        style: TextStyle(fontSize: 12, color: Colors.red),
      );
    }
  }

  Widget timeToString() {
    if (startTime != null && endTime != null) {
      return Text(
          "${TimeFormatter.timeInTwelveSys(startTime!.toLocal())} - ${TimeFormatter.timeInTwelveSys(endTime!.toLocal())}");
    } else {
      return const Text(
        "Error getting event timeline",
        style: TextStyle(fontSize: 12, color: Colors.red),
      );
    }
  }

  Session session() {
    return Session(
        id: id,
        title: title,
        description: description,
        startTime: startTime,
        endTime: endTime,
        cardImgData: cardImgData,
        liveLink: liveLink,
        recordingLink: recordingLink,
        isActive: isActive == true,
        status: status,
        type: type,
        communities: communities,
        host: host ?? Host(),
        createdAt: createdAt,
        lastModifiedTimeStamp: lastModifiedTimeStamp,
        eventId: eventId,
        v: v,
        attendees: attendees,
        profileImages: profileImages,
        resources: [],
        registered: registered,
        shortUrl: "shortUrl");
  }
}

String monthAsString(int month) {
  switch (month) {
    case 1:
      return "Jan";
    case 2:
      return "Feb";
    case 3:
      return "Mar";
    case 4:
      return "Apr";
    case 5:
      return "May";
    case 6:
      return "Jun";
    case 7:
      return "Jul";
    case 8:
      return "Aug";
    case 9:
      return "Sep";
    case 10:
      return "Oct";
    case 11:
      return "Nov";
    case 12:
      return "Dec";
    default:
      return "";
  }
}
