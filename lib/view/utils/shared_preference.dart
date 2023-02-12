import 'dart:convert';
import 'dart:developer';

import 'package:shuttleservice/main.dart';
import 'package:shuttleservice/module/model/auth/login_model.dart';

class Storage {
  static String userData = 'UserData';

  static saveUser(LoginUserData? userModel) async {
    String json = jsonEncode(userModel?.toJson());
    log(json.toString(), name: "userData");
    await loginPreferences?.setString(userData, json.toString());
  }

  static getUser() {
    var userString = loginPreferences?.getString(userData);
    if (userString != null) {
      Map<String, dynamic> userMap = jsonDecode(userString);
      LoginUserData user = LoginUserData.fromJson(userMap);
      return user;
    } else {
      return null;
    }
  }

  static clearData() {
    return loginPreferences?.clear();
  }
}
