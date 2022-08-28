class NotificationPreference {
  bool? onboarding;
  bool? liveSessions;
  bool? members;
  bool? library;
  bool? meetExpert;
  bool? newLaunches;
  bool? promotions;


  NotificationPreference(
      {this.onboarding,
      this.liveSessions,
      this.members,
      this.library,
      this.meetExpert,
      this.newLaunches,
      this.promotions});

  factory NotificationPreference.fromMap (Map<String, dynamic> data){
    return NotificationPreference(
      library: data["library"] == true,
      liveSessions: data["liveSessions"] == true,
      meetExpert: data["meetExpert"] == true,
      members: data["members"] == true,
      newLaunches: data["newLaunches"] == true,
      onboarding: data["onboarding"],
      promotions: data["promotions"]
    );
  }

  Map<String, dynamic> toMap (){
    return {
      "onboarding": onboarding,
      "liveSessions": liveSessions,
      "members": members,
      "library": library,
      "meetExpert": meetExpert,
      "promotions": promotions,
      "newLaunches": newLaunches
    };
  }
}