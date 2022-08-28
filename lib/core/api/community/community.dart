import 'dart:convert';
import 'package:nas_academy/core/helpers/dio_api.dart';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:nas_academy/core/local_db/user/user_local_db.dart';
import 'package:nas_academy/core/modules/community/active_community/active_community.dart';
import 'package:nas_academy/core/modules/community/community/community.dart';
import 'package:nas_academy/core/modules/exceptions/server_error.dart';
import 'package:nas_academy/core/utils/api.dart';

import '../auth/auth.dart';

class CommunityApi {
  DioService dioServices = DioService();

  Map<String, String> headers = {"content-type": "text/json"};
  Map<String, String>? cookies = {};

  Future<List<Community>> getCommunities() async {
    try {
      String token = await UserLocalDB.getToken();
      http.Response response =
          await http.get(API.communities(""), headers: API.header(token));
      final decoded = jsonDecode(response.body);
      if (response.statusCode ~/ 100 == 2) {
        String allSetCookie = response.headers['set-cookie'].toString();
        if (allSetCookie.isNotEmpty) {
          var setCookies = allSetCookie.split(',');
          for (var setCookie in setCookies) {
            var cookies = setCookie.split(';');
            for (var cookie in cookies) {
              _setCookie(cookie);
            }
          }
          headers['cookie'] = _generateCookieHeader();
        }
        await UserLocalDB.setCookie(_generateCookieHeader().toString());
        final List<dynamic> list = List.from(decoded["communities"] ?? []);
        return list.map((e) => Community.fromMap(e)).toList();
      } else {
        throw ServerError<CommunityApi>(
          title: "Failed to get communities",
          body: decoded["message"] ?? "",
        );
      }
    } catch (e) {
      log("ERROR getting communities : ${e.toString()}");
      rethrow;
    }
  }

  Future<ActiveCommunity> getActiveCommunity(String communityCode) async {
    try {
      await Auth().getToken(isRefresh: true);
      String token = await UserLocalDB.getToken();
      http.Response response = await http.get(API.communities(communityCode),
          headers: API.header(token));
      final decoded = jsonDecode(response.body);

      if (response.statusCode ~/ 100 == 2) {
        if (decoded["activeCommunity"] is Iterable<dynamic>) {
          List<dynamic> list = List.from(decoded["activeCommunity"] ?? []);
          List<ActiveCommunity> coms =
              list.map((e) => ActiveCommunity.fromMap(e)).toList();
          return coms.isNotEmpty ? coms.first : ActiveCommunity();
        } else {
          return decoded["activeCommunity"] != null ? ActiveCommunity.fromMap(decoded["activeCommunity"]) : ActiveCommunity();
        }
      } else {
        throw ServerError<CommunityApi>(
            title: "Failed to get active community",
            body: decoded["message"] ?? "");
      }
    } catch (e) {
      log("ERROR getting active community : ${e.toString()}");
      rethrow;
    }
  }

  void _setCookie(String rawCookie) {
    if (rawCookie.isNotEmpty) {
      var keyValue = rawCookie.split('=');
      if (keyValue.length == 2) {
        var key = keyValue[0].trim();
        var value = keyValue[1];
        if (key == 'path' || key == 'expires') return;
        cookies![key] = value;
      }
    }
  }

  String _generateCookieHeader() {
    String cookie = "";
    for (var key in cookies!.keys) {
      if (cookie.isNotEmpty) cookie += ";";
      cookie += key + "=" + cookies![key].toString();
    }

    return cookie;
  }
}
