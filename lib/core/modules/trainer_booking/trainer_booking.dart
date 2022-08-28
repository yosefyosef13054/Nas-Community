class TrainerBooking {
  String? id;
  String? trainerId;
  String? learnerId;
  String? communityId;
  String? status;
  DateTime? startTime;
  DateTime? endTime;
  String? bookingLink;
  String? rescheduleLink;
  String? cancelLink;
  String? inviteeLink;
  DateTime? createdAt;
  DateTime? lastModifiedTimeStamp;
  int? v;


  TrainerBooking(
      {this.id,
      this.trainerId,
      this.learnerId,
      this.communityId,
      this.status,
      this.startTime,
      this.endTime,
      this.bookingLink,
      this.rescheduleLink,
      this.cancelLink,
      this.inviteeLink,
      this.createdAt,
      this.lastModifiedTimeStamp,
      this.v});


  factory TrainerBooking.fromMap (Map<String, dynamic> data){
    return TrainerBooking(
      id: data["_id"]?.toString(),
      learnerId: data["learnerId"]?.toString(),
      createdAt:  DateTime.tryParse(data["createdAt"].toString())?.toLocal(),
      lastModifiedTimeStamp: DateTime.tryParse(data["lastModifiedTimeStamp"])?.toLocal(),
      status: data["status"]?.toString(),
      endTime: DateTime.tryParse(data["endTime"])?.toLocal(),
      startTime: DateTime.tryParse(data["startTime"])?.toLocal(),
      v: data["__v"],
      bookingLink: data["bookingLink"]?.toString(),
      cancelLink: data["cancelLink"]?.toString(),
      communityId: data["communityId"]?.toString(),
      inviteeLink: data["inviteeLink"]?.toString(),
      rescheduleLink: data["rescheduleLink"]?.toString(),
      trainerId: data["trainerId"]?.toString(),
     );
  }


  Map<String, dynamic> toMap (){
    return {
      "_id": id,
      "trainerId": trainerId,
      "learnerId": learnerId,
      "communityId": communityId,
      "status": status,
      "startTime": startTime.toString(),
      "endTime": endTime.toString(),
      "bookingLink": bookingLink,
      "rescheduleLink": rescheduleLink,
      "cancelLink": cancelLink,
      "inviteeLink": inviteeLink,
      "createdAt": createdAt.toString(),
      "lastModifiedTimeStamp": lastModifiedTimeStamp.toString(),
      "__v": 0,
    };
  }
}