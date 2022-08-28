// To parse this JSON data, do
//
//     final mainLiveSessions = mainLiveSessionsFromJson(jsonString);

import 'dart:convert';

import 'package:nas_academy/core/modules/common/host.dart';
import 'package:nas_academy/core/modules/common/card_image_data.dart';

MainLiveSessions mainLiveSessionsFromJson(String str) =>
    MainLiveSessions.fromJson(json.decode(str));

class MainLiveSessions {
  MainLiveSessions({
    required this.upcoming,
    required this.past,
    required this.attending,
  });

  List<Attending> upcoming;
  List<Attending> past;
  List<Attending> attending;

  factory MainLiveSessions.fromJson(Map<String, dynamic> json) =>
      MainLiveSessions(
        upcoming: List<Attending>.from(
            json["upcoming"].map((x) => Attending.fromJson(x)) ?? []),
        past: List<Attending>.from(
            json["past"].map((x) => Attending.fromJson(x)) ?? []),
        attending: List<Attending>.from(
            json["attending"].map((x) => Attending.fromJson(x)) ?? []),
      );
}

class Attending {
  Attending({
    required this.title,
    required this.sessions,
  });

  String? title;
  List<Session>? sessions;

  factory Attending.fromJson(Map<String, dynamic> json) => Attending(
        title: json["title"],
        sessions: List.from(json["sessions"] ?? [])
            .map((e) => Session.fromJson(e))
            .toList(),
      );
}

class Session {
  Session({
    required this.id,
    required this.title,
    required this.description,
    required this.startTime,
    required this.endTime,
    required this.cardImgData,
    required this.liveLink,
    required this.recordingLink,
    required this.isActive,
    required this.status,
    required this.type,
    required this.communities,
    required this.host,
    required this.createdAt,
    required this.lastModifiedTimeStamp,
    required this.eventId,
    required this.v,
    required this.attendees,
    required this.profileImages,
    required this.resources,
    required this.registered,
    required this.shortUrl,
  });

  String? id;
  String? title;
  String? description;
  DateTime? startTime;
  DateTime? endTime;
  CardImageData? cardImgData;
  String? liveLink;
  String? recordingLink;
  bool? isActive;
  String? status;
  String? type;
  List<String>? communities;
  Host host;
  DateTime? createdAt;
  DateTime? lastModifiedTimeStamp;
  int? eventId;
  int? v;
  int? attendees;
  List<String>? profileImages;
  List<Resource>? resources;
  bool? registered;
  String? shortUrl;

  factory Session.fromJson(Map<String, dynamic> json) => Session(
        id: json["_id"],
        title: json["title"],
        description: json["description"],
        startTime: DateTime.tryParse(json["startTime"].toString())?.toLocal(),
        endTime: DateTime.tryParse(json["endTime"].toString())?.toLocal(),
        cardImgData: json["cardImgData"] == null
            ? null
            : CardImageData.fromMap(json["cardImgData"]),
        // startTime: DateTime.tryParse(json["startTime"].toString()),
        // endTime: DateTime.tryParse(json["endTime"].toString()),
        // cardImgData: json["cardImgData"] == null ? null : CardImageData.fromMap(json["cardImgData"]),
        liveLink: json["liveLink"],
        recordingLink: json["recordingLink"],
        isActive: json["isActive"],
        status: json["status"],
        type: json["type"],
        communities: List<String>.from(json["communities"].map((x) => x) ?? []),
        host: json["host"] == null ? Host() : Host.fromMap(json["host"]),
        createdAt: DateTime.tryParse(json["createdAt"].toString())?.toLocal(),
        lastModifiedTimeStamp:
            DateTime.tryParse(json["lastModifiedTimeStamp"].toString())
                ?.toLocal(),
        eventId: json["eventId"],
        v: json["__v"],
        attendees: json["attendees"],
        profileImages:
            List<String>.from(json["profileImages"].map((x) => x) ?? []),
        resources: json["resources"] == null
            ? null
            : List.from(json["resources"] ?? [])
                .map((e) => Resource.fromJson(e))
                .toList(),
        registered: json["registered"],
        shortUrl: json["shortUrl"],
      );
}

class Resource {
  Resource({
    required this.title,
    required this.description,
    required this.type,
    required this.objectId,
    required this.object,
  });

  String? title;
  String? description;
  String? type;
  String? objectId;
  Object? object;

  factory Resource.fromJson(Map<String, dynamic> json) => Resource(
        title: json["title"],
        description: json["description"],
        type: json["type"],
        objectId: json["objectId"],
        object: json["object"] == null ? null : Object.fromJson(json["object"]),
      );
}

class Object {
  Object({
    required this.id,
    required this.title,
    required this.description,
    required this.startTime,
    required this.endTime,
    required this.cardImgData,
    required this.liveLink,
    required this.recordingLink,
    required this.isActive,
    required this.status,
    required this.type,
    required this.communities,
    required this.host,
    required this.createdAt,
    required this.lastModifiedTimeStamp,
    required this.eventId,
    required this.v,
    required this.video,
    required this.communityObjectId,
    required this.topicIndex,
    required this.subIndex,
    required this.topic,
    required this.shortUrl,
    required this.link,
    required this.thumbnail,
    required this.tag,
  });

  String? id;
  String? title;
  String? description;
  dynamic startTime;
  dynamic endTime;
  CardImageData? cardImgData;
  String? liveLink;
  String? recordingLink;
  bool? isActive;
  String? status;
  String? type;
  List<String>? communities;
  Host? host;
  dynamic createdAt;
  dynamic lastModifiedTimeStamp;
  int? eventId;
  int? v;
  String? video;
  String? communityObjectId;
  int? topicIndex;
  int? subIndex;
  String? topic;
  String? shortUrl;
  String? link;
  String? thumbnail;
  String? tag;

  factory Object.fromJson(Map<String, dynamic> json) => Object(
        id: json["_id"],
        title: json["title"],
        description: json["description"],
        startTime: json["startTime"].toString(),
        endTime: json["endTime"].toString(),
        cardImgData: json["cardImgData"] == null
            ? null
            : CardImageData.fromMap(json["cardImgData"]),
        liveLink: json["liveLink"],
        recordingLink: json["recordingLink"],
        isActive: json["isActive"],
        status: json["status"],
        type: json["type"],
        communities: json["communities"] == null
            ? null
            : List<String>.from(json["communities"].map((x) => x) ?? []),
        host: json["host"] == null ? null : Host.fromMap(json["host"]),
        createdAt: json["createdAt"].toString(),
        lastModifiedTimeStamp: json["lastModifiedTimeStamp"].toString(),
        eventId: json["eventId"],
        v: json["__v"],
        video: json["video"],
        communityObjectId: json["communityObjectId"],
        topicIndex: json["topicIndex"],
        subIndex: json["subIndex"],
        topic: json["topic"],
        shortUrl: json["shortUrl"],
        link: json["link"],
        thumbnail: json["thumbnail"],
        tag: json["tag"],
      );
}
