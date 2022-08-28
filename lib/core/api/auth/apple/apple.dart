import 'package:nas_academy/core/utils/env.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class Apple {

  static Future<String> login() async {
    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      webAuthenticationOptions: WebAuthenticationOptions(
          clientId: Dev.appleClientID,
          redirectUri: Uri.parse(Dev.appleRedirectUrl)),
    );
    return credential.authorizationCode;
  }
}






Map<String, dynamic> creds (AuthorizationCredentialAppleID cred){
  return {
    "identityToken" : cred.identityToken,
    "authorizationCode" : cred.authorizationCode,
    "email" : cred.email,
    "familyName" : cred.familyName,
    "givenName" : cred.givenName,
    "state" : cred.state,
    "userIdentifier" : cred.userIdentifier,
  };
}