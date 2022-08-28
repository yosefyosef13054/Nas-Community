import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:async/async.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:developer';
import 'package:nas_academy/core/local_db/user/user_local_db.dart';
import 'package:nas_academy/core/modules/exceptions/server_error.dart';
import 'package:nas_academy/core/modules/user/sub/contact.dart';
import 'package:nas_academy/core/modules/user/sub/social_media.dart';
import 'package:nas_academy/core/modules/user/sub/soptlight.dart';
import 'package:nas_academy/core/modules/user/user.dart';
import 'package:nas_academy/core/utils/api.dart';
import 'package:nas_academy/core/utils/data_types.dart';


class EditProfile {
  final http.Client? client;
  const EditProfile({this.client});





  Future updateSpotlights (List<SpotLight> spotlights)async{
    try{
      http.Client profileClient = client ?? http.Client();
      final String token = await UserLocalDB.getToken();
      final _body = jsonEncode({
        "spotlights" : spotlights.map((e) => e.toMap()).toList(),
       });
      final http.Response response = await profileClient.patch(API.updateProfile, body: _body,headers: API.header(token));
      final decoded = jsonDecode(response.body);
      if(response.statusCode ~/100 == 2){
        final User? user = await UserLocalDB.currentUser();
        if(user != null){
          user.learner.spotlights = spotlights;
          await UserLocalDB.saveUser(user);
        }
      }else {
        throw ServerError<EditProfile>(
            title: "Failed update user profile",
            body: decoded["message"] ?? decoded["error"]
        );
      }
    }catch (e){
      log("ERROR updating profile : ${e.toString()}");
      rethrow;
    }
  }



  Future updateGeneralProfile ({String? profileImage, String? firstName, String? lastName, String? country})async{
    try{
      http.Client profileClient = client ?? http.Client();
      final String token = await UserLocalDB.getToken();
      final _body = jsonEncode({
        "country" : country,
        "firstName" : firstName ,
        "lastName" : lastName,
        "profileImage" : profileImage
      });
      final http.Response response = await profileClient.patch(API.updateProfile, body: _body,headers: API.header(token));
      final decoded = jsonDecode(response.body);

      if(response.statusCode ~/100 == 2){
        final User? user = await UserLocalDB.currentUser();
        if(user != null){
          user.learner.country = country;
          user.country = country;
          user.learner.firstName = firstName;
          user.learner.lastName = lastName;
          user.learner.profileImage = profileImage;
          await UserLocalDB.saveUser(user);
        }
      }else {
        throw ServerError<EditProfile>(
            title: "Failed update user profile",
            body: decoded["message"] ?? decoded["error"]
        );
      }
    }catch (e){
      log("ERROR updating profile : ${e.toString()}");
      rethrow;
    }
  }





  Future updateBio (String bio)async{
    try{
      http.Client profileClient = client ?? http.Client();
      final String token = await UserLocalDB.getToken();
      final _body = jsonEncode({
        "bio" : bio,
      });
      final http.Response response = await profileClient.patch(API.updateProfile, body: _body,headers: API.header(token));
      final decoded = jsonDecode(response.body);
      if(response.statusCode ~/100 == 2){
        final User? user = await UserLocalDB.currentUser();
        if(user != null){
          user.learner.bio = bio;
          await UserLocalDB.saveUser(user);
        }
      }else {
        throw ServerError<EditProfile>(
            title: "Failed update user profile",
            body: decoded["message"] ?? decoded["error"]
        );
      }
    }catch (e){
      log("ERROR updating profile : ${e.toString()}");
      rethrow;
    }
  }


  Future updateSkillsAndInterests (List<String> skills, List<String> interests)async{
    try{
      http.Client profileClient = client ?? http.Client();
      final String token = await UserLocalDB.getToken();
      final _body = jsonEncode({
        "skills" : skills,
        "interests" : interests
      });
      final http.Response response = await profileClient.patch(API.updateProfile, body: _body,headers: API.header(token));
      final decoded = jsonDecode(response.body);
      if(response.statusCode ~/100 == 2){
        final User? user = await UserLocalDB.currentUser();
        if(user != null){
          user.learner.skills = skills;
          user.learner.interests = interests;
          await UserLocalDB.saveUser(user);
        }
      }else {
        throw ServerError<EditProfile>(
            title: "Failed update user profile",
            body: decoded["message"] ?? decoded["error"]
        );
      }
    }catch (e){
      log("ERROR updating profile : ${e.toString()}");
      rethrow;
    }
  }


  Future<List<SocialMedia>> updateSocials (List<SocialMedia> socials, String followersCount)async{
    try{
      http.Client profileClient = client ?? http.Client();
      final String token = await UserLocalDB.getToken();
      final _body = jsonEncode({
        "socialMedia" : socials.map((e) => e.toMap()).toList(),
        "followersCount" : followersCount
      });
      final http.Response response = await profileClient.patch(API.updateProfile, body: _body,headers: API.header(token));
      final decoded = jsonDecode(response.body);
      if(response.statusCode ~/100 == 2){
        final List<dynamic> list = List.from(decoded["profile"]["socialMedia"] ?? []);
        List<SocialMedia> mediaList = list.map((e) => SocialMedia.fromMap(e)).toList();
        final User? user = await UserLocalDB.currentUser();
        if(user != null){
         user.learner.socialMedia = mediaList;
         user.learner.followersCount = int.tryParse(followersCount.toString());
          await UserLocalDB.saveUser(user);
        }
        return mediaList;
      }else {
        throw ServerError<EditProfile>(
            title: "Failed update user profile",
            body: decoded["message"] ?? decoded["error"]
        );
      }
    }catch (e){
      log("ERROR updating profile : ${e.toString()}");
      rethrow;
    }
  }



  Future updateContacts (List<Contact> contacts, String primaryContact)async{
    try{
      http.Client profileClient = client ?? http.Client();
      final String token = await UserLocalDB.getToken();
      final _body = jsonEncode({
        "contactUsernames" : contacts.map((e) => e.toMap()).toList(),
        "primaryContact" : primaryContact
      });
      final http.Response response = await profileClient.patch(API.updateProfile, body: _body,headers: API.header(token));
      final decoded = jsonDecode(response.body);
      if(response.statusCode ~/100 == 2){
        final User? user = await UserLocalDB.currentUser();
        if(user != null){
          user.learner.contactUsernames = contacts;
          user.learner.primaryContact = primaryContact;
          await UserLocalDB.saveUser(user);
        }
      }else {
        throw ServerError<EditProfile>(
            title: "Failed update user profile",
            body: decoded["message"] ?? decoded["error"]
        );
      }
    }catch (e){
      log("ERROR updating profile : ${e.toString()}");
      rethrow;
    }
  }



  Future<String> uploadImage (XFile image, UploadType type)async{
    try{
      final String token = await UserLocalDB.getToken();
      var stream =  http.ByteStream(DelegatingStream(image.openRead()).cast());
      var length = await image.length();
      var multipartFileSign = http.MultipartFile('photo', stream, length, filename: image.name, contentType: MediaType('image', 'jpeg'));
      var request =  http.MultipartRequest("POST", API.uploadPhoto,);
      request.files.add(multipartFileSign);
      request.fields['path'] = type.toString();
      request.fields['name'] = image.name;
      request.headers["Authorization"] = 'Bearer $token';
      final response = await request.send();
      final respStr = await response.stream.bytesToString();
      final decoded = jsonDecode(respStr);
      if(response.statusCode ~/100 == 2){
        return decoded["imageUrl"];
      }else {
        throw ServerError(
            title: "Failed to upload image",
            body: decoded["message"]
        );
      }
    }catch(e){
      log("ERROR uploading ${type.name} photo : ${e.toString()}");
      rethrow;
    }
  }



Future updatePhoneNumber (String phoneNumber)async{
  try{
    http.Client profileClient = client ?? http.Client();
    final String token = await UserLocalDB.getToken();
    final _body = jsonEncode({
      "phoneNumber" : phoneNumber,
    });
    final http.Response response = await profileClient.patch(API.updateProfile, body: _body,headers: API.header(token));
    final decoded = jsonDecode(response.body);
    if(response.statusCode ~/100 == 2){
      final User? user = await UserLocalDB.currentUser();
      if(user != null){
        user.learner.phoneNumber = phoneNumber;
        await UserLocalDB.saveUser(user);
      }
    }else {
      throw ServerError<EditProfile>(
          title: "Failed update phone number",
          body: decoded["message"] ?? decoded["error"]
      );
    }
  }catch (e){
    log("ERROR updating phone number : ${e.toString()}");
    rethrow;
  }
}



Future editPassword ({required String old, required String newPass, required String newPassConfirm})async{
  try{
    http.Client profileClient = client ?? http.Client();
    final String token = await UserLocalDB.getToken();
    final _body = jsonEncode({
      "oldPassword": old,
      "password": newPass,
      "password2": newPassConfirm
    });
    final http.Response response = await profileClient.post(API.resetPassword, body: _body,headers: API.header(token));
    final decoded = jsonDecode(response.body);
    if(response.statusCode ~/100 == 2){
      final User? user = await UserLocalDB.currentUser();
      if(user != null){
      }
    }else {
      throw ServerError<EditProfile>(
          title: "Failed update password",
          body: decoded["message"] ?? decoded["error"]
      );
    }
  }catch (e){
    log("ERROR updating password : ${e.toString()}");
    rethrow;
  }
}


}