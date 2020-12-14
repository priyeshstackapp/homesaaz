import 'package:flutter/material.dart';
import 'package:homesaaz/app.dart';
import 'package:homesaaz/common/colorres.dart';
import 'package:homesaaz/common/common_widget.dart';
import 'package:homesaaz/model/home_model.dart';
import 'package:homesaaz/screen/seeall/seeall_screen_view_model.dart';

class SeeAllScreen extends StatefulWidget {
  final String title;

  SeeAllScreen(this.title);

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
      appBar: AppBar(
        leading: backButton(context),
        elevation: 0,
        backgroundColor: ColorRes.primaryColor,
        actions: [
          InkWell(child: Image.asset(App.userIcon)),
          Image.asset(App.cartIcon),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Text(
                widget.title,
                style: TextStyle(fontSize: 32, color: ColorRes.textColor),
              ),
            ),
            GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 0.8),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: model.newProductName.length,
              itemBuilder: (context, index) {
                HomeScreenModel product = model.newProductName[index];

                return Container(
                  padding: const EdgeInsets.symmetric(horizontal:20,vertical: 10),
                  child: productView(product.productUrl, product.productName, product.productPriceBefore, product.productPriceAfter),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
