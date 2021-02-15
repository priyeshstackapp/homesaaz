import 'dart:convert';

import 'package:homesaaz/common/common_widget.dart';
import 'package:homesaaz/common/util.dart';
import 'package:homesaaz/model/all_categories_model.dart';
import 'package:homesaaz/screen/seeall/categories_all.dart';
import 'package:homesaaz/service/rest_api.dart';

class CategoriesAllViewModel{
  CategoriesAllState state;
  AllCategoriesModel categories;

  CategoriesAllViewModel(this.state){
    categoryApi();
  }

  categoryApi() async {
    await Future.delayed(const Duration(milliseconds: 200), () {
      showLoader(state.context);
    });

    RestApi.allCategories().then((responseData) {
      hideLoader();
      Map<String, dynamic> jsonData = json.decode(responseData.body);
      if (responseData != null && jsonData['status'] == "error") {
        Utils.showToast(jsonData['error']);
      } else if(responseData != null) {
        print(responseData);
        categories = allCategoriesModelFromJson(responseData.body);
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
}