import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nas_academy/core/local_db/user/user_local_db.dart';
import 'package:nas_academy/core/modules/exceptions/server_error.dart';
import 'package:nas_academy/core/modules/notification/notification.dart';
import 'package:nas_academy/core/modules/notification/notifications_pref.dart';
import "dart:developer";
import 'package:nas_academy/core/utils/api.dart';

class NotificationsApi {
  final http.Client? client;

  const NotificationsApi({this.client});

  Future<List<UserNotification>> getNotifications(String? communityCode) async {
    try {
      http.Client notClient = client ?? http.Client();
      final String token = await UserLocalDB.getToken();
      http.Response response = await notClient.get(API.getNotifications, headers: API.header(token));
      final decoded = jsonDecode(response.body);
      if (response.statusCode ~/ 100 == 2) {
        final List<dynamic> list = List.from(decoded);
        List<UserNotification> notifications =  list.map((e) => UserNotification.fromMap(e)).toList();
        return notifications.where((element) => element.data == null || element.data?.communityCode == communityCode || communityCode == null).toList();
      } else {
        throw ServerError<NotificationsApi>(
            title: "Failed to get notification", body: decoded['message']);
      }
    } catch (e) {
      log("ERROR getting notifications : ${e.toString()}");
      rethrow;
    }
  }

  Future setNotificationSeen(List<String> notIds) async {
    try {
      http.Client notClient = client ?? http.Client();
      final String token = await UserLocalDB.getToken();
      final body = jsonEncode({"notificationIds": notIds});
      await notClient.post(API.markNotificationSeen,
          body: body, headers: API.header(token));
    } catch (e) {
      log("ERROR getting notifications : ${e.toString()}");
      rethrow;
    }
  }

  Future setNotificationPreference(
    NotificationPreference preference) async {
    try {
      http.Client notClient = client ?? http.Client();
      final String token = await UserLocalDB.getToken();
      final body = jsonEncode({
        "onboarding": preference.onboarding,
        "liveSessions": preference.liveSessions,
        "members": preference.members,
        "library": preference.library,
        "meetExpert": preference.meetExpert,
        "promotions": preference.promotions,
        "newLaunches": preference.newLaunches
      });
      http.Response response = await notClient.put(API.notificationSettings, body: body, headers: API.header(token));
      if(response.statusCode ~/100 == 2){
        await UserLocalDB.setNotificationPreference(preference);
      }
    } catch (e) {
      log("ERROR getting notifications : ${e.toString()}");
      rethrow;
    }
  }
}
