class NotificationData {
  final String? communityCode;
  final String? eventObjectId;

  const NotificationData({
    this.communityCode,
    this.eventObjectId
});

  factory NotificationData.fromMap (Map<String, dynamic> data){
    return NotificationData(
      communityCode: data["communityCode"]?.toString(),
      eventObjectId: data["eventObjectId"]?.toString()
    );
  }
  Map<String, dynamic> toMap (){
    return {
      "communityCode" : "",
      "eventObjectId" : ""
    };
  }
}