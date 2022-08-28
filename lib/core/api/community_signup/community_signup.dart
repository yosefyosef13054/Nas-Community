import 'dart:convert';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nas_academy/core/local_db/user/user_local_db.dart';
import 'package:nas_academy/core/modules/exceptions/server_error.dart';
import 'package:nas_academy/core/modules/user/user.dart';
import 'package:nas_academy/core/services/messenger.dart';
import 'package:nas_academy/core/utils/api.dart';
import 'dart:developer';


class CommunitySignupApi {
  final http.Client? client;

  const CommunitySignupApi({this.client});

  Future<bool> communitySignup({
    required String communityCode,
    required String email,
    required productID,
    required price,
    required currency
  }) async {
    try {
      http.Client communitySignupClient = client ?? http.Client();
      final body = jsonEncode({
        "communityCode": communityCode,
        "timezone": DateTime.now().timeZoneName,
        "email": email,
        "isDirectSignUpEmail": true,
        "pricing_data": {
          "id": productID.toString(),
          "unit_amount": price,
          "currency": currency.toString()}
      });
      final http.Response response = await communitySignupClient.post(API.communitySignup, headers: API.authHeader, body: body);
      final decoded = jsonDecode(response.body);
      if (response.statusCode ~/ 100 == 2) {
        await UserLocalDB.setApplicationToken(decoded["access_token"]);
        await UserLocalDB.setCommunitySignUpUUID(decoded["community_signup_uuid"] ?? "");
        return true;
      } else {
        throw ServerError<CommunitySignupApi>(
            title: "Failed communitySignup",
            body: decoded["message"] ?? decoded["error"]);
      }
    } catch (e) {
      log("ERROR communitySignup : ${e.toString()}");
      rethrow;
    }
  }


  Future communityWaitList({
    required BuildContext context,
    required String comCode,
  }) async {
    try {
      http.Client libraryClient = client ?? http.Client();
      final User? user = await UserLocalDB.currentUser();
      final info = await DeviceInfoPlugin().deviceInfo;
      final body = jsonEncode({
        "email": user?.email,
        "communityCode": comCode,
        "phoneNumber": user?.learner.phoneNumber ?? "",
        "country": user?.country ?? user?.learner.country ?? "",
        "device": info.toMap().toString(),
      });
      final http.Response response = await libraryClient.post(API.communityWaitList, headers: API.headers, body: body);
      final decoded = jsonDecode(response.body);
      if (response.statusCode ~/ 100 == 2) {
        Messenger.showSuccessSnackBar(context, message: "Added to wait-list");
      } else {
        throw ServerError<CommunitySignupApi>(
            title: "Failed communitySignup",
            body: decoded["message"] ?? decoded["error"]);
      }
    } catch (e) {
      log("ERROR communitySignup : ${e.toString()}");
      rethrow;
    }
  }
}
