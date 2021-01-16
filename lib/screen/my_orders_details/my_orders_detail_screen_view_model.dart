import 'dart:convert';

import 'package:homesaaz/common/common_widget.dart';
import 'package:homesaaz/common/dependency_injection.dart';
import 'package:homesaaz/common/util.dart';
import 'package:homesaaz/model/my_order_model.dart';
import 'package:homesaaz/model/order_details_model.dart';
import 'package:homesaaz/screen/my_orders/my_orders_screen.dart';
import 'package:homesaaz/screen/my_orders_details/my_orders_detail_screen.dart';
import 'package:homesaaz/service/rest_api.dart';

class MyOrdersDetailScreenViewModel {
  MyOrdersDetailScreenState state;

  MyOrdersDetailScreenViewModel(MyOrdersDetailScreenState state) {
    this.state = state;
    getOrderDetails();
  }

  OrderDetailsModel orderDetailsModel;

  getOrderDetails() async {
    Map<String, dynamic> body = {
      "uid": Injector.loginResponse.uid,
      "order_id" : state.widget.orderId
    };
    await Future.delayed(const Duration(milliseconds: 200), () {
      showLoader(state.context);
    });
    RestApi.getSingleOrderData(body).then((responseData) {
      hideLoader();
      Map<String, dynamic> jsonData = json.decode(responseData.body);
      if (responseData != null && jsonData['status'] == "error") {
        Utils.showToast(jsonData['error']);
      } else if (responseData != null) {
        orderDetailsModel = orderDetailsModelFromJson(responseData.body);
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
