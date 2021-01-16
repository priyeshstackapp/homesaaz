

import 'dart:convert';
import 'dart:io';

import 'package:homesaaz/common/common_route.dart';
import 'package:homesaaz/common/common_widget.dart';
import 'package:homesaaz/common/dependency_injection.dart';
import 'package:homesaaz/common/util.dart';
import 'package:homesaaz/model/cart_model.dart';
import 'package:homesaaz/service/rest_api.dart';

import 'checkout_screen.dart';

class CheckoutScreenViewModel {
  CheckoutScreenState state;

  CheckoutScreenViewModel(this.state){
    newProductData();
  }

  CartModel cartModel;

  newProductData() {
    state.setState(() {
      cartModel = state.widget.cartModel;
    });
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
        state.setState(() {});
        Utils.showToast("Remove from cart");
      } else {
        //Utils.showToast("Something went wrong");
      }
    }).catchError((e) {
      hideLoader();
      // Utils.showToast(e.toString());
    }).whenComplete(() {});
  }

  placeOrder() async {
    showLoader(state.context);
    Map<String,dynamic> cart = {};
    state.widget.cartModel.products.forEach((element) {
      cart[element.itemid.toString()] = element.itemqty;
    });
    Map<String, dynamic> body = {
      "uid": Injector.loginResponse.uid,
      "selected_address" : state.widget.addressData.addressId,
      "payment_mode" : state.select == "Paytm" ? 'paytm': 'cod',
      "cart_items" : jsonEncode(cart).toString(),
      "paytm_order_id" : "",
      "transaction_data" : "",
      "device" : Platform.isAndroid ? "android" : "ios"
    };

    print(jsonEncode(body));

    RestApi.placeOrder(body).then((responseData) {
      hideLoader();
      Map<String, dynamic> jsonData = json.decode(responseData.body);
      if (responseData != null && jsonData['status'] == "error") {
        Utils.showToast(jsonData['error']);
      } else if (responseData != null) {
        gotoConfirmationScreen(state.context);
      } else {
        //Utils.showToast("Something went wrong");
      }
    }).catchError((e) {
      print(e);
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
        Utils.showToast("Remove from cart");
      } else {
        //Utils.showToast("Something went wrong");
      }
    }).catchError((e) {
      hideLoader();
      // Utils.showToast(e.toString());
    }).whenComplete(() {});
  }
}