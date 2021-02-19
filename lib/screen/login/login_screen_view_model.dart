import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:homesaaz/common/common_route.dart';
import 'package:homesaaz/common/common_widget.dart';
import 'package:homesaaz/common/dependency_injection.dart';
import 'package:homesaaz/model/login_ref_model.dart';
import 'package:homesaaz/screen/home/home_screen.dart';
import 'package:homesaaz/screen/login/login_screen.dart';
import 'package:homesaaz/service/rest_api.dart';

class LoginScreenViewModel {
  LoginScreenState state;
  OverlayEntry loader;

  bool validateForm = false;
  LoginScreenViewModel(this.state);

  void loginApi() async {
    FocusScope.of(state.context).unfocus();

    Map<String, dynamic> body = {
      "login_username": state.emailCont.text,
      "login_password": state.passwordCont.text,
      "login_using" :'email',
    };
    if (validate()) {
      showLoader(state.context);
      RestApi.logIn(body).then((responseData) async {
        Map<String, dynamic> jsonData = json.decode(responseData.body);
        if (responseData != null && jsonData['status'] == "success") {
         // gotoHomeScreen(state.context);
          print(responseData);
          LoginResponseModel loginResponse = LoginResponseModel.fromJson(jsonData);
          await Injector.updateUserData(loginResponse);
          // await Injector.setLoginRequest(loginRequest);
          if(state.widget.isBack){
            Navigator.pop(state.context);
          }else{
            gotoHomeScreenUntilRemove(state.context);
          }
        } else if(responseData != null && jsonData['status'] == "error") {
          showSnackBar(state.loginKey, jsonData['error'], isError: true);
        } else {
          showSnackBar(state.loginKey, 'Something went wrong', isError: true);
        }
      }).catchError((e) {
        hideLoader();
        showSnackBar(state.loginKey, e.toString(), isError: true);
      }).whenComplete(() {
        // hideLoader();
      });
    } else {
      hideLoader();
      validateForm = false;
      print("some error");
      state.setState((){});
    }
  }

  bool validate() {
    if (state.emailCont.text == '') {
      showSnackBar(state.loginKey, 'Enter  valid email', isError: true);
      return false;
    } else if (!isEmail(state.emailCont.text.trim())) {
      showSnackBar(state.loginKey,'Enter valid email',isError: true);
      return false;
    }else if (state.passwordCont.text == '') {
      showSnackBar(state.loginKey, 'Enter password', isError: true);
      return false;
    }
     return true;
  }
  bool isEmail(String em) {

    String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(em);
  }
}
