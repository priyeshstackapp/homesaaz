import 'package:flutter/material.dart';
import 'package:homesaaz/common/colorres.dart';
import 'package:homesaaz/common/common_route.dart';
import 'package:homesaaz/common/common_widget.dart';
import 'package:homesaaz/common/util.dart';
import 'package:homesaaz/model/dashboard_model.dart';
import 'package:homesaaz/model/product_list_model.dart';
import 'package:homesaaz/screen/seeall/subCategory/sub_category_products_view_model.dart';

class SubCategoryProducts extends StatefulWidget {

  final String catId;
  final String subCatId;
  final String catName;
  final String subCatName;


  SubCategoryProducts(this.catId, this.subCatId, this.catName, this.subCatName);

  @override
  SubCategoryProductsState createState() => SubCategoryProductsState();
}

class SubCategoryProductsState extends State<SubCategoryProducts> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  SubCategoryProductsViewModel model;

  ScrollController controller;
  bool isPaging = true;
  int offset = 0;

  @override
  void initState() {
    super.initState();
    controller = new ScrollController()..addListener(_scrollListener);
  }

  @override
  void dispose() {
    controller.removeListener(_scrollListener);
    super.dispose();
  }

  void _scrollListener() {
    if (controller.position.extentAfter < 100) {
      if(model.canPaging){
        setState(() {
          isPaging = true;
        });
        offset = offset + 20;
        model.newProductDataPaging();
      }
    }
  }
  
  @override
  Widget build(BuildContext context) {
    print("Current page --> $runtimeType");
    model ?? (model = SubCategoryProductsViewModel(this));
    
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
                widget.catName + " > "+ widget.subCatName,
                style: TextStyle(fontSize: 30, color: ColorRes.textColor),
              ),
            ),
            SizedBox(height: 20),
            model.productListModel!=null && model.productListModel.productList!=null&& model.productListModel.productList.isNotEmpty
                ? GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,mainAxisSpacing: 5,crossAxisSpacing: 5,childAspectRatio: 0.74),
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
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 2,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      child: seeAllView(
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
                              () async {
                            if (product.itemdetId == null) {
                              Utils.showToast("Item id is null");
                            } else {
                              // if(product.wishlistStatus) {
                              //   await model.removeFromCart(product.itemdetId);
                              // }else{
                              //   await model.addToWish(product.itemdetId);
                              // }
                              // product.wishlistStatus = !product.wishlistStatus;
                              // setState(() {
                              //
                              // });
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
                          context
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
