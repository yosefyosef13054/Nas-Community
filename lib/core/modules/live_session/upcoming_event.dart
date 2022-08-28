import 'package:nas_academy/core/modules/live_session/live_session.dart';

class UpcomingEvent {
  String? title;
  List<LiveSession> sessions;

  UpcomingEvent({this.title, this.sessions = const []});


  factory UpcomingEvent.fromMap (Map<String, dynamic> data){
    return UpcomingEvent(
      title: data["title"],
      sessions: List.from(data["sessions"] ?? []).map((e) => LiveSession.fromMap(e)).toList(),
    );
  }

  Map<String, dynamic> toMap (){
    return {
      "title" : title,
      "sessions" : sessions.map((e) => e.toMap()).toList()
    };
  }
}