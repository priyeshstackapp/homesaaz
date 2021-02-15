import 'dart:convert';

import 'package:homesaaz/common/common_widget.dart';
import 'package:homesaaz/common/dependency_injection.dart';
import 'package:homesaaz/common/util.dart';
import 'package:homesaaz/model/cart_model.dart';
import 'package:homesaaz/model/wish_model.dart';
import 'package:homesaaz/screen/wish/wish_screen.dart';
import 'package:homesaaz/service/rest_api.dart';

class WishViewModel {
  WishScreenState state;

  WishViewModel(this.state){
    getWishData();
  }

  WishModel wishModel;

  getWishData({bool show = true}) async {

    Map<String, dynamic> body = {
      "uid": Injector.loginResponse.uid,
    };
    if(show){
      await Future.delayed(const Duration(milliseconds: 200), () {
        showLoader(state.context);
      });
    }
    RestApi.getWishListApi(body).then((responseData) {
      Map<String, dynamic> jsonData = json.decode(responseData.body);
      if (responseData != null && jsonData['status'] == "error") {
        Utils.showToast(jsonData['error']);
      } else if (responseData != null) {
        wishModel = wishModelFromJson(responseData.body);
        state.setState(() {});
      } else {
        Utils.showToast("Something went wrong");
      }
      if(show) {
        hideLoader();
      }
    }).catchError((e) {
      hideLoader();
      // Utils.showToast(e.toString());
    }).whenComplete(() {});
  }

  removeFromCart(String id) async {
    showLoader(state.context);
    Map<String, dynamic> body = {
      "uid": Injector.loginResponse.uid,
      "item_id" : id,
    };

    RestApi.removeWishApi(body).then((responseData) {
      hideLoader();
      Map<String, dynamic> jsonData = json.decode(responseData.body);
      if (responseData != null && jsonData['status'] == "error") {
        Utils.showToast(jsonData['error']);
      } else if (responseData != null) {
        getWishData(show: false);
      } else {
        Utils.showToast("Something went wrong");
      }
    }).catchError((e) {
      hideLoader();
      // Utils.showToast(e.toString());
    }).whenComplete(() {});
  }

  addToCart(String id,int count) async {
    showLoader(state.context);
    Map<String, dynamic> body = {
      "uid": Injector.loginResponse.uid,
      "item_id" : id,
      "qnty" : "$count"
    };

    var responseData = await RestApi.addToCartApi(body);

    hideLoader();
    Map<String, dynamic> jsonData = json.decode(responseData.body);
    if (responseData != null && jsonData['status'] == "error") {
      Utils.showToast(jsonData['error']);
    } else if (responseData != null) {
      Utils.showToast("Added to cart");
      await removeFromCart(id);
      getCartData();
    } else {
      //Utils.showToast("Something went wrong");
    }
  }

  getCartData() async {

    Map<String, dynamic> body = {
      "uid": Injector.loginResponse.uid,
    };
    // showLoader(state.context);
    try{
      var responseData = await RestApi.getCartItems(body);
      // hideLoader();
      Map<String, dynamic> jsonData = json.decode(responseData.body);
      if (responseData != null && jsonData['status'] == "error") {
        Utils.showToast(jsonData['error']);
      } else if (responseData != null) {
        Injector.updateCartData(cartModelFromJson(responseData.body));
        return cartModelFromJson(responseData.body);
      } else {
        return null;
      }
    }catch(e){
      print(e);
      hideLoader();
      Utils.showToast(e.toString());
      return null;
    }

  }

}