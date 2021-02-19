import 'dart:convert';

import 'package:homesaaz/common/common_widget.dart';
import 'package:homesaaz/common/dependency_injection.dart';
import 'package:homesaaz/common/util.dart';
import 'package:homesaaz/model/cart_model.dart';
import 'package:homesaaz/model/dashboard_model.dart';
import 'package:homesaaz/model/product_model.dart';
import 'package:homesaaz/screen/product_detail/product_detail.dart';
import 'package:homesaaz/service/rest_api.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart' show parse;


class ProductDetailViewModel {
  ProductDetailScreenState state;

  ProductDetailViewModel(ProductDetailScreenState state){
    this.state = state;
    getProduct();
  }

  ProductDetailModel product;

  void getProduct() async {
    await Future.delayed(Duration(milliseconds: 200));
    showLoader(state.context);

    Map<String, dynamic> body = {
      "uid": Injector.loginResponse==null ? "": Injector.loginResponse.uid,
    };

    var responseData = await RestApi.getProductDetails(state.widget.product.itemdetId,body);

    hideLoader();
    Map<String, dynamic> jsonData = json.decode(responseData.body);
    if (responseData != null && jsonData['status'] == "error") {
      Utils.showToast(jsonData['error']);
    } else if (responseData != null) {
      product = productDetailModelFromJson(responseData.body);
      Document agreements = parse(product.data[0].description);
      String parsedString = parse(agreements.body.text).documentElement.text;
      product.data[0].description = parsedString;
      if (product.data[0].description.length > 200) {
        state.firstHalf = product.data[0].description.substring(0, 200);
        state.secondHalf = product.data[0].description
            .substring(200, product.data[0].description.length);
      } else {
        state.firstHalf = product.data[0].description;
        state.secondHalf = "";
      }
      state.setState(() {

      });
    } else {
      //Utils.showToast("Something went wrong");
    }
  }

  addToCart(bool show) async {
    showLoader(state.context);
    Map<String, dynamic> body = {
      "uid": Injector.loginResponse.uid,
      "item_id" : state.widget.product.itemdetId.toString(),
      "qnty" : "${state.quantity}"
    };

    var responseData = await RestApi.addToCartApi(body);

    hideLoader();
    Map<String, dynamic> jsonData = json.decode(responseData.body);
    if (responseData != null && jsonData['status'] == "error") {
      Utils.showToast(jsonData['error']);
    } else if (responseData != null) {

      if(show)
        Utils.showToast("Added to cart");

    } else {
      //Utils.showToast("Something went wrong");
    }
  }

  getCartData() async {

    Map<String, dynamic> body = {
      "uid": Injector.loginResponse.uid,
    };
    showLoader(state.context);
    try{
      var responseData = await RestApi.getCartItems(body);
      hideLoader();
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



  addToWish(String id) async {
    showLoader(state.context);
    Map<String, dynamic> body = {
      "uid": Injector.loginResponse.uid,
      "item_id" : id,
    };

    await RestApi.addToWishListApi(body);
    hideLoader();

  }

  removeFromCart(String id) async {
    showLoader(state.context);
    Map<String, dynamic> body = {
      "uid": Injector.loginResponse.uid,
      "item_id" : id,
    };

    await RestApi.removeWishApi(body);
    hideLoader();
  }


}