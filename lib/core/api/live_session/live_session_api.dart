import 'dart:convert';
import 'package:nas_academy/core/helpers/dio_api.dart';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:nas_academy/core/local_db/user/user_local_db.dart';
import 'package:nas_academy/core/modules/exceptions/server_error.dart';
import 'package:nas_academy/core/utils/api.dart';
import '../../modules/live_session/main_live_sessions.dart';

class LiveSessionApi {
  DioService dioServices = DioService();

  Future<MainLiveSessions> getLiveSessions(communityId) async {
    try {
      String token = await UserLocalDB.getToken();
      http.Response response = await http.get(API.liveSessionCommunityID(communityId), headers: API.header(token));
      final decoded = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return MainLiveSessions.fromJson(decoded);
      } else {
        throw ServerError<LiveSessionApi>(title: "Failed to get communities", body: decoded["message"]);
      }
    } catch (e) {
      log("ERROR getting LiveSession : ${e.toString()}");
      rethrow;
    }
  }


  Future<bool> eventSchadule(sessionID) async {
    try {
      String token = await UserLocalDB.getToken();
      http.Response response = await http.post(API.liveSessionEventSchadule(sessionID), headers: API.header(token));
      if (response.statusCode == 200) {

        return true;
      } else {
        throw ServerError<LiveSessionApi>(
            title: "Failed to get communities", body: response.toString());
      }
    } catch (e) {
      log("ERROR getting LiveSession : ${e.toString()}");
      rethrow;
    }
  }
}
