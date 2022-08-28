import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nas_academy/core/local_db/user/user_local_db.dart';
import 'dart:developer';
import 'package:nas_academy/core/utils/api.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:store_redirect/store_redirect.dart';
import 'package:url_launcher/url_launcher.dart';

class AppCompatibilityAPI {
  final http.Client? client;
  AppCompatibilityAPI({this.client});


  Future<bool> isCompatible ()async{
    try{
      http.Client compClient = client ?? http.Client();
      final String token = await UserLocalDB.getToken();
      if(token.isEmpty){
        return true;
      }else {
        PackageInfo packageInfo = await PackageInfo.fromPlatform();
        final body = jsonEncode({
          "appVersion": packageInfo.version,
          "appPlatform" : Platform.isIOS? "apple" : "google"
        });
        http.Response response = await compClient.post(API.appCompatibility, body : body, headers: API.header(token) );
        final decoded = jsonDecode(response.body);
        return decoded["isCompatible"] == true;
      }
    }catch (e){
      log("Error getting app compatibility : ${e.toString()}");
      return true;
    }
  }



  Future showUpdateDialog (BuildContext context)async{
    showDialog(
      context: context,
      barrierDismissible: false,
      useRootNavigator: true,
      builder: (context){
        return CupertinoAlertDialog(
          title: const Text("Update!"),
          content: const Text("Your app needs update!"),
          actions: [
            TextButton(
              child: const Text("update"),
              onPressed: (){
                if(Platform.isAndroid){
                  StoreRedirect.redirect();
                }else if(Platform.isIOS){
                  launchUrl(Uri.parse("https://apps.apple.com/app/1624529593"));
                }
              },
            )
          ],
        );
      }
    );
  }

}