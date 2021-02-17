import 'package:flutter/material.dart';
import 'package:homesaaz/app.dart';
import 'package:homesaaz/common/colorres.dart';
import 'package:homesaaz/common/common_route.dart';
import 'package:homesaaz/common/common_widget.dart';
import 'package:homesaaz/common/util.dart';
import 'package:homesaaz/model/dashboard_model.dart';
import 'package:homesaaz/model/home_model.dart';
import 'package:homesaaz/model/product_list_model.dart';
import 'package:homesaaz/screen/seeall/seeall_screen_view_model.dart';

class SeeAllScreen extends StatefulWidget {
  final String title;
  final String id;
  final bool cat;

  SeeAllScreen(this.title, this.id, this.cat);

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
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                widget.title,
                style: TextStyle(fontSize: 30, color: ColorRes.textColor),
              ),
            ),
            SizedBox(height: 20),
            widget.cat ? Padding(
              padding: const EdgeInsets.symmetric(horizontal:20),
              child: Container(
                height: 100,
                child: ListView.builder(
                          itemCount: model.subCatModel==null ? 0 : model.subCatModel.categories.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => InkWell(
                            onTap: (){
                              model.newProductData(id: model.subCatModel.categories[index].subcatId);
                            },
                            child: Card(
                              elevation: 3,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal:8.0),
                                child: Column(
                                  children: [
                                    model.subCatModel.categories[index].subcategoryImage.isNotEmpty ? Image.network(model.subCatModel.categories[index].subcategoryImage,height: 60,width: 100,) : Image.asset(App.defaultImage,height: 60,width: 100,fit: BoxFit.cover,),
                                    SizedBox(height: 10,),
                                    Text(model.subCatModel.categories[index].subcategoryName,style: TextStyle(color: ColorRes.redColor),),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
              ),
            ) : Container(),
            widget.cat ? SizedBox(height: 20) : Container() ,
            model.productListModel!=null && model.productListModel.productList!=null&& model.productListModel.productList.isNotEmpty
                ? GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,mainAxisSpacing: 15,childAspectRatio: 0.7),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: model.productListModel.productList.length,
              itemBuilder: (context, index) {
                ProductList product = model.productListModel.productList[index];

                return GestureDetector(
                  onTap: () {
                    print(product.itemdetId);
                    gotoProductDetailScreen(context,Product(itemdetId: product.itemdetId));
                  },
                  child: Card(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 7, vertical: 7),
                      margin: EdgeInsets.symmetric(horizontal: 7),
                      child: productView(
                          product.productImage,
                          product.productName,
                          product.discountedPrice,
                          product.price, () {
                        if (product.itemdetId == null) {
                          Utils.showToast("Item id is null");
                        } else {
                          model.addToCart(product.itemdetId,product.count);
                        }
                      },
                          false,
                              (){
                                if (product.itemdetId == null) {
                                  Utils.showToast("Item id is null");
                                } else {
                                  model.addToWish(product.itemdetId);
                                }
                          },() async {
                        setState(() {
                          product.count ++;
                        });
                      }, () async {
                        if (product.count != 1) {
                          setState(() {
                            product.count --;
                          });
                        }
                      },product.count,
                        false,
                        false,
                      ),
                    ),
                  ),
                );
              },
            )
                : Align(
                alignment: Alignment.center,
                child: Text("No Product found!"))
          ],
        ),
      ),
    );
  }
}
