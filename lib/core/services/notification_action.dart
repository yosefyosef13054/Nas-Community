import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:nas_academy/core/modules/live_session/main_live_sessions.dart';
import 'package:nas_academy/core/providers/dash/dash_provider.dart';
import 'package:nas_academy/core/providers/live_session/live_session_provider.dart';
import 'package:nas_academy/core/services/navigator.dart';
import 'package:nas_academy/core/utils/data_types.dart';
import 'package:nas_academy/ui/common/application_approved_bottomseet.dart';
import 'package:nas_academy/ui/dash/community_view/components/notification_screen/notification_screen.dart';
import 'package:nas_academy/ui/dash/library/library.dart';
import 'package:nas_academy/ui/dash/live_session/livesession_details/live_session_details.dart';
import 'package:nas_academy/ui/dash/meet_an_expert/meet_an_expert.dart';
import 'package:nas_academy/ui/dash/members/members.dart';
import 'package:nas_academy/ui/dash/todo/todo_main.dart';


class NotificationScreenAction {
  final BuildContext context;
  final DashProvider dash;
  final LiveSessonProvider liveSessions;
  final NotificationType type;
  final String? communityCode;
  final String? eventID;
  final bool openScreenOnOther;

  const NotificationScreenAction({required this.context, required this.dash, required this.liveSessions, required this.type, this.communityCode, this.eventID, required this.openScreenOnOther});
  Future handleNotificationCardClick() async {
    if(communityCode != null){
      switch (type) {
        case NotificationType.firstEventAttendance: await openEvent();
        break;
        case NotificationType.applicationApproved: await applicationApproved();
        break;
        case NotificationType.completeApplicationForm: await openDiscovery();
        break;
        case NotificationType.completeTodos: await openTodos();
        break;
        case NotificationType.eventAdded: await openEvent();
        break;
        case NotificationType.eventStartingIn3Hours: await openEvent();
        break;
        case NotificationType.eventStartingIn10Minutes: await openEvent();
        break;
        case NotificationType.eventStartingNow: await openEvent();
        break;
        case NotificationType.formCompletedPaymentMissing: await openDiscovery();
        break;
        case NotificationType.meetExpertLast28Days: await openMeetExpert();
        break;
        case NotificationType.newMembersLast14Days: await openMembers();
        break;
        case NotificationType.resourceAdded: await openLibrary();
        break;
        case NotificationType.sevenDayEventAttendance: await openEvent();
        break;
        case NotificationType.other: await other();
          break;
      }
    }else {
      await other();
    }
  }



    Future applicationApproved ()async{
      if(communityCode != null){
        Navigator.of(context).popUntil((route) => route.isFirst);
        navigateToCommunity();
        await onApplicationApprovedBottomSheet(code: communityCode!, dash: dash, context: context);
      }
    }


    Future openEvent ()async{
      if(communityCode != null && eventID != null){
        navigateToCommunity();
        String? communityID = dash.communities.singleWhere((element) => element.code == communityCode).id;
        Session? session = await liveSessions.getSessionById(eventID ?? "", communityID ?? "");
        if(session != null){
          Navigate.push(context, LiveSessionDetailsScreen(item: session));
        }
      }else {
        await other();
      }
    }



    Future openLibrary ()async{
      if(communityCode != null){
        navigateToCommunity();
        if(dash.activeCommunity != null){
          Navigate.push(context, const Library(pop: true,));
        }
      }
    }


    Future openTodos ()async{
      navigateToCommunity();
      if(communityCode != null){
        Navigate.push(context, const ToDoScreen(pop: true,));
      }
    }


  Future openMeetExpert () async {
    if(communityCode != null){
      navigateToCommunity();
      if(dash.activeCommunity != null){
        Navigate.push(context, MeetAnExpert(community: dash.activeCommunity!, pop: true,));
      }
    }
  }


  Future openMembers () async {
    if(communityCode != null){
      navigateToCommunity();
      if(dash.activeCommunity != null){
        Navigate.push(context, const MembersScreen(pop: true,));
      }
    }
  }


  Future openDiscovery()async{
    Navigator.of(context).popUntil((route) => route.isFirst);
    dash.communitiesPageController.jumpToPage(dash.communities.length);
  }


  Future other ()async{
    if(openScreenOnOther){
      Navigate.push(context, NotificationScreen(communityCode: communityCode));
    }
  }


  void navigateToCommunity (){
    int index = dash.communities.indexWhere((element) => element.code == communityCode);
    dash.communitiesPageController.jumpToPage(index);
    dash.setCommunitiesIndexSilent = index;
  }


}



Future onApplicationApprovedBottomSheet({
  required String code,
  required DashProvider dash,
  required BuildContext context,
}) async {
  await dash.init(resetIndex: true);
  dash.notify();
  showBarModalBottomSheet(
      context: context,
      builder: (context) =>
          ApplicationApprovedBottomsSheet(communityCode: code));
}