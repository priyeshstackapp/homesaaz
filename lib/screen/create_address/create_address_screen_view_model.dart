import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:homesaaz/common/common_widget.dart';
import 'package:homesaaz/common/dependency_injection.dart';
import 'package:homesaaz/common/util.dart';
import 'package:homesaaz/model/address_model.dart';
import 'package:homesaaz/model/edit_address_model.dart';
import 'package:homesaaz/screen/create_address/create_address_screen.dart';
import 'package:homesaaz/service/rest_api.dart';

class CreateAddressScreenViewModel {
  CreateAddressScreenState state;
  EditAddressModel editAddressModel;
  FullAddressModel fullAddressModel;
  CreateAddressScreenViewModel(CreateAddressScreenState state) {
    this.state = state;
    if(state.widget.edit){
      getFullAddress();
    }
  }

  void addEditAddressListApi(bool edit, {String id}) async {

    Map<String, dynamic> body;
    if(edit){
      body = {
        "uid": Injector.loginResponse.uid,
        "address_id": id,
        "address": state.addressCont.text,
        "flat": state.houseNoCont.text,
        "landmark": state.landmarkCont.text,
        "mobile": state.mobileCont.text,
        "state": state.stateCont.text,
        "city": state.cityCont.text,
        "pincode": state.postalCodeCont.text,
      };
    }else{
      body = {
        "uid": Injector.loginResponse.uid,
        "address": state.addressCont.text,
        "flat": state.houseNoCont.text,
        "landmark": state.landmarkCont.text,
        "mobile": state.mobileCont.text,
        "state": state.stateCont.text,
        "city": state.cityCont.text,
        "pincode": state.postalCodeCont.text,
      };
    }
    await Future.delayed(const Duration(milliseconds: 200), () {
      showLoader(state.context);
    });
    RestApi.addEditAddressApi(body).then((responseData) {
      hideLoader();
      Map<String, dynamic> jsonData = json.decode(responseData.body);
      if (responseData != null && jsonData['status'] == "error") {
        Utils.showToast(jsonData['error']);
      } else if (responseData != null) {
        Navigator.pop(state.context,'yes');
      } else {
        //Utils.showToast("Something went wrong");
      }
    }).catchError((e) {
      hideLoader();
     // Utils.showToast(e.toString());
    }).whenComplete(() {});
  }

  getFullAddress() async {
    var body = {
      "uid": Injector.loginResponse.uid,
      "address_id": state.widget.addressData.addressId,
    };

    await Future.delayed(const Duration(milliseconds: 200), () {
      showLoader(state.context);
    });

    RestApi.getCompleteDetailsOfAddressApi(body).then((responseData) {
      hideLoader();
      Map<String, dynamic> jsonData = json.decode(responseData.body);
      if (responseData != null && jsonData['status'] == "error") {
        Utils.showToast(jsonData['error']);
      } else if (responseData != null) {
        fullAddressModel = fullAddressModelFromJson(responseData.body);
        state.houseNoCont.text = fullAddressModel.flat;
        state.addressCont.text = fullAddressModel.address;
        state.cityCont.text = fullAddressModel.city;
        state.stateCont.text = fullAddressModel.state;
        state.postalCodeCont.text = fullAddressModel.pincode;
        state.mobileCont.text = fullAddressModel.mobile;
        state.landmarkCont.text = fullAddressModel.landmark;
        state.setState(() {

        });
      } else {
        //Utils.showToast("Something went wrong");
      }
    }).catchError((e) {
      hideLoader();
      // Utils.showToast(e.toString());
    }).whenComplete(() {});
  }

}
