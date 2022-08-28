
import 'package:nas_academy/core/utils/env.dart';

class API {
  static const String baseUrl = Dev.baseUrl;
  static String applicationBaseUrl = Dev.mainWebBaseUrl;
  static String staticBaseUrl = Dev.staticBaseUrl;


  static final headers = {'Content-type': 'application/json'};

  static final authHeader = {
    'auth-token': 'NASDAILY1!',
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  static header(String token) {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  static final Uri login = Uri.https(baseUrl, "/api/v1/mobile/log-in");
  static final Uri signup = Uri.https(baseUrl, "/api/v1/mobile/sign-up");
  static final Uri getToken = Uri.https(baseUrl, "/api/v1/get-token");
  static final Uri userProfile = Uri.https(baseUrl, "/api/v1/mobile/user-profile");
  static final Uri logout = Uri.https(baseUrl, "/api/v1/mobile//log-out");


  static Uri communities(String communityCode) {
    return Uri.parse(
        "https://$baseUrl/api/v1/mobile/communities?activeCommunity=$communityCode");
  }

  static Uri members(String communityId) {
    return Uri.parse("http://$baseUrl/api/v1/mobile/communities/$communityId/memberships");
  }

  static Uri liveSessionEventSchadule(String sessionID) {
    return Uri.parse(
        "http://$baseUrl/api/v1/mobile/communities/event/$sessionID/register");
  }

  static Uri trainerBooking(String communityID) {
    return Uri.parse(
        "http://$baseUrl/api/v1/mobile/communities/event/$communityID/register");
  }

  static Uri getBooking(
      {required String communityID, required String learnerId}) {
    return Uri.parse(
        "http://$baseUrl/api/v1/mobile/communities/$communityID/learner-booking?learnerId=$learnerId");
  }

  static Uri cancelBooking(String communityID) {
    return Uri.parse(
        "http://$baseUrl/api/v1/mobile/communities/$communityID/trainers/cancel");
  }

  static Uri fetchLatestBooking(String communityID) {
    return Uri.parse(
        "http://$baseUrl/api/v1/mobile/communities/$communityID/learner-booking");
  }

  static Uri liveSessionCommunityID(String communityID) {
    return Uri.parse(
        "https://$baseUrl/api/v1/mobile/communities/$communityID/events");
  }

  static Uri toDoCommunityID(String communityID) {
    return Uri.parse("https://$baseUrl/api/v1/mobile/communities/$communityID/orientation");
  }

  static Uri toDoTaskID(String taskID) {
    return Uri.parse("https://$baseUrl/api/v1/mobile/communities/todo/$taskID");
  }

  /// Library

  static Uri resourcesPreview(String communityID) {
    return Uri.parse(
        "http://$baseUrl/api/v1/mobile/communities/$communityID/resources/preview");
  }

  static Uri resources(String communityID) {
    return Uri.parse(
        "http://$baseUrl/api/v1/mobile/communities/$communityID/resources");
  }

  static Uri videoPreview(String communityID) {
    return Uri.parse(
        "http://$baseUrl/api/v1/mobile/communities/$communityID/videos/preview");
  }

  static Uri videos(String communityID) {
    return Uri.parse(
        "http://$baseUrl/api/v1/mobile/communities/$communityID/videos");
  }



  /// profile
  static final Uri uploadPhoto = Uri.https(baseUrl, "/api/v1/mobile/upload-photo");
  static final Uri updateProfile = Uri.https(baseUrl, "/api/v1/mobile/update-profile");
  static final Uri skills = Uri.https(baseUrl, "/api/v1/mobile/skills");
  static final Uri interests = Uri.https(baseUrl, "/api/v1/mobile/interests");
  static final Uri resetPassword = Uri.https(baseUrl, "/api/v1/auth/reset-password");
  static final Uri deleteAccount = Uri.https(baseUrl, "/api/v1/mobile/delete-account");



  /// application
  static Uri applicationConfigs(String communityCode) {
    return Uri.parse("http://$applicationBaseUrl/api/v1/mobile/get-community-data?communityCode=$communityCode&timezoneId=Asia/Calcutta");
  }
  static final Uri communitySignup = Uri.https(applicationBaseUrl, "/api/v1/mobile/community-signup");
  static final Uri validateReceipt = Uri.https(applicationBaseUrl, "/api/v1/validate-in-app-receipt");
  static final Uri communityEnrolmentApplication = Uri.https(applicationBaseUrl, "/api/v1/mobile/community-enrollment-application");
  static final Uri communityWaitList = Uri.https(staticBaseUrl, "api/v1/communities");
  static final Uri applicationStatus = Uri.https(baseUrl, "/api/v1/mobile/signed-up-info");



  /// notifications
  static final Uri getNotifications = Uri.https(baseUrl, "/api/v1/mobile/communities/user-mobile-notifications");
  static final Uri markNotificationSeen = Uri.https(baseUrl, "/api/v1/mobile/communities/notifications-seen");
  static final Uri notificationSettings = Uri.https(baseUrl, "/api/v1/mobile/communities/user-notification-permissions");



  /// app compatibility
  static final Uri appCompatibility = Uri.https(baseUrl, "/api/v1/mobile/version-compatibility");


}
