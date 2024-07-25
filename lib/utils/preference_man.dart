import 'dart:core';

import 'package:shared_preferences/shared_preferences.dart';

class PreferenceMan {
  static late SharedPreferences _sharedPrefs;

  Future<bool> init() async {
    _sharedPrefs = await SharedPreferences.getInstance();
    return true;
  }

  void saveUserLogin(bool isUserLoging) {
    _sharedPrefs.setBool("IS_USER_LOGIN", isUserLoging);
  }

  bool? isUserLogin() {
    return _sharedPrefs.getBool("IS_USER_LOGIN");
  }

  void setUserName(String UserName) {
    _sharedPrefs.setString("USER_NAME", UserName);
  }

  String? getUserName() {
    return _sharedPrefs.getString("USER_NAME");
  }

  void setPassword(String Password) {
    _sharedPrefs.setString("PASSWORD", Password);
  }

  String? getPassword() {
    return _sharedPrefs.getString("PASSWORD");
  }

  void setUserUid(String uid) {
    _sharedPrefs.setString("uid", uid);
  }

  String? getuid() {
    return _sharedPrefs.getString("uid");
  }

  void clearPreferences() {
    saveUserLogin(false);
    // _sharedPrefs.clear();
  }
}
