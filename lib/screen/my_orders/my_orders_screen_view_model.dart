import 'dart:convert';

import 'package:homesaaz/common/common_widget.dart';
import 'package:homesaaz/common/dependency_injection.dart';
import 'package:homesaaz/common/util.dart';
import 'package:homesaaz/model/my_order_model.dart';
import 'package:homesaaz/screen/my_orders/my_orders_screen.dart';
import 'package:homesaaz/service/rest_api.dart';

class MyOrdersScreenViewModel {
  MyOrdersScreenState state;

  MyOrdersScreenViewModel(MyOrdersScreenState state) {
    this.state = state;
    getMyOrderData();
  }

  MyOrdersModel ordersModel;

  getMyOrderData() async {
    Map<String, dynamic> body = {
      "uid": Injector.loginResponse.uid,
    };
    await Future.delayed(const Duration(milliseconds: 200), () {
      showLoader(state.context);
    });
    RestApi.getMyOrderData(body).then((responseData) {
      hideLoader();
      Map<String, dynamic> jsonData = json.decode(responseData.body);
      if (responseData != null && jsonData['status'] == "error") {
        Utils.showToast(jsonData['error']);
      } else if (responseData != null) {
        ordersModel = myOrdersModelFromJson(responseData.body);
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
