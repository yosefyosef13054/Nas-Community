
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:nas_academy/core/local_db/user/user_local_db.dart';
import 'package:nas_academy/core/modules/exceptions/server_error.dart';
import 'package:nas_academy/core/utils/api.dart';
import 'dart:developer';


class SkillsAPI {
  final http.Client? client;
  const SkillsAPI({this.client});


  Future<List<String>> getSkills ()async{
    try{
      http.Client libraryClient = client ?? http.Client();
      final String token = await UserLocalDB.getToken();
      final http.Response response = await libraryClient.get(API.skills, headers: API.header(token));
      final decoded = jsonDecode(response.body);
      if(response.statusCode ~/100 == 2){
        final List<dynamic> list = List.from(decoded);
        return list.map((e) => e["label"].toString()).toList();
      }else {
        throw ServerError<SkillsAPI>(
            title: "Failed to get skills",
            body: decoded["message"] ?? decoded["error"]
        );
      }
    }catch (e){
      log("ERROR getting skills list : ${e.toString()}");
      rethrow;
    }
  }

  Future<List<String>> getInterests ()async{
    try{
      http.Client libraryClient = client ?? http.Client();
      final String token = await UserLocalDB.getToken();
      final http.Response response = await libraryClient.get(API.interests, headers: API.header(token));
      final decoded = jsonDecode(response.body);
      if(response.statusCode ~/100 == 2){
        final List<dynamic> list = List.from(decoded);
        return list.map((e) => e["label"].toString()).toList();
      }else {
        throw ServerError<SkillsAPI>(
            title: "Failed to get interests",
            body: decoded["message"] ?? decoded["error"]
        );
      }
    }catch (e){
      log("ERROR getting interests list : ${e.toString()}");
      rethrow;
    }
  }

}