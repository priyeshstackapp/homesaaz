import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:homesaaz/common/common_widget.dart';
import 'package:homesaaz/common/util.dart';
import 'package:homesaaz/model/address_model.dart';
import 'package:homesaaz/screen/address/address_screen.dart';
import 'package:homesaaz/service/rest_api.dart';

class AddressScreenViewModel {
  AddressScreenState state;
  //List<AddressModel> list = List();
  OverlayEntry loader;
  AddressModel addressModel;
  AddressScreenViewModel(AddressScreenState state) {
    this.state = state;
   // listOfData();
    addressListApi();
  }
  //Address Api
  void addressListApi() {
    FocusScope.of(state.context).unfocus();
    Map<String, dynamic> body = {
      "uid": '1'
    };
    Future.delayed(const Duration(milliseconds: 400), () {
      showLoader(state.context);
    });
    RestApi.addressListApi(body).then((responseData) {
      Map<String, dynamic> jsonData = json.decode(responseData.body);
      if (responseData != null && jsonData['status'] == "error") {
        Utils.showToast(jsonData['error']);
      } else if(responseData != null) {
        print(responseData);
        addressModel = addressModelFromJson(responseData.body);
        print(addressModel);
        state.setState(() {});
      } else {
        Utils.showToast("Some thing wrong");
      }
    }).catchError((e) {
      Utils.showToast(e.toString());
    }).whenComplete(() {
    });
  }

  //Delete Api
  void deleteAddressApiCall() {
    FocusScope.of(state.context).unfocus();
    Map<String, dynamic> body = {
      "uid": '1',
      "address_id" :'22'
    };
    Future.delayed(const Duration(milliseconds: 400), () {
      showLoader(state.context);
    });
    RestApi.deleteaddressApi(body).then((responseData) {
      Map<String, dynamic> jsonData = json.decode(responseData.body);
      if (responseData != null && jsonData['status'] == "error") {
        Utils.showToast(jsonData['error']);
      } else if(responseData != null) {
        print(responseData);
      } else {
        Utils.showToast("Some thing wrong");
      }
    }).catchError((e) {
      Utils.showToast(e.toString());
    }).whenComplete(() {
    });
  }

/*  listOfData() {
    list.add(AddressModel(
        "Shewrapara, Mirpur, Delhi-1216\nHouse no: 938\nRoad no: 9"));
    list.add(AddressModel("Chatkhil, Noakhali\nHouse no: 22\nRoad no: 7"));

  }*/
}
