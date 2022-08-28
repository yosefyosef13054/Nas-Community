import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:nas_academy/core/local_db/user/user_local_db.dart';
import 'package:nas_academy/core/modules/application/application_config.dart';
import 'package:nas_academy/core/modules/application/application_status.dart';
import 'package:nas_academy/core/modules/exceptions/server_error.dart';
import 'package:nas_academy/core/utils/api.dart';
import 'package:nas_academy/core/utils/data_types.dart';


class ApplicationConfigsAPI {
  final http.Client? client;

  ApplicationConfigsAPI({this.client});

  Future<List<ApplicationConfig>> getCommunityApplicationConfigs(
      String communityCode) async {
    try {
      http.Client applicationClient = client ?? http.Client();
      final String token = await UserLocalDB.getApplicationToken();
      final http.Response response = await applicationClient.get(
          API.applicationConfigs(communityCode),
          headers: API.header(token));
      final decoded = jsonDecode(response.body);
      
      if (response.statusCode ~/ 100 == 2) {
        final List<dynamic> list = List.from(decoded["data"]["mobileApplicationConfigDataFields"]);
        List<ApplicationConfig> configs =  list.map((e) => ApplicationConfig.fromMap(e)).toList();
        for (var element in configs) {
          if(element.inputSectionKey == InputType.checkbox){
            element.inputSectionKey = InputType.multiSelectModal;
          }
        }
        return configs;
      } else {
        throw ServerError<ApplicationConfigsAPI>(
            title: "Failed to community application form",
            body: decoded["message"] ?? decoded["error"]);
      }
    } catch (e) {
      log("ERROR getting  community application form : ${e.toString()}");
      rethrow;
    }
  }

  Future<bool> submitApplication(List<ApplicationConfig> configs, String communityCode) async {
    try {
      http.Client applicationClient = client ?? http.Client();
      final String token = await UserLocalDB.getApplicationToken();
      Map<String, dynamic> applicationData = {};
      for (ApplicationConfig config in configs) {
        if (config.value is String ||
            config.value is int ||
            config.value is double ||
            config.value is bool) {
          applicationData[config.fieldName!] = config.value;
        } else if (config.value is Iterable<MultiSelectOption>) {
          Map<String, bool> selections = {};
          for (MultiSelectOption option in config.value) {
            selections[option.value] = true;
          }
          applicationData[config.fieldName!] = selections;
        }
      }
      final body = jsonEncode({
        "communityCode": communityCode,
        "applicationData": applicationData,
      });
      final http.Response response = await applicationClient.post(
          API.communityEnrolmentApplication,
          body: body,
          headers: API.header(token));
      final decoded = jsonDecode(response.body);
      if (response.statusCode ~/ 100 == 2) {
        return true;
      } else {
        throw ServerError<ApplicationConfigsAPI>(
            title: "Failed to submit community application form",
            body: decoded["message"] ?? decoded["error"]);
      }
    } catch (e) {
      log("ERROR submitting  community application form : ${e.toString()}");
      rethrow;
    }
  }

  Future<List<ApplicationStatus>> getApplicationStatus() async {
    try {
      http.Client applicationClient = client ?? http.Client();
      final String token = await UserLocalDB.getToken();
      final http.Response response = await applicationClient.get(API.applicationStatus, headers: API.header(token));
      final Map<String, dynamic> decoded = Map.from(jsonDecode(response.body));
      if (response.statusCode ~/ 100 == 2) {
        List<ApplicationStatus> statusList = [];
        decoded.forEach((key, value) {
          statusList.add(ApplicationStatus.fromMap(value, key));
        });
        return statusList;
      } else {
        throw ServerError<ApplicationConfigsAPI>(
            title: "Failed to get application status",
            body: decoded["message"] ?? decoded["error"]);
      }
    } catch (e) {
      log("ERROR getting  application status: ${e.toString()}");
      rethrow;
    }
  }



  Future<bool> verifyPayment(Map<String, dynamic> receipt) async {
    try {
      http.Client applicationClient = client ?? http.Client();
      final String token = await UserLocalDB.getApplicationToken();
      final body = jsonEncode({
        "receipt" : receipt,
      });
      log("VERIFY BODY : $body");
      log("URL : ${API.validateReceipt.toString()}");
      final http.Response response = await applicationClient.post(API.validateReceipt, body: body,headers: API.header(token));
     final decoded = jsonDecode(response.body);
     log("VERIFY RESPONSE : ${response.body}");
      if (response.statusCode ~/ 100 == 2) {
        return decoded["isValid"] == true;
       } else {
        throw ServerError<ApplicationConfigsAPI>(
            title: "Failed to VERIFY Payment",
            body: decoded["message"] ?? decoded["error"]);
      }
    } catch (e) {
      log("ERROR VERIFY Payment: ${e.toString()}");
      rethrow;
    }
  }
}
