import 'dart:convert';

import 'package:homesaaz/common/common_widget.dart';
import 'package:homesaaz/common/util.dart';
import 'package:homesaaz/model/dashboard_model.dart';
import 'package:homesaaz/screen/seeall/categories_all.dart';
import 'package:homesaaz/service/rest_api.dart';

class CategoriesAllViewModel{
  CategoriesAllState state;
  List<Category> categories;

  CategoriesAllViewModel(this.state){
    categoryApi();
  }

  categoryApi() async {
    await Future.delayed(const Duration(milliseconds: 200), () {
      showLoader(state.context);
    });

    RestApi.dahsBoardApi().then((responseData) {
      hideLoader();
      Map<String, dynamic> jsonData = json.decode(responseData.body);
      if (responseData != null && jsonData['status'] == "error") {
        Utils.showToast(jsonData['error']);
      } else if(responseData != null) {
        print(responseData);
        categories = categoriesFromJson(responseData.body);
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