

import 'dart:convert';
import 'dart:io';

import 'package:homesaaz/common/common_route.dart';
import 'package:homesaaz/common/common_widget.dart';
import 'package:homesaaz/common/dependency_injection.dart';
import 'package:homesaaz/common/util.dart';
import 'package:homesaaz/model/cart_model.dart';
import 'package:homesaaz/service/rest_api.dart';
import 'package:paytm/paytm.dart';

import 'checkout_screen.dart';

class CheckoutScreenViewModel {
  CheckoutScreenState state;

  CheckoutScreenViewModel(this.state){
    getCartData();
  }

  CartModel cartModel;

  getCartData() async {

    Map<String, dynamic> body = {
      "uid": Injector.loginResponse.uid,
    };
    await Future.delayed(const Duration(milliseconds: 200), () {
      showLoader(state.context);
    });
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
      hideLoader();
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
        getCartData();
      } else {
        //Utils.showToast("Something went wrong");
      }
    }).catchError((e) {
      hideLoader();
      // Utils.showToast(e.toString());
    }).whenComplete(() {});
  }

  placeOrder({String response,String orderId}) async {
    showLoader(state.context);
    Map<String,dynamic> cart = {};
    state.widget.cartModel.products.forEach((element) {
      cart[element.itemid.toString()] = element.itemqty;
    });
    Map<String, dynamic> body = {
      "uid": Injector.loginResponse.uid,
      "selected_address" : state.widget.addressData.addressId,
      "payment_mode" : state.select.contains('Paytm') ? 'paytm': 'cod',
      "cart_items" : jsonEncode(cart).toString(),
      "paytm_order_id" : state.select.contains('Paytm') ? orderId : "",
      "transaction_data" : state.select.contains('Paytm') ? response : "",
      "device" : Platform.isAndroid ? "android" : "ios"
    };

    RestApi.placeOrder(body).then((responseData) {
      hideLoader();
      Map<String, dynamic> jsonData = json.decode(responseData.body);
      if (responseData != null && jsonData['status'] == "error") {
        Utils.showToast(jsonData['error']);
      } else if (responseData != null) {
        gotoConfirmationScreen(state.context,jsonData['order_no'],jsonData['order_id'].toString(),);
        Injector.updateCartData(CartModel());
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
        getCartData();
      } else {
        //Utils.showToast("Something went wrong");
      }
    }).catchError((e) {
      hideLoader();
      // Utils.showToast(e.toString());
    }).whenComplete(() {});
  }

  bool testing = true;

  /*
  mode 0 : Wallet
  mode 1 : Net Banking
  mode 2 : UPI
  mode 3 : Credit Card
  */

  void generateTxnToken(int mode) async {

    showLoader(state.context);

    final String mid = 'HemMfq82154903427549';
    final String key = 'ozCqcxy@kSQ6iX2h';
    final int amount = cartModel.totalAmount;

    String orderId = DateTime.now().millisecondsSinceEpoch.toString();

    String callBackUrl = (testing
        ? 'https://securegw-stage.paytm.in'
        : 'https://securegw.paytm.in') +
        '/theia/paytmCallback?ORDER_ID=' +
        orderId;

    var body = json.encode({
      "mid": mid,
      "key_secret": key,
      "website": 'WEBSTAGING',
      "orderId": orderId,
      "amount": amount,
      "callbackUrl": callBackUrl,
      "custId": "122",
      "mode": mode.toString(),
      "testing": testing ? 0 : 1
    });

    String txnToken = await RestApi.paytm(body);

    if(txnToken!=null && txnToken.isNotEmpty){
      var paytmResponse = await Paytm.payWithPaytm(
          mid, orderId, txnToken, amount.toString(), callBackUrl, testing);


      print('-----------------------');
      print(paytmResponse.values);
      print('-----------------------');
      hideLoader();
      if(paytmResponse['error']){
        Utils.showToast(paytmResponse['errorMessage']);
        print("PAYTM Error ${paytmResponse['errorMessage']}");
      }else{
        if(paytmResponse['response']!=null){
          if(paytmResponse['response']['STATUS'] == 'TXN_SUCCESS'){
            print("SUCCESS!!!!");
            placeOrder(orderId: paytmResponse['response']['ORDERID'],response: paytmResponse['response'].toString());
            Utils.showToast('Payment successfully received');
            print(paytmResponse['response']['STATUS']);
          }else if(paytmResponse['response']['STATUS'] == 'TXN_FAILURE'){
            print("FAIL!!!!");
            Utils.showToast('Payment failed');
            print(paytmResponse['response']['STATUS']);
          } else{
            print("Unknown Status");
            Utils.showToast('Something went wrong while transaction');
            print(paytmResponse['response']['STATUS']);
          }

        }
      }
      print('-----------------------');
    }else{
      hideLoader();
    }
  }
}