import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:nas_academy/core/api/auth/apple/apple.dart';
import 'package:nas_academy/core/api/auth/auth.dart';
import 'package:nas_academy/core/api/auth/facebook/facebook_auth.dart';
import 'package:nas_academy/core/api/auth/google/google.dart';
import 'package:nas_academy/core/api/community/community.dart';
import 'package:nas_academy/core/local_db/user/user_local_db.dart';
import 'package:nas_academy/core/modules/user/user.dart';
import 'package:nas_academy/core/providers/dash/dash_provider.dart';
import 'package:nas_academy/core/utils/data_types.dart';
import 'package:nas_academy/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late PageController _registerPageController;
  int _registerIndex = 0;
  final Auth _auth = Auth();
  String _loginEmail = "";
  String _loginPassword = "";
  bool _loading = false;
  String? _error;
  String _registerEmail = "";
  String _registerName = "";
  String _registerPass = "";
  String _registerConfirmPass = "";

  int get registerIndex => _registerIndex;

  set setRegisterIndex(int value) {
    _registerIndex = value;
    notifyListeners();
  }

  PageController get registerPageController => _registerPageController;

  set setRegisterPageController(PageController value) {
    _registerPageController = value;
  }

  String get loginEmail => _loginEmail;

  set setLoginEmail(String value) {
    _loginEmail = value;
    notifyListeners();
  }

  String get loginPassword => _loginPassword;

  set setLoginPassword(String value) {
    _loginPassword = value;
    notifyListeners();
  }

  String? get error => _error;

  set setError(String? value) {
    _error = value;
    notifyListeners();
  }

  bool get loading => _loading;

  set setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  final CommunityApi community = CommunityApi();

  Future loginWithEmailAndPassword(BuildContext context, DashProvider dashProvider) async {
    setError = null;
    if (formKey.currentState!.validate()) {
      try {
        FocusScope.of(context).unfocus();
        setLoading = true;
        User user = await _auth.login(email: _loginEmail, password: _loginPassword);
        formKey.currentState!.validate();
        await dashProvider.init();
        await UserLocalDB.saveUser(user);
        Restart.restartApp(context);
        setLoading = false;
      } catch (e) {
        await logOut();
        setLoading = false;
        setError = e.toString();
        formKey.currentState!.validate();
        rethrow;
      }
    }
  }


  Future signUpWithEmailAndPassword(BuildContext context) async {
    try {
      FocusScope.of(context).unfocus();
      setLoading = true;
      await _auth.register(name: registerName, email: registerEmail, pass: registerPass, passTwo: registerConfirmPass);
      setLoading = false;
    } catch (e) {
      setLoading = false;
      await logOut();
      rethrow;
    }
  }


  Future<String> getToken(AuthType provider) async {
    switch (provider) {
      case AuthType.facebook:
        {
          String token = await Facebook.login();
          return token;
        }
      case AuthType.google:
        {
          String token = await Google.login();
          return token;
        }
      case AuthType.apple:
        {
          String token = await Apple.login();
          return token;
        }
      case AuthType.email:
        {
          return "";
        }
    }
  }


  Future logOut ()async{
    await Google.logOut();
    await Facebook.logOut();
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.clear();
  }


  Future socialLogin(BuildContext context, AuthType provider, DashProvider dashProvider) async {
    setError = null;
    try {
      String authToken = await getToken(provider);
      FocusScope.of(context).unfocus();
      setLoading = true;
      String accessToken = await _auth.getToken(provider: provider, token: authToken);
      User user = await _auth.getUserProfile(accessToken);
      await dashProvider.init();
      await UserLocalDB.saveUser(user);
      Restart.restartApp(context);
      setLoading = false;
    } catch (e) {
      await logOut();
      setLoading = false;
      log(e.toString());
      rethrow;
    }
  }

  String get registerConfirmPass => _registerConfirmPass;

  set setRegisterConfirmPass(String value) {
    _registerConfirmPass = value;
    notifyListeners();
  }

  String get registerPass => _registerPass;

  set setRegisterPass(String value) {
    _registerPass = value;
    notifyListeners();
  }

  String get registerName => _registerName;

  set setRegisterName(String value) {
    _registerName = value;
    notifyListeners();

  }

  String get registerEmail => _registerEmail;

  set setRegisterEmail(String value) {
    _registerEmail = value;
    notifyListeners();
  }

}
