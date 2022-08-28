import 'package:dio/dio.dart' as dioo;
import 'package:shared_preferences/shared_preferences.dart';

class DioService {
  static const urlBase = 'https://api.dev-nasacademy.com/api/v1/mobile/';

  String apiToken = "";
  dioo.Dio dio = dioo.Dio();

  Future<DioService> init() async {
    dio.options.baseUrl = urlBase;
    dio.options.connectTimeout = 5000; //5s
    dio.options.receiveTimeout = 3000;
    return this;
  }

  Future<dioo.Response> postUrl(endPoint, body) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");

    return dio.post(urlBase + endPoint,
        data: body,
        options: dioo.Options(headers: {'Authorization': 'Bearer $token'}));
  }

  Future<dioo.Response> get(endPoint) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");

    return dio.get(urlBase + endPoint,
        options: dioo.Options(headers: {'Authorization': 'Bearer $token'}));
  }

//for uploading FormData with image
  Future<dioo.Response> postUrlUpload(endPoint, body,
      {required Function onSendProgress,
      required Function onRecieveProgress}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    apiToken = prefs.getString("token")!;

    return dio.post(urlBase + endPoint,
        data: body,
        options: dioo.Options(
            contentType: dioo.Headers.formUrlEncodedContentType,
            headers: {'Authorization': 'Bearer $apiToken'}));
  }
}
