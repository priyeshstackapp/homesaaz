import 'dart:io';
import 'dart:convert';
import 'package:homesaaz/common/prefkeys.dart';
import 'package:homesaaz/model/login_ref_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Injector {

  static File profileImage;
  static SharedPreferences sharedPreferences;
  static LoginResponseModel loginResponse;
  // static LoginRequest loginRequest;

  static getInstance() async {
    sharedPreferences = await SharedPreferences.getInstance();
    getUserData();

  }

  // static setLoginRequest(LoginResponseModel loginReq) async {
  //   await Injector.sharedPreferences.setString(PrefKeys.loginRequest, jsonEncode(loginReq.toJson()));
  //   // loginRequest = loginReq;
  // }

//  static updateUserData(UserData userData) async {
  static updateUserData(LoginResponseModel userData) async {
    await Injector.sharedPreferences.setString(PrefKeys.user, jsonEncode(userData.toJson()));
    loginResponse = userData;
  }

  static getUserData() {
    if (sharedPreferences.getString(PrefKeys.user) != null &&
        sharedPreferences.getString(PrefKeys.user).isNotEmpty) {
      loginResponse = LoginResponseModel.fromJson(jsonDecode(sharedPreferences.getString(PrefKeys.user)));
    }
  }

}
