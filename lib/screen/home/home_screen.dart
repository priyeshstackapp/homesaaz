import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:homesaaz/app.dart';
import 'package:homesaaz/common/colorres.dart';
import 'package:homesaaz/common/common_route.dart';
import 'package:homesaaz/common/common_widget.dart';
import 'package:homesaaz/model/home_model.dart';
import 'package:homesaaz/screen/home/home_screen_view_model.dart';

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  HomeScreenViewModel model;

  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  Future<bool> _onWillPop() async {
    return (
        await showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Are you sure?'),
        content: new Text('Do you want to exit an App'),
        actions: <Widget>[
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('No'),
          ),
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: new Text('Yes'),
          ),
        ],
      ),
    )) ?? false;
  }
  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    double width = media.width;
    double height = media.height;
    print("Current page --> $runtimeType");
    model ?? (model = HomeScreenViewModel(this));

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: ColorRes.whiteColor,
        appBar: AppBar(
          leading: InkWell(
            child: Image.asset(App.menuIcon),
            onTap: () => scaffoldKey.currentState.openDrawer(),
          ),
          elevation: 0,
          backgroundColor: ColorRes.primaryColor,
          actions: [
            InkWell(
                onTap: () {
                  gotoProfileScreen(context);
                },
                child: Image.asset(
                  App.user,
                  color: ColorRes.darkRedColor58,
                  height: 16,
                  width: 16,
                ),
            ),
            InkWell(
                onTap: () {
                  gotoCartScreen(context);
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Image.asset(
                    App.shopping_cart,
                    color: ColorRes.darkRedColor58,
                    height: 16,
                    width: 16,
                  ),
                ),
            ),
          ],
        ),
        drawer: Scaffold(
          backgroundColor: ColorRes.whisper,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: height * 0.8,
                    width: width * width,
                    color: ColorRes.primaryColor,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            replaceWithHomeScreen(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Text(
                              "Home",
                              style: new TextStyle(
                                fontSize: 24,
                                color: ColorRes.dimGray,
                                fontFamily: 'NeueFrutigerWorld',
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            gotoProfileScreen(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Text(
                              "Profile",
                              style: new TextStyle(
                                fontSize: 24,
                                color: ColorRes.dimGray,
                                fontFamily: 'NeueFrutigerWorld',
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            gotoCartScreen(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Text(
                              "My Cart",
                              style: new TextStyle(
                                fontSize: 24,
                                color: ColorRes.dimGray,
                                fontFamily: 'NeueFrutigerWorld',
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Text(
                              "Favorite",
                              style: new TextStyle(
                                fontSize: 24,
                                color: ColorRes.dimGray,
                                fontFamily: 'NeueFrutigerWorld',
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            gotoMyOrdersScreen(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Text(
                              "My Orders",
                              style: new TextStyle(
                                fontSize: 24,
                                color: ColorRes.dimGray,
                                fontFamily: 'NeueFrutigerWorld',
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Text(
                              "Help",
                              style: new TextStyle(
                                fontSize: 24,
                                color: ColorRes.dimGray,
                                fontFamily: 'NeueFrutigerWorld',
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            gotoLoginScreenUntilRemove(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Text(
                              "LogOut",
                              style: new TextStyle(
                                fontSize: 24,
                                color: ColorRes.dimGray,
                                fontFamily: 'NeueFrutigerWorld',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin:
                        EdgeInsets.only(top: width * 0.08, right: width * 0.1),
                    alignment: Alignment.bottomRight,
                    child: InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Image.asset(
                        App.close,
                        //color: Colors.black,
                        height: 30,
                        width: 30,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 5),

              search(),
              SizedBox(height: 20),

              //Top Banner
              Image.asset(App.banner_top),
              SizedBox(height: 14),

              categories(),
              SizedBox(height:  height*0.03),

              //New Products
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 25),
                    child: Text(
                      'New Products',
                      style: new TextStyle(
                          fontSize: 22,
                          color: ColorRes.charcoal,
                          fontFamily: 'NeueFrutigerWorld',
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      gotoSeeAllScreen(context, "New Products");
                    },
                    child: Container(
                      padding: EdgeInsets.only(right: 20),
                      child: Text(
                        "See all",
                        style: new TextStyle(
                            fontSize: 14,
                            color: ColorRes.charcoal,
                            fontFamily: 'NeueFrutigerWorld',
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 18),
              Container(
                padding: EdgeInsets.only(left: 25),
                color: ColorRes.primaryColor,
                height: height * 0.4,
                child: ListView.builder(
                    itemCount: model.newProductName.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      HomeScreenModel product = model.newProductName[index];
                      return GestureDetector(
                        onTap: () {
                          gotoProductDetailScreen(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: productView(
                              product.productUrl,
                              product.productName,
                              product.productPriceBefore,
                              product.productPriceAfter),
                        ),
                      );
                    }),
              ),
              //SizedBox(height: 10),

              //Center Banner
              Image.asset(App.banner_center),
              SizedBox(height: height*0.05),

              //Trending Products
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 25),
                    child: Text(
                      'Trending Products',
                      style: new TextStyle(
                          fontSize: 22,
                          color: ColorRes.charcoal,
                          fontFamily: 'NeueFrutigerWorld',
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      gotoSeeAllScreen(context, "Trending Products");
                    },
                    child: Container(
                      padding: EdgeInsets.only(right: 20),
                      child: Text(
                        "See all",
                        style: new TextStyle(
                            fontSize: 14,
                            color: ColorRes.charcoal,
                            fontFamily: 'NeueFrutigerWorld',
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 18),
              Container(
                padding: EdgeInsets.only(left: 25),
                color: ColorRes.primaryColor,
                height: height * 0.4,
                child: ListView.builder(
                    itemCount: model.trendingProductsName.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      HomeScreenModel product =
                          model.trendingProductsName[index];
                      return GestureDetector(
                        onTap: () {
                          gotoProductDetailScreen(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: productView(
                              product.productUrl,
                              product.productName,
                              product.productPriceBefore,
                              product.productPriceAfter),
                        ),
                      );
                    }),
              ),
              //SizedBox(height: 10),

              //Bottom Banner
              Image.asset(App.banner_bottom),
              SizedBox(height:  height*0.05),

              //Featured Products
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 25),
                    child: Text(
                      'Featured Products',
                      style: new TextStyle(
                          fontSize: 22,
                          color: ColorRes.charcoal,
                          fontFamily: 'NeueFrutigerWorld',
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      gotoSeeAllScreen(context, "Featured Products");
                    },
                    child: Container(
                      padding: EdgeInsets.only(right: 20),
                      child: Text(
                        "See all",
                        style: new TextStyle(
                            fontSize: 14,
                            color: ColorRes.charcoal,
                            fontFamily: 'NeueFrutigerWorld',
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 18),
              Container(
                padding: EdgeInsets.only(left: 25),
                color: ColorRes.primaryColor,
                height: height * 0.4,
                child: ListView.builder(
                    itemCount: model.featuredProductsName.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      HomeScreenModel product =
                          model.featuredProductsName[index];
                      return GestureDetector(
                        onTap: () {
                          gotoProductDetailScreen(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: productView(
                              product.productUrl,
                              product.productName,
                              product.productPriceBefore,
                              product.productPriceAfter),
                        ),
                      );
                    }),
              ),
              //SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  //search Field
  Widget search() {
    Size media = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: CustomTextFieldShadow(
          text: "Search Your Product",
          fieldController: null,
          name: "Search",
          obscureText: false,
          keyboartType: TextInputType.text,
          media: media),
    );
  }

  //Categories Details
  Widget categories() {
    return Column(
      children: [
        //Categories Title
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  App.categoriesName,
                  style: new TextStyle(
                      fontSize: 22,
                      color: ColorRes.charcoal,
                      fontFamily: 'NeueFrutigerWorld',
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.topRight,
                padding: EdgeInsets.only(right: 20),
                child: Text(
                  "See all",
                  style: new TextStyle(
                      fontSize: 14,
                      color: ColorRes.charcoal,
                      fontFamily: 'NeueFrutigerWorld',
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 15),

        //Categories Images
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 15),
          child: GridView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: model.categoriesImage.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 6.0,
                childAspectRatio: MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height / 3),
                mainAxisSpacing: 15.0),
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  gotoSeeAllScreen(context, model.categoriesName[index]);
                },
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFFFFFFFF),
                        borderRadius: BorderRadius.circular(5.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            blurRadius: 5.5,
                            spreadRadius: 1.5,
                            offset: Offset(4.4, 9.0),
                          ),
                        ],
                      ),
                      child: Image.asset(model.categoriesImage[index],
                          fit: BoxFit.cover),
                    ),
                    Container(
                      child: Center(
                        child: Text(
                          model.categoriesName[index],
                          style: new TextStyle(
                              fontSize: 12,
                              color: ColorRes.whiteColor,
                              fontFamily: 'NeueFrutigerWorld',
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
