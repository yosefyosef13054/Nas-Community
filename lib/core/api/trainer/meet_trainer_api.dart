
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:nas_academy/core/local_db/user/user_local_db.dart';
import 'package:nas_academy/core/modules/exceptions/server_error.dart';
import 'package:nas_academy/core/modules/trainer_booking/trainer_booking.dart';
import 'dart:developer';

import 'package:nas_academy/core/utils/api.dart';


class TrainerAPI {
  http.Client? client;

  TrainerAPI({this.client});


  Future<TrainerBooking> fetchLatestBooking (String communityID)async{
    try{
      http.Client trainerClient = client ?? http.Client();
      final String token = await UserLocalDB.getToken();
      http.Response response = await trainerClient.get(API.fetchLatestBooking(communityID), headers: API.header(token));
      final decoded = jsonDecode(response.body);
     if(response.statusCode ~/100 == 2){
       if(decoded != null){
         return TrainerBooking.fromMap(decoded);
       }else {
         return TrainerBooking(status: "NONE");
       }
      }else {
        throw ServerError<TrainerAPI>(
          title: "Failed to get booking data",
          body: decoded["message"]
        );
      }
    }catch (e){
      log("ERROR fetching latest booking : ${e.toString()}");
      rethrow;
    }
  }


  Future<TrainerBooking> cancelLatestBooking (String communityID)async{
    try{
      http.Client trainerClient = client ?? http.Client();
      final String token = await UserLocalDB.getToken();
      http.Response response = await trainerClient.put(API.cancelBooking(communityID), headers: API.header(token), body: jsonEncode({}));
      final decoded = jsonDecode(response.body);
      if(response.statusCode ~/100 == 2){
        return TrainerBooking.fromMap(decoded);
      }else {
        throw ServerError<TrainerAPI>(
            title: "Failed to cancel booking ",
            body: decoded["message"]
        );
      }
    }catch (e){
      log("ERROR canceling booking : ${e.toString()}");
      rethrow;
    }
  }



}