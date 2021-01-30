import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:homesaaz/common/common_widget.dart';
import 'package:homesaaz/common/dependency_injection.dart';
import 'package:homesaaz/common/util.dart';
import 'package:homesaaz/model/cart_model.dart';
import 'package:homesaaz/model/dashboard_model.dart';
import 'package:homesaaz/model/home_model.dart';
import 'package:homesaaz/screen/home/home_screen.dart';
import 'package:homesaaz/service/rest_api.dart';

class HomeScreenViewModel {
  HomeScreenState state;

  DashBoardModel dashBoardModel;
  List<Category> categories;
  HomeScreenViewModel(HomeScreenState state) {
    this.state = state;
    dashBoardApi();
  }

  void dashBoardApi() async {

    await Future.delayed(const Duration(milliseconds: 200), () {
      showLoader(state.context);
    });

    final responseData = await RestApi.dahsBoardApi();

    try{
      Map<String, dynamic> jsonData = json.decode(responseData.body);
      if (responseData != null && jsonData['status'] == "error") {
        Utils.showToast(jsonData['error']);
      } else if (responseData != null) {
        dashBoardModel = dashBoardModelFromJson(responseData.body);

        Map<String, dynamic> body = {
          "uid": Injector.loginResponse.uid,
        };
        final cartModelRes = await RestApi.getCartItems(body);

        Map<String, dynamic> jsonData = json.decode(cartModelRes.body);
        if (cartModelRes != null && jsonData['status'] == "error") {
          Utils.showToast(jsonData['error']);
        } else if (cartModelRes != null) {
          Injector.updateCartData(cartModelFromJson(cartModelRes.body));
        }

        state.setState(() {});
      } else {
        Utils.showToast("Something went wrong");
      }
    }catch(e){
      print(e);
      Utils.showToast("Something went wrong");
    }

    hideLoader();
  }

}
