import 'dart:convert';

import 'package:homesaaz/common/common_widget.dart';
import 'package:homesaaz/common/util.dart';
import 'package:homesaaz/model/home_model.dart';
import 'package:homesaaz/model/product_list_model.dart';
import 'package:homesaaz/model/sub_cat_model.dart';
import 'package:homesaaz/screen/seeall/seeall_screen.dart';
import 'package:homesaaz/service/rest_api.dart';

class SeeAllScreenViewModel{

  SeeAllScreenState state;


  SeeAllScreenViewModel(this.state){
    if(state.widget.cat){
      subCatData();
    }else{
      newProductData();
    }
  }

  ProductListModel productListModel;
  SubCatModel subCatModel;

  newProductData({String id=""}) async {
    await Future.delayed(const Duration(milliseconds: 200), () {
      showLoader(state.context);
    });

    Map<String,dynamic> body = state.widget.id==null ? null : {
      "cat_id" : state.widget.id,
      "subcat_id":id
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

  subCatData() async {
    await Future.delayed(const Duration(milliseconds: 200), () {
      showLoader(state.context);
    });

    RestApi.subCatListApi(state.widget.id).then((responseData) {
      hideLoader();
      Map<String, dynamic> jsonData = json.decode(responseData.body);
      if (responseData != null && jsonData['status'] == "error") {
        Utils.showToast(jsonData['error']);
      } else if(responseData != null) {
        print(responseData);
        subCatModel = subCatModelFromJson(responseData.body);
        state.setState(() {

        });
      } else {
        Utils.showToast("Something went wrong");
      }
    }).catchError((e) {
      hideLoader();
      Utils.showToast(e.toString());
    }).whenComplete(() => {
    newProductData()
    });
  }

}