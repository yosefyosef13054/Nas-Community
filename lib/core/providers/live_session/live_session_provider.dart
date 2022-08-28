import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:nas_academy/core/api/live_session/live_session_api.dart';
import 'package:nas_academy/core/modules/live_session/main_live_sessions.dart';
import 'package:nas_academy/core/services/permission_handler.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../ui/dash/live_session/components/confirmed_going_bottomsheet.dart';

class LiveSessonProvider extends ChangeNotifier {
  LiveSessionApi api = LiveSessionApi();
  MainLiveSessions? livesessions;
  MainLiveSessions? get getlivesessions => livesessions;
  bool loading = false;
  bool get getloading => loading;
  bool notificaitonsGranted = false;
  bool get getnotificaitonsGranted => notificaitonsGranted;
  List attendingSessionsIds = [];
  List get getattendingSessionsIds => attendingSessionsIds;

  late TabController _tabController;
  TabController get tabController => _tabController;

  set setTabController(TabController value) {
    _tabController = value;
  }

  Future getLists(id) async {
    loading = true;
    livesessions = await api.getLiveSessions(id);

    for (var element in livesessions!.upcoming) {
      element.sessions?.forEach((element) {
        if (element.registered == true) {
          attendingSessionsIds.add(element.id);
        }
      });
    }
    loading = false;
    notifyListeners();
  }


  Future<Session?> getSessionById (String eventID, String communityID)async{
    if(getlivesessions == null){
      await getLists(communityID);
    }
    List<Session> allSessions = [];
    allSessions.addAll(getlivesessions!.past.map((e) => e.sessions).reduce((a, b) => a! + b!)!.toList());
    allSessions.addAll(getlivesessions!.upcoming.map((e) => e.sessions).reduce((a, b) => a! + b!)!.toList());
    allSessions.addAll(getlivesessions!.attending.map((e) => e.sessions).reduce((a, b) => a! + b!)!.toList());
    List <Session> items = allSessions.where((element) => element.id == eventID).toList();
    if(items.isNotEmpty){
      return items.first;
    }else {
      return null;
    }
  }
  void notifyMe(context) async {
    var permissionhandler = PermissionHandlerService();
    await permissionhandler.notificationsRequest(context);

    notificaitonsGranted = await Permission.notification.isGranted;

    notifyListeners();
  }

  Future checkPermission() async {
    var permissionhandler = PermissionHandlerService();
    notificaitonsGranted = await permissionhandler.notificationEnabled();
    notifyListeners();
  }

  void confirmAttendance(context, item) async {
    bool success = await api.eventSchadule(item.id);

    if (success == true) {
      attendingSessionsIds.add(item.id);

      notifyListeners();

      Navigator.pop(context);

      showBarModalBottomSheet(
        expand: false,
        context: context,
        duration: const Duration(milliseconds: 300),
        animationCurve: Curves.easeInOut,
        backgroundColor: Colors.transparent,
        builder: (ctx) {
          return ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(28),
                topRight: Radius.circular(28),
              ),
              child: ConfirmedAttendanseSheet(
                item: item,
              ));
        },
      );
    }
  }
}
