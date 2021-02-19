import 'dart:convert';

import 'package:homesaaz/common/common_widget.dart';
import 'package:homesaaz/common/dependency_injection.dart';
import 'package:homesaaz/common/util.dart';
import 'package:homesaaz/model/cart_model.dart';
import 'package:homesaaz/model/product_list_model.dart';
import 'package:homesaaz/screen/seeall/subCategory/sub_category_products.dart';
import 'package:homesaaz/service/rest_api.dart';

class SubCategoryProductsViewModel{

  SubCategoryProductsState state;

  bool canPaging = true;


  SubCategoryProductsViewModel(this.state){
      newProductData();
  }

  ProductListModel productListModel;

  newProductData() async {
    await Future.delayed(const Duration(milliseconds: 200), () {
      showLoader(state.context);
    });

    Map<String,dynamic> body = {
      "cat_id" : state.widget.catId,
      "subcat_id":state.widget.subCatId,
      'offset': state.offset.toString(),
      'limit' : '20'
    };

    RestApi.productListApi(body).then((responseData) {
      hideLoader();
      Map<String, dynamic> jsonData = json.decode(responseData.body);
      if (responseData != null && jsonData['status'] == "error") {
        Utils.showToast(jsonData['error']);
      } else if(responseData != null) {
        print(responseData);
        productListModel = productListModelFromJson(responseData.body);
        state.setState(() {

        });
      } else {
        Utils.showToast("Something went wrong");
      }
    }).catchError((e) {
      hideLoader();
      Utils.showToast(e.toString());
    }).whenComplete(() => {

    });
  }

  newProductDataPaging() async {
    showLoader(state.context);

    Map<String,dynamic> body = {
      "cat_id" : state.widget.catId,
      "subcat_id":state.widget.subCatId,
      'offset': state.offset.toString(),
      'limit' : '20'
    };

    RestApi.productListApi(body).then((responseData) {
      hideLoader();
      Map<String, dynamic> jsonData = json.decode(responseData.body);
      if (responseData != null && jsonData['status'] == "error") {
        Utils.showToast(jsonData['error']);
      } else if(responseData != null) {
        print(responseData);
        var prod = productListModelFromJson(responseData.body);
        if(prod.productList.isNotEmpty){
          productListModel.productList.addAll(prod.productList);
        }else{
          canPaging = false;
        }
      } else {
        Utils.showToast("Something went wrong");
      }
    }).catchError((e) {
      hideLoader();
      Utils.showToast(e.toString());
    }).whenComplete(() => {

    });
  }

  addToCart(String id, int count) async {
    showLoader(state.context);
    Map<String, dynamic> body = {
      "uid": Injector.loginResponse.uid,
      "item_id" : id,
      "qnty" : "$count"
    };

    try{
      var responseData = await RestApi.addToCartApi(body);

      hideLoader();
      Map<String, dynamic> jsonData = json.decode(responseData.body);
      if (responseData != null && jsonData['status'] == "error") {
        Utils.showToast(jsonData['error']);
      } else if (responseData != null) {
        Utils.showToast("Added to cart");
        getCartData();
      } else {
        //Utils.showToast("Something went wrong");
      }
    }catch(e){
      hideLoader();
      Utils.showToast("$e");
    }
  }

  addToWish(String id) async {
    showLoader(state.context);
    Map<String, dynamic> body = {
      "uid": Injector.loginResponse.uid,
      "item_id" : id
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

}