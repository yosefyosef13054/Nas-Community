import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:nas_academy/core/modules/member/full_response.dart';
import 'package:nas_academy/core/local_db/user/user_local_db.dart';
import 'package:nas_academy/core/modules/exceptions/server_error.dart';
import 'package:nas_academy/core/utils/api.dart';

class MembersApi {
  final http.Client? client;
  const MembersApi({this.client});



  Future<MembersResponse> getMembers (String communityID)async{
    try{
      http.Client membersClient = client ?? http.Client();
      String token = await UserLocalDB.getToken();
      final http.Response response = await membersClient.get(API.members(communityID), headers: API.header(token));
      final decoded = jsonDecode(response.body);
      log("MEMERS RES : ${response.body}");
      if(response.statusCode ~/100 == 2){
        MembersResponse membersResponse =  MembersResponse.fromMap(decoded);
        return membersResponse;
      }else {
        throw ServerError<MembersApi>(
          title: "Failed to get members list",
          body: decoded["message"]
        );
      }
    }catch (e){
      log("ERROR getting members list : ${e.toString()}");
      rethrow;
    }
  }
}