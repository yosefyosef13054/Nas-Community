import 'dart:convert';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:nas_academy/core/providers/dash/dash_provider.dart';
import 'package:nas_academy/core/providers/live_session/live_session_provider.dart';
import 'package:nas_academy/core/services/app_badges.dart';
import 'package:nas_academy/core/services/notification_action.dart';
import 'dart:developer';
import 'package:nas_academy/core/utils/data_types.dart';


class NotificationService {
  final BuildContext context;
  final DashProvider dash;
  final LiveSessonProvider sessoin;

  NotificationService({required this.context, required this.dash, required this.sessoin});

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  Future init() async {
    await _fcm.setAutoInitEnabled(true);
    final String? device = await _fcm.getToken();
    log("DEVICE TOKEN : $device");


  if(Platform.isIOS){
    await _fcm.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    await _fcm.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

  }else if (Platform.isAndroid){
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description: 'This channel is used for important notifications.', // description
      importance: Importance.max,
      showBadge: true,
      enableVibration: true,
      playSound: true,
    );

    await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);
  }


    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    const IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
      defaultPresentSound: true,
      defaultPresentAlert: true,
      defaultPresentBadge: true,
    );

    const initializationSettings = InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: onSelectNotification);


    /// on message (foreground)
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      if (message.data["type"].toString().toLowerCase() == NotificationType.applicationApproved.name.toLowerCase()) {
        await onApplicationApprovedBottomSheet(code: message.data["communityCode"], dash: dash, context: context);
      } else {
        if(Platform.isAndroid){
          showNotification(message);
        }else if ( Platform.isIOS ) {
          await AppBadge.incrementBadgeCount();
        }
      }
    });


    /// on message Opened App (when user clicks on notification)
    FirebaseMessaging.onMessageOpenedApp.listen((message) async {
      List<NotificationType> types = NotificationType.values.where((element) => element.name.toLowerCase() == message.data["type"].toString().toLowerCase()).toList();
      await NotificationScreenAction(
              context: context,
              type: types.isNotEmpty ? types.first : NotificationType.other,
              communityCode: message.data["communityCode"],
              eventID: message.data["eventObjectId"],
              liveSessions: sessoin,
              dash: dash,
              openScreenOnOther: true)
          .handleNotificationCardClick();
    });


    FirebaseMessaging.onBackgroundMessage(onBackground);
  }




  void onSelectNotification(String? payload) async {
    if (payload != null) {
      final data = jsonDecode(payload);
      List<NotificationType> types = NotificationType.values
          .where((element) =>
              element.name.toLowerCase() ==
              data["type"].toString().toLowerCase())
          .toList();
      await NotificationScreenAction(
              context: context,
              type: types.isNotEmpty ? types.first : NotificationType.other,
              communityCode: data["communityCode"],
              eventID: data["eventObjectId"],
              liveSessions: sessoin,
              dash: dash,
              openScreenOnOther: true)
          .handleNotificationCardClick();
    }
  }





  Future<void> showNotification(RemoteMessage message) async {
    final androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'channel_ID',
      'channel name',
      channelDescription: 'channel description',
      importance: Importance.max,
      playSound: true,
      showProgress: true,
      priority: Priority.max,
      ticker: 'test ticker',
      icon: message.notification?.android?.smallIcon,
      channelShowBadge: true,
      fullScreenIntent: true,
      enableVibration: true,
    );

    final platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(
      message.hashCode,
      message.notification?.title,
      message.notification?.body,
      platformChannelSpecifics,
      payload: jsonEncode(message.data),
    );
  }

}



Future onBackground (RemoteMessage message)async{
  await Firebase.initializeApp();
  await AppBadge.incrementBadgeCount();
}
