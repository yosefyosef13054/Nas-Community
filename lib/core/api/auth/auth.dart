import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nas_academy/core/api/auth/facebook/facebook_auth.dart';
import 'package:nas_academy/core/api/auth/google/google.dart';
import 'package:nas_academy/core/local_db/user/user_local_db.dart';
import 'package:nas_academy/core/modules/exceptions/server_error.dart';
import 'package:nas_academy/core/modules/user/user.dart';
import 'package:nas_academy/core/utils/api.dart';
import 'package:nas_academy/core/utils/data_types.dart';
import 'package:nas_academy/main.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth {
  http.Client? client;
  Auth({this.client});

  Future register({
    required String name,
    required String email,
    required String pass,
    required String passTwo,
  }) async {
    try {
      http.Client authClient = client ?? http.Client();

      final _body = jsonEncode({
        "email": email,
        "name": name,
        "password": pass,
        "password2": passTwo
      });
      http.Response response =
          await authClient.post(API.signup, body: _body, headers: API.headers);

      final decoded = jsonDecode(response.body);
      if (response.statusCode ~/ 100 == 2) {
      } else {
        throw ServerError<Auth>(
            body: decoded["message"], title: "Failed to Sign up");
      }
    } catch (e) {
      log("ERROR Sign up : ${e.toString()}");
      rethrow;
    }
  }



  Future<User> login({required String email, required String password}) async {
    try {
      http.Client authClient = client ?? http.Client();
      String? deviceToken = await FirebaseMessaging.instance.getToken();
      final bool notificationsAllowed = await Permission.notification.status.isGranted;
      final _body = jsonEncode({
        "email": email,
        "password": password,
        "deviceToken": deviceToken,
        "notificationsAllowed": notificationsAllowed
      });
      http.Response response = await authClient.post(API.login, body: _body, headers: API.headers);
      final decoded = jsonDecode(response.body);
      if (response.statusCode ~/ 100 == 2) {
        await UserLocalDB.setToken(decoded["token"]);
        await UserLocalDB.setRefreshToken(decoded["refresh_token"]);
        return User.fromMap(decoded["user"]);
      } else {
        throw ServerError<Auth>(
            body: decoded["message"], title: "Failed to Login");
      }
    } catch (e) {
      log("ERROR Login : ${e.toString()}");
      rethrow;
    }
  }

  Future<String> getToken(
      {AuthType? provider, String? token, bool? isRefresh}) async {
    try {
      http.Client authClient = client ?? http.Client();

      String? deviceToken = await FirebaseMessaging.instance.getToken();

      final String refreshToken = await UserLocalDB.getRefreshToken();
      String _body = "";
      final bool notificationsAllowed = await Permission.notification.status.isGranted;

      if (provider == AuthType.google || provider == AuthType.facebook) {
        _body = jsonEncode({
          "authToken": token,
          "provider": authTypeToString(provider!),
          "isMobile": true,
          "notificationsAllowed": notificationsAllowed,
          'deviceToken': deviceToken
        });
      } else if (provider == AuthType.apple) {
        _body = jsonEncode({
          "code": token,
          "provider": authTypeToString(provider!),
          "appleRedirectUrl": "https://bird-splendid-pyroraptor.glitch.me/callbacks/sign_in_with_apple",
          "isApplePlatform": Platform.isIOS,
          "notificationsAllowed": notificationsAllowed,
          'deviceToken': deviceToken
        });
      } else if (isRefresh == true) {
        _body = jsonEncode({
          "refreshToken": refreshToken,
          "notificationsAllowed": notificationsAllowed
        });
      }
      http.Response response = await authClient.post(API.getToken,
          body: _body, headers: API.headers);
      final decoded = jsonDecode(response.body);

      if (response.statusCode ~/ 100 == 2) {
        await UserLocalDB.setToken(decoded["token"].toString());
        await UserLocalDB.setRefreshToken(decoded["refresh_token"].toString());
        return decoded["token"].toString();
      } else {
        throw ServerError(body: decoded["message"], title: "Failed to login");
      }
    } catch (e) {
      log("ERROR getting token form $provider : ${e.toString()}");
      throw ServerError(body: e.toString(), title: "Failed to login");
    }
  }

  Future<User> getUserProfile(String token) async {
    try {
      http.Client authClient = client ?? http.Client();
      final _headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
      http.Response response =
          await authClient.get(API.userProfile, headers: _headers);
      final decoded = jsonDecode(response.body);

      if (response.statusCode ~/ 100 == 2) {
        return User.fromMap(decoded);
      } else {
        throw ServerError(
            body: decoded["message"], title: "Failed to get user ");
      }
    } catch (e) {
      log("ERROR getting user  : ${e.toString()}");
      rethrow;
    }
  }

  Future logOut(BuildContext context) async {
    final pref = await SharedPreferences.getInstance();
    String token = await UserLocalDB.getToken();
     String? deviceToken = await FirebaseMessaging.instance.getToken();
    final body = jsonEncode({
      "deviceToken": deviceToken,
    });
    await http.post(API.logout, headers: API.header(token), body: body);
    await pref.clear();
    await Google.logOut();
    await Facebook.logOut();
    Restart.restartApp(context);
  }


  Future deleteAccount ()async{
    try{
      String token = await UserLocalDB.getToken();
      http.Client authClient = client ?? http.Client();
      http.Response response = await authClient.delete(API.deleteAccount, headers: API.header(token));
      if(response.statusCode ~/100 == 2){

      }else {
        final decoded = jsonDecode(response.body);
        throw ServerError(
          body: decoded["message"],
          title: "Failed to delete account"
        );
      }
    }catch(e){
      log("Failed to delete account : ${e.toString()}");
      rethrow;
    }
  }
}
