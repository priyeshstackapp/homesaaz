import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:homesaaz/common/common_widget.dart';
import 'package:homesaaz/common/util.dart';
import 'package:homesaaz/model/dashboard_model.dart';
import 'package:homesaaz/model/home_model.dart';
import 'package:homesaaz/screen/home/home_screen.dart';
import 'package:homesaaz/service/rest_api.dart';

class HomeScreenViewModel {
  HomeScreenState state;

  DashBoardModel dashBoardModel;
  HomeScreenViewModel(HomeScreenState state) {
    this.state = state;
    dashBoardApi();
  }

  void dashBoardApi() async {

    await Future.delayed(const Duration(milliseconds: 200), () {
      showLoader(state.context);
    });

      RestApi.dahsBoardApi().then((responseData) {
        hideLoader();
        Map<String, dynamic> jsonData = json.decode(responseData.body);
        if (responseData != null && jsonData['status'] == "error") {
          Utils.showToast(jsonData['error']);
        } else if(responseData != null) {
          print(responseData);
          dashBoardModel = dashBoardModelFromJson(responseData.body);
          print(dashBoardModel);
          state.setState(() {});
        } else {
          Utils.showToast("Something went wrong");
        }
      }).catchError((e) {
        hideLoader();
        Utils.showToast(e.toString());
      });
  }

}
