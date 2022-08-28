import 'dart:developer';
import 'dart:io';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nas_academy/core/modules/exceptions/ignored_error.dart';
import 'package:nas_academy/core/modules/exceptions/server_error.dart';
import 'package:nas_academy/core/utils/env.dart';

class Google {

  static Future<String> login ()async{
    try {
      final GoogleSignIn _google = GoogleSignIn(
        clientId: Platform.isAndroid? Dev.googleWebClientID : null,
      );
      if(await _google.isSignedIn()){
        await _google.signOut();
      }
      final GoogleSignInAccount? result = await _google.signIn();
      if (result != null) {
        final authentication = await result.authentication;
        return authentication.idToken!;
      } else {
        throw IgnoredError<Google>();
      }
    } catch (e) {
      log("ERROR Sign in with google : ${e.toString()}");
      rethrow;
    }

  }




  static Future logOut() async {
    try {
      await GoogleSignIn().signOut();
    } catch (e) {
      throw ServerError<Google>(title: "Failed to log out", body: e.toString());
    }
  }
}
