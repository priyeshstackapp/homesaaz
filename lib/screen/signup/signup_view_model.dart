import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:homesaaz/common/common_widget.dart';
import 'package:homesaaz/screen/signup/signup_screen.dart';
import 'package:homesaaz/service/rest_api.dart';

class SignUpViewModel {
  SignUpScreenState state;

  OverlayEntry loader;

  bool validateForm = false;

  // SignUpViewModel(this.state);

  SignUpViewModel(SignUpScreenState state) {
    this.state = state;
    // loader = LoaderShowHide.overlayLoader(state.context);
  }

  bool validate() {
   /* if (state.userIdCont.text == '') {
      showSnackBar(state.scaffoldKey,'Enter username',isError: true);
      return false;
    }else*/
     /* if (state.firstNameController.text == '') {
      showSnackBar(state.loginKey,'Enter name',isError: true);
      // validateForm = false;
      return false;
    } else if (state.emailController.text == '') {
      showSnackBar(state.loginKey,'Enter email',isError: true);
      // validateForm = false;
      return false;
    } else if (!isEmail(state.emailController.text.trim())) {
      showSnackBar(state.loginKey,'Enter valid email',isError: true);
      // validateForm = false;
      return false;
    } else if (state.passwordCont.text == '') {
      showSnackBar(state.loginKey,'Enter password',isError: true);
      // validateForm = false;
      return false;
    }*/

     // validateForm = true;
     return true;

  }

  bool isEmail(String em) {

    String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(em);
  }
  

  void registerApi() async {
    FocusScope.of(state.context).unfocus();

    Map<String, dynamic> body = {
      "first_name": state.firstNameController.text,
      "last_name": state.lastNameController.text,
      "mobileno": state.mobileController.text,
      "email": state.emailController.text,
      "password": state.passwordCont.text,
      "conf_password": state.conformPasswordController.text
    };

    if (validate()) {
    // if (state.loginKey.currentState.validate()) {
      // loginFormKey.currentState.save();
      // Overlay.of(state.context).insert(loader);
      showLoader(state.context);
      RestApi.signUp(body).then((responseData) {
        // hideLoader();
        Map<String, dynamic> jsonData = json.decode(responseData.body);
        if (responseData != null && jsonData['status'] == "success") {
          print(responseData);
          // Navigator.of(loginKey.currentContext).pushReplacementNamed('/Pages', arguments: 1);
        } else if(responseData != null && jsonData['status'] == "error") {
          showSnackBar(state.loginKey, jsonData['error'], isError: true);
          // Html(data: jsonData['status']).toString()
        } else {
          showSnackBar(state.loginKey, 'Some thing wrong', isError: true);
        }
      }).catchError((e) {
        hideLoader();
        showSnackBar(state.loginKey, e.toString(), isError: true);
      }).whenComplete(() {
        hideLoader();
      });
    } else {
      hideLoader();
      validateForm = false;
      print("some error");
      state.setState((){});
    }
  }


}