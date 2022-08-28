import 'dart:convert';
import 'dart:developer';

import 'package:nas_academy/core/modules/exceptions/local_db_error.dart';
import 'package:nas_academy/core/modules/notification/notifications_pref.dart';
import 'package:nas_academy/core/modules/user/user.dart';
import 'package:nas_academy/core/services/permission_handler.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserLocalDB {
  UserLocalDB._();

  static const String _key = "CURRENT_USER";
  static const String _token = "TOKEN";
  static const String _refreshtoken = "REFRESHTOKEN";
  static const String _cokkie = "Cookie";
  static const String _applicationToken = "applicationToken";
  static const String _communitySignUpID = "CommunitySignUpID";
  static const String _notificationPreference = "notificationPreference";

  static Future<User?> currentUser() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? jsonString = pref.getString(_key);
      if (jsonString != null) {
        final decoded = jsonDecode(jsonString);
        return User.fromMap(decoded);
      } else {
        return null;
      }
    } catch (e) {
      log(e.toString());
      throw LocalDBError(
          body: e.toString(), title: "Error reading user data .. ");
    }
  }

  static Future saveUser(User user) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? jsonString = jsonEncode(user.toMap());
      await pref.setString(_key, jsonString);
    } catch (e) {
      log("Error saving user data  : ${e.toString()}");
      throw LocalDBError(
        title: "Error saving user data",
        body: e.toString(),
      );
    }
  }

  static Future setCookie(String cookie) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      await pref.setString(_cokkie, cookie);
    } catch (e) {
      log("Error saving user token  : ${e.toString()}");
      throw LocalDBError(
        title: "Error saving user Token",
        body: e.toString(),
      );
    }
  }

  static Future setToken(String token) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      await pref.setString(_token, token);
    } catch (e) {
      log("Error saving user token  : ${e.toString()}");
      throw LocalDBError(
        title: "Error saving user Token",
        body: e.toString(),
      );
    }
  }

  static Future<String> getToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString(_token);
      log("TOKEN : $token");
      return token ?? "";
    } catch (e) {
      log("ERROR getting user token : ${e.toString()}");
      throw LocalDBError(
        title: "Error getting user token",
        body: e.toString(),
      );
    }
  }

  static Future setRefreshToken(String refreshToken) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      await pref.setString(_refreshtoken, refreshToken);
    } catch (e) {
      log("Error saving user refreshToken  : ${e.toString()}");
      throw LocalDBError(
        title: "Error saving user refreshToken",
        body: e.toString(),
      );
    }
  }

  static Future<String> getRefreshToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString(_refreshtoken);
      log("refreshToken : $token");
      return token ?? "";
    } catch (e) {
      log("ERROR getting user refreshToken : ${e.toString()}");
      throw LocalDBError(
        title: "Error getting user refreshToken",
        body: e.toString(),
      );
    }
  }

  static Future<String> getCookie() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString(_cokkie);
      return token ?? "";
    } catch (e) {
      log("ERROR getting user token : ${e.toString()}");
      throw LocalDBError(
        title: "Error getting user token",
        body: e.toString(),
      );
    }
  }

  static Future setSayHiToNewMembers(bool show) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setBool("sayHiToNewMembers", show);
  }

  static Future<bool> getSayHiToNewMembers() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final bool? show = pref.getBool("sayHiToNewMembers");
    return show ?? true;
  }

  static Future setShowNearMeMembersTip(bool show) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setBool("nearMeMembersTip", show);
  }

  static Future<bool> getShowNearMeMembersTip() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final bool? show = pref.getBool("nearMeMembersTip");
    return show ?? true;
  }

  static Future<int> getNearMeTipShowsNumber() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final int? number = pref.getInt("nearMeTipNumber");
    return number ?? 0;
  }

  static Future setNearMeTipShowsNumber({int? val}) async {
    int number = await getNearMeTipShowsNumber();
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setInt("nearMeTipNumber", val ?? number + 1);
  }

  static Future initNearMeTip() async {
    int number = await getNearMeTipShowsNumber();
    final bool granted = await PermissionHandlerService.locationEnabled();
    if (number < 5 && !granted) {
      await setShowNearMeMembersTip(true);
    }
  }

  static Future setOriantationShow(bool show) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setBool("oriantationShow", show);
  }

  static Future<bool> getOriantationShowp() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final bool? show = pref.getBool("oriantationShow");
    return show ?? true;
  }

  static Future setApplicationToken(String token) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      await pref.setString(_applicationToken, token);
    } catch (e) {
      log("Error saving application token  : ${e.toString()}");
      throw LocalDBError(
        title: "Error saving application Token",
        body: e.toString(),
      );
    }
  }

  static Future<String> getApplicationToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString(_applicationToken);
      log("_applicationToken : $token");
      return token ?? "";
    } catch (e) {
      log("ERROR getting application token : ${e.toString()}");
      throw LocalDBError(
        title: "Error getting application token",
        body: e.toString(),
      );
    }
  }

  static Future setCommunitySignUpUUID(String token) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString(_communitySignUpID, token);
  }

  static Future<String> getCommunitySignUpUUID() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(_communitySignUpID);
    log("CommunitySignUpUUID : $token");
    return token ?? "";
  }


  static Future setNotificationPreference(NotificationPreference preference) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      final String preferenceJson = jsonEncode(preference.toMap());
      await pref.setString(_notificationPreference, preferenceJson);
    } catch (e) {
      log("Error saving NotificationPreference  : ${e.toString()}");
      throw LocalDBError(
        title: "Error Saving Notification Preference",
        body: e.toString(),
      );
    }
  }

  static Future<NotificationPreference> getNotificationPreference() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? preferenceJson = prefs.getString(_notificationPreference);
      if(preferenceJson == null){
        final bool status = await Permission.notification.status.isGranted;
        return NotificationPreference(
          liveSessions: status,
          library: status,
          meetExpert: status,
          members: status,
          newLaunches: status,
          onboarding: status,
          promotions: status
        );
      }else {
        final decoded = jsonDecode(preferenceJson);
        return NotificationPreference.fromMap(decoded);
      }
    } catch (e) {
      log("ERROR getting Notification Preference: ${e.toString()}");
      throw LocalDBError(
        title: "Error getting Notification Preference",
        body: e.toString(),
      );
    }
  }

}
