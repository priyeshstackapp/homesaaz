import 'package:flutter/material.dart';
import 'package:homesaaz/app.dart';
import 'package:homesaaz/common/colorres.dart';
import 'package:homesaaz/common/common_route.dart';
import 'package:homesaaz/common/common_widget.dart';
import 'package:homesaaz/model/dashboard_model.dart';
import 'package:homesaaz/model/home_model.dart';
import 'package:homesaaz/model/product_list_model.dart';
import 'package:homesaaz/screen/seeall/seeall_screen_view_model.dart';

class SeeAllScreen extends StatefulWidget {
  final String title;
  final String id;

  SeeAllScreen(this.title, this.id);

  @override
  SeeAllScreenState createState() => SeeAllScreenState();
}

class SeeAllScreenState extends State<SeeAllScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  SeeAllScreenViewModel model;

  @override
  Widget build(BuildContext context) {
    print("Current page --> $runtimeType");
    model ?? (model = SeeAllScreenViewModel(this));

    return Scaffold(
      backgroundColor: ColorRes.primaryColor,
      appBar: commonAppbar(context),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              //margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Text(
                widget.title,
                style: TextStyle(fontSize: 30, color: ColorRes.textColor),
              ),
            ),
            SizedBox(height: 20),
            GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,mainAxisSpacing: 15,childAspectRatio: 0.9),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: model.productListModel!=null && model.productListModel.productList!=null ? model.productListModel.productList.length : 0,
              itemBuilder: (context, index) {
                ProductList product = model.productListModel.productList[index];

                return GestureDetector(
                  onTap: () {
                    print(product.itemdetId);
                    gotoProductDetailScreen(context,Product(itemdetId: product.itemdetId));
                  },
                  child: Card(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 7,vertical: 7),
                      margin: EdgeInsets.symmetric(horizontal: 7),
                      child: productView(product.productImage, product.productName,
                          product.discountedPrice, product.price,false),
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
