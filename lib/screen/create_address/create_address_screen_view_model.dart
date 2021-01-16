import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:homesaaz/common/common_widget.dart';
import 'package:homesaaz/common/dependency_injection.dart';
import 'package:homesaaz/common/util.dart';
import 'package:homesaaz/model/edit_address_model.dart';
import 'package:homesaaz/screen/create_address/create_address_screen.dart';
import 'package:homesaaz/service/rest_api.dart';

class CreateAddressScreenViewModel {
  CreateAddressScreenState state;
  EditAddressModel editAddressModel;
  CreateAddressScreenViewModel(CreateAddressScreenState state) {
    this.state = state;
   // addEditAddressListApi();
  }

  void addEditAddressListApi() async {

    Map<String, dynamic> body = {
      "uid": Injector.loginResponse.uid,
      "address_id": '',
      "address": state.addressCont.text,
      "flat": state.addressCont.text,
      "landmark": state.addressCont.text,
      "mobile": state.mobileCont.text,
      "city": state.cityCont.text,
      "state": state.cityCont.text,
      "pincode": state.postalCodeCont.text,
    };
    await Future.delayed(const Duration(milliseconds: 200), () {
      showLoader(state.context);
    });
    RestApi.addEditAddressApi(body).then((responseData) {
      hideLoader();
      Map<String, dynamic> jsonData = json.decode(responseData.body);
      if (responseData != null && jsonData['status'] == "error") {
        Utils.showToast(jsonData['error']);
      } else if (responseData != null) {
        print(responseData);
       editAddressModel = editAddressModelFromJson(responseData.body);
        state.setState(() {});
      } else {
        //Utils.showToast("Something went wrong");
      }
    }).catchError((e) {
      hideLoader();
     // Utils.showToast(e.toString());
    }).whenComplete(() {});
  }

}
