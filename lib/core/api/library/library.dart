import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nas_academy/core/local_db/user/user_local_db.dart';
import 'package:nas_academy/core/modules/exceptions/server_error.dart';
import 'package:nas_academy/core/modules/library/class/video.dart';
import 'package:nas_academy/core/modules/library/class/video_preview.dart';
import 'package:nas_academy/core/modules/library/resource/resource_preview.dart';
import 'package:nas_academy/core/modules/library/resource/video_resource.dart';
import 'dart:developer';
import 'package:nas_academy/core/utils/api.dart';

class LibraryAPIs {
  final http.Client? client;
  const LibraryAPIs({this.client});


  Future<List<VideoPreview>> getClassPreviews ({required String communityID})async{
    try{
      http.Client libraryClient = client ?? http.Client();
      final String token = await UserLocalDB.getToken();
      final http.Response response = await libraryClient.get(API.videoPreview(communityID), headers: API.header(token));
     final decoded = jsonDecode(response.body);
      if(response.statusCode ~/100 == 2){
        final List<dynamic> list = List.from(decoded);
       return list.map((e) => VideoPreview.fromMap(e)).toList();
     }else {
       throw ServerError<LibraryAPIs>(
         title: "Failed to get video previews",
         body: decoded["message"] ?? decoded["error"]
       );
     }
    }catch (e){
      log("ERROR getting class preview : ${e.toString()}");
      rethrow;
    }
  }


  Future<List<ResourcePreview>> getResourcePreviews ({required String communityID})async{
    try{
      http.Client libraryClient = client ?? http.Client();
      final String token = await UserLocalDB.getToken();
      final http.Response response = await libraryClient.get(API.resourcesPreview(communityID), headers: API.header(token));
      final decoded = jsonDecode(response.body);
      if(response.statusCode ~/100 == 2){
        final List<dynamic> list = List.from(decoded);
        return list.map((e) => ResourcePreview.fromMap(e)).toList();
      }else {
        throw ServerError<LibraryAPIs>(
            title: "Failed to get resource previews",
            body: decoded["message"] ?? decoded["error"]
        );
      }
    }catch (e){
      log("ERROR getting resource preview : ${e.toString()}");
      rethrow;
    }
  }


  Future<List<VideoResource>> getResources ({required String communityID})async{
    try{
      http.Client libraryClient = client ?? http.Client();
      final String token = await UserLocalDB.getToken();
      final http.Response response = await libraryClient.get(API.resources(communityID), headers: API.header(token));
      final decoded = jsonDecode(response.body);
      if(response.statusCode ~/100 == 2){
        final List<dynamic> list = List.from(decoded);
        return list.map((e) => VideoResource.fromMap(e)).toList();
      }else {
        throw ServerError<LibraryAPIs>(
            title: "Failed to get video resources",
            body: decoded["message"] ?? decoded["error"]
        );
      }
    }catch (e){
      log("ERROR getting video resource: ${e.toString()}");
      rethrow;
    }
  }


  Future<List<VideoClass>> getVideoClasses ({required String communityID})async{
    try{
      http.Client libraryClient = client ?? http.Client();
      final String token = await UserLocalDB.getToken();
      final http.Response response = await libraryClient.get(API.videos(communityID), headers: API.header(token));
      final decoded = jsonDecode(response.body);
      log("VIDS : ${response.body}");
      if(response.statusCode ~/100 == 2){
        final List<dynamic> list = List.from(decoded);
        return list.map((e) => VideoClass.fromMap(e)).toList();
      }else {
        throw ServerError<LibraryAPIs>(
            title: "Failed to get video classes",
            body: decoded["message"] ?? decoded["error"]
        );
      }
    }catch (e){
      log("ERROR getting video classes: ${e.toString()}");
      rethrow;
    }
  }

}