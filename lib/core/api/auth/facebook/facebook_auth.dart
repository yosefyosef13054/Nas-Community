import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:nas_academy/core/modules/exceptions/ignored_error.dart';
import 'package:nas_academy/core/modules/exceptions/server_error.dart';

class Facebook {
  static final FacebookAuth _fb = FacebookAuth.instance;

  static Future<String> login ()async{
    await _fb.logOut();
    final LoginResult result = await _fb.login(); // by default we request the email and the public user_profile
    if (result.status == LoginStatus.success) {
      final AccessToken accessToken = result.accessToken!;
      return accessToken.token;
    }else {
      if(result.status != LoginStatus.cancelled){
        throw ServerError<Facebook>(
            body: result.message,
            title: "Failed to login with Facebook"
        );
      }else {
        throw IgnoredError();
      }
    }
  }



  static Future logOut ()async{
    await _fb.logOut();
  }
}