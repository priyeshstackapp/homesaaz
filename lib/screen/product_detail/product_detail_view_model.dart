import 'dart:convert';

import 'package:homesaaz/common/common_widget.dart';
import 'package:homesaaz/common/dependency_injection.dart';
import 'package:homesaaz/common/util.dart';
import 'package:homesaaz/model/cart_model.dart';
import 'package:homesaaz/model/dashboard_model.dart';
import 'package:homesaaz/model/product_model.dart';
import 'package:homesaaz/screen/product_detail/product_detail.dart';
import 'package:homesaaz/service/rest_api.dart';

class ProductDetailViewModel {
  ProductDetailScreenState state;

  ProductDetailViewModel(ProductDetailScreenState state){
    this.state = state;
    getProduct();
  }
  
  ProductModel product;

  void getProduct() {
    product = ProductModel(
      productName: "Brown Velvet Chair",
      productId: "SA5230",
      newPrice: 305,
      oldPrice: 455,
      size: '21 Dia.',
      description: 'A wonderful serenity has taken possession of my entire soul, like these sweet mornings of spring which I enjoy with my whole heart. I am alone, and feel the charm of existence in this spot, which was created for the bliss of souls like mine.A wonderful serenity has taken possession of my entire soul, like these sweet mornings of spring which I enjoy with my whole heart. I am alone, and feel the charm of existence in this spot, which was created for the bliss of souls like mine.',
      productUrl: [Utils.assetImage('product1_full_image'),Utils.assetImage('product1_full_image'),Utils.assetImage('product1_full_image'),],
      colors: ['B3261F','696969','FFDD00',]
    );
  }

  addToCart(bool show) async {
    showLoader(state.context);
    Map<String, dynamic> body = {
      "uid": Injector.loginResponse.uid,
      "item_id" : state.widget.product.itemdetId.toString(),
      "qnty" : "1"
    };

    RestApi.addToCartApi(body).then((responseData) {
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
    }).catchError((e) {
      hideLoader();
      // Utils.showToast(e.toString());
    }).whenComplete(() {});
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