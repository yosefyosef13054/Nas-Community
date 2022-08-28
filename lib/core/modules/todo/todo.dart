import 'dart:convert';

List<Todo> todoFromJson(String str) =>
    List<Todo>.from(json.decode(str).map((x) => Todo.fromJson(x)));

class Todo {
  Todo({
    required this.id,
    required this.title,
    required this.description,
    required this.ctaButtonText,
    required this.icon,
    required this.mode,
    required this.type,
    required this.isActive,
    required this.task,
    required this.communityId,
    required this.userProgress,
    required this.completed,
  });

  String? id;
  String? title;
  String? description;
  String? ctaButtonText;
  String? icon;
  String? mode;
  String? type;
  bool? isActive;
  Task? task;
  String? communityId;
  UserProgress? userProgress;
  bool completed;

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
        id: json["_id"],
        title: json["title"],
        description: json["description"],
        ctaButtonText: json["ctaButtonText"],
        icon: json["icon"],
        mode: json["mode"],
        type: json["type"],
        isActive: json["isActive"],
        task: Task.fromJson(json["task"]),
        communityId: json["communityId"],
        userProgress: json["userProgress"] == null
            ? null
            : UserProgress.fromJson(json["userProgress"]),
        completed: json["completed"],
      );
}

class Task {
  Task({
    required this.id,
    required this.eventId,
    required this.title,
    required this.description,
    required this.startTime,
    required this.endTime,
    required this.liveLink,
    required this.recordingLink,
    required this.isActive,
    required this.status,
    required this.type,
    required this.communities,
    required this.host,
    required this.lastModifiedTimeStamp,
    required this.shortUrl,
    required this.icsFileLink,
    required this.attendees,
    required this.profileImages,
    required this.resources,
    required this.platform,
    required this.name,
    required this.link,
    required this.objectId,
    required this.thumbnail,
    required this.hlsLink,
    required this.duration,
    required this.topic,
    required this.topicIndex,
  });

  dynamic id;
  int? eventId;
  String? title;
  String? description;
  DateTime? startTime;
  DateTime? endTime;
  String? liveLink;
  String? recordingLink;
  bool? isActive;
  String? status;
  String? type;
  List<String>? communities;
  Host? host;
  DateTime? lastModifiedTimeStamp;
  String? shortUrl;
  String? icsFileLink;
  int? attendees;
  List<String>? profileImages;
  dynamic resources;
  String? platform;
  String? name;
  String? link;
  String? objectId;
  String? thumbnail;
  String? hlsLink;
  int? duration;
  String? topic;
  int? topicIndex;

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        id: json["_id"],
        eventId: json["eventId"],
        title: json["title"],
        description: json["description"],
        startTime: json["startTime"] == null
            ? null
            : DateTime.parse(json["startTime"]),
        endTime:
            json["endTime"] == null ? null : DateTime.parse(json["endTime"]),
        liveLink: json["liveLink"],
        recordingLink: json["recordingLink"],
        isActive: json["isActive"],
        status: json["status"],
        type: json["type"],
        communities: json["communities"] == null
            ? null
            : List<String>.from(json["communities"].map((x) => x)),
        host: json["host"] == null ? null : Host.fromJson(json["host"]),
        lastModifiedTimeStamp: json["lastModifiedTimeStamp"] == null
            ? null
            : DateTime.parse(json["lastModifiedTimeStamp"]),
        shortUrl: json["shortUrl"],
        icsFileLink: json["icsFileLink"],
        attendees: json["attendees"],
        profileImages: json["profileImages"] == null
            ? null
            : List<String>.from(json["profileImages"].map((x) => x)),
        resources: json["resources"],
        platform: json["platform"],
        name: json["name"],
        link: json["link"],
        objectId: json["objectId"],
        thumbnail: json["thumbnail"],
        hlsLink: json["hlsLink"],
        duration: json["duration"],
        topic: json["topic"],
        topicIndex: json["topicIndex"],
      );
}

class Host {
  Host({
    required this.firstName,
    required this.lastName,
    required this.profileImage,
  });

  String? firstName;
  String? lastName;
  String? profileImage;

  factory Host.fromJson(Map<String, dynamic> json) => Host(
        firstName: json["firstName"],
        lastName: json["lastName"],
        profileImage: json["profileImage"],
      );
}

class UserProgress {
  UserProgress({
    required this.id,
    required this.todo,
    required this.learnerId,
    required this.completed,
    required this.v,
  });

  String? id;
  String? todo;
  int? learnerId;
  bool? completed;
  int? v;

  factory UserProgress.fromJson(Map<String, dynamic> json) => UserProgress(
        id: json["_id"],
        todo: json["todo"],
        learnerId: json["learnerId"],
        completed: json["completed"],
        v: json["__v"],
      );
}
