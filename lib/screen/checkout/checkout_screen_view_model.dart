

import 'dart:convert';

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


  }

  removeFromCart(Product product) async {
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
}