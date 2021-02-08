import 'dart:convert';

import 'package:homesaaz/common/common_widget.dart';
import 'package:homesaaz/common/dependency_injection.dart';
import 'package:homesaaz/common/util.dart';
import 'package:homesaaz/model/cart_model.dart';
import 'package:homesaaz/model/home_model.dart';
import 'package:homesaaz/screen/cart/cart_screen.dart';
import 'package:homesaaz/service/rest_api.dart';

class CartViewModel {
  CartScreenState state;

  CartViewModel(this.state){
    getCartData();
  }

  CartModel cartModel;

  getCartData({bool show = true}) async {

    Map<String, dynamic> body = {
      "uid": Injector.loginResponse.uid,
    };
    if(show){
      await Future.delayed(const Duration(milliseconds: 200), () {
        showLoader(state.context);
      });
    }
    RestApi.getCartItems(body).then((responseData) {
      Map<String, dynamic> jsonData = json.decode(responseData.body);
      if (responseData != null && jsonData['status'] == "error") {
        Utils.showToast(jsonData['error']);
      } else if (responseData != null) {
        cartModel = cartModelFromJson(responseData.body);
        state.setState(() {});
      } else {
        //Utils.showToast("Something went wrong");
      }
      if(show) {
        hideLoader();
      }
    }).catchError((e) {
      hideLoader();
      // Utils.showToast(e.toString());
    }).whenComplete(() {});
  }

  removeFromCart(CartProduct product) async {
    showLoader(state.context);
    Map<String, dynamic> body = {
      "uid": Injector.loginResponse.uid,
      "item_id" : product.itemid.toString(),
    };

    RestApi.removeFromCartApi(body).then((responseData) {
      hideLoader();
      Map<String, dynamic> jsonData = json.decode(responseData.body);
      if (responseData != null && jsonData['status'] == "error") {
        Utils.showToast(jsonData['error']);
      } else if (responseData != null) {
        cartModel.products.remove(product);
        Injector.updateCartData(cartModel);
        state.setState(() {});
        getCartData(show: false);
      } else {
        //Utils.showToast("Something went wrong");
      }
    }).catchError((e) {
      hideLoader();
      // Utils.showToast(e.toString());
    }).whenComplete(() {});
  }

  updateQuantity(CartProduct product,String action) async {
    showLoader(state.context);
    Map<String, dynamic> body = {
      "uid": Injector.loginResponse.uid,
      "item_id" : product.itemid.toString(),
      "action" : action
    };

    RestApi.updateProductQuantity(body).then((responseData) {
      hideLoader();
      Map<String, dynamic> jsonData = json.decode(responseData.body);
      if (responseData != null && jsonData['status'] == "error") {
        Utils.showToast(jsonData['error']);
      } else if (responseData != null) {
        getCartData(show: false);
      } else {
        //Utils.showToast("Something went wrong");
      }
    }).catchError((e) {
      hideLoader();
      // Utils.showToast(e.toString());
    }).whenComplete(() {});
  }

}