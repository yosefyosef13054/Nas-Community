import 'dart:io';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:nas_academy/core/api/notification/notifications_api.dart';
import 'package:nas_academy/core/modules/notification/notification.dart';

class AppBadge  {
  AppBadge._();


  static Future<int> unreadCount ()async{
    final List<UserNotification> all = await const NotificationsApi().getNotifications(null);
    return all.where((element) => element.seen == false).length;
  }


  static Future updateBadgeCount()async{
    final int unread = await unreadCount();
    if(unread == 0){
      FlutterAppBadger.removeBadge();
    }else {
      FlutterAppBadger.updateBadgeCount(unread);
    }
  }

  static Future incrementBadgeCount()async{
    if(Platform.isIOS){
      final int unread = await unreadCount();
      FlutterAppBadger.updateBadgeCount(unread + 1);
    }
  }
}