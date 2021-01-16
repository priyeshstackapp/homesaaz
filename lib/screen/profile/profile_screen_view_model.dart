import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:homesaaz/common/common_widget.dart';
import 'package:homesaaz/common/dependency_injection.dart';
import 'package:homesaaz/common/util.dart';
import 'package:homesaaz/model/profile_model.dart';
import 'package:homesaaz/screen/profile/profile_screen.dart';
import 'package:homesaaz/service/rest_api.dart';

class ProfileScreenViewModel {
  ProfileScreenState state;
  OverlayEntry loader;
  ProfileModel profileModel;

  ProfileScreenViewModel(ProfileScreenState state) {
    this.state = state;
    getProfileApi();

  }
  void getProfileApi() async {
    FocusScope.of(state.context).unfocus();
    Map<String, dynamic> body = {
      "uid": Injector.loginResponse.uid
    };
    await Future.delayed(const Duration(milliseconds: 200), () {
      showLoader(state.context);
    });
    RestApi.profileApi(body).then((responseData) {
      hideLoader();
      Map<String, dynamic> jsonData = json.decode(responseData.body);
      if (responseData != null && jsonData['status'] == "error") {
        Utils.showToast(jsonData['error']);
      } else if(responseData != null) {
        print(responseData);
        profileModel = profileModelFromJson(responseData.body);
        print(profileModel);
        state.setState(() {});
      } else {
      //  Utils.showToast("Something went wrong");
      }
    }).catchError((e) {
      hideLoader();
     // Utils.showToast(e.toString());
    }).whenComplete(() {
    });
  }
}
