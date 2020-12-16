import 'package:flutter/material.dart';
import 'package:homesaaz/app.dart';
import 'package:homesaaz/common/colorres.dart';
import 'package:homesaaz/common/common_route.dart';
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
      backgroundColor: ColorRes.primaryColor,
      appBar: commonAppbar(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20),
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

                    crossAxisCount: 2, childAspectRatio: 0.68),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: model.newProductName.length,
                itemBuilder: (context, index) {
                  HomeScreenModel product = model.newProductName[index];

                  return GestureDetector(
                    onTap: () {
                      gotoProductDetailScreen(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Container(
                        child: productView(product.productUrl, product.productName,
                            product.productPriceBefore, product.productPriceAfter),
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
