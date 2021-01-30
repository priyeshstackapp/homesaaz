import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:homesaaz/app.dart';
import 'package:homesaaz/common/colorres.dart';
import 'package:homesaaz/common/common_route.dart';
import 'package:homesaaz/common/common_widget.dart';
import 'package:homesaaz/common/dependency_injection.dart';
import 'package:homesaaz/screen/home/home_screen_view_model.dart';
import 'package:homesaaz/service/profile_bloc.dart';

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  HomeScreenViewModel model;
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  Future<bool> _onWillPop() async {
    return (await showDialog(
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
        )) ??
        false;
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
              child: Row(
                children: [
                  Image.asset(
                    App.user,
                    color: ColorRes.darkRedColor58,
                    height: 16,
                    width: 16,
                  ),
                  SizedBox(width: 5,),
                  Text(Injector.loginResponse?.name ?? "",style: TextStyle(color: ColorRes.redColor),)
                ],
              ),
            ),
            InkWell(
              onTap: () {
                gotoCartScreen(context);
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    App.shopping_cart,
                    color: ColorRes.darkRedColor58,
                    height: 18,
                    width: 18,
                  ),
                  Container(
                    width: 14,
                    height: 14,
                    margin: EdgeInsets.only(left: 20,right: 10,bottom: 20),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: ColorRes.redColor,
                      borderRadius: BorderRadius.circular(30)
                    ),
                    child: StreamBuilder<int>(
                      stream: cartBloc.getCountData,
                      builder: (context, AsyncSnapshot<int> snapshot) {
                        if(snapshot.hasData) {
                          return Text(snapshot.data.toString(), style: TextStyle(
                              color: ColorRes.whiteColor, fontSize: 12),);
                        }else{
                          return Container();
                        }
                      }
                    ),
                  ),
                ],
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
                        //Home
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
                        //Profile
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
                        //My Cart
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
                        //Favorite
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
                        //My Orders
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
                        //Help
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
                        //LogOut
                        InkWell(
                          onTap: () {
                            Injector.updateUserData(null);
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

              //Top Banner --  imageApp.banner_top
              model.dashBoardModel != null && model.dashBoardModel.banners.length != 0
                  ? Image.network(model.dashBoardModel.banners[0].imageUrl,fit: BoxFit.cover, width: MediaQuery.of(context).size.width)
                  : Container(),

              SizedBox(height: 14),

              categories(),
              SizedBox(height: height * 0.05),

              //New Products
              newProduct(),

              //Center Banner
              Image.asset(App.banner_center, fit: BoxFit.cover, width: MediaQuery.of(context).size.width),
              SizedBox(height: height * 0.05),

              //Trending Products
              trendingProducts(),

              //Bottom Banner
              Image.asset(App.banner_bottom, fit: BoxFit.cover, width: MediaQuery.of(context).size.width),
              SizedBox(height: height * 0.05),

              //Featured Products
              featuredProducts(),
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
              child: InkWell(
                onTap: () => gotoCategoriesAll(context),
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
            ),
          ],
        ),
        SizedBox(height: 15),

        //Categories Images
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: GridView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: model.dashBoardModel != null &&
                model.dashBoardModel.categories.length != 0
                ? model.dashBoardModel.categories.length : 0,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 13.0,
                childAspectRatio: 1.6,
                //childAspectRatio: MediaQuery.of(context).size.width /
                //   (MediaQuery.of(context).size.height / 3),
                mainAxisSpacing: 17.0),
            itemBuilder: (BuildContext context, int index) {
              return model.dashBoardModel != null && model.dashBoardModel.categories.length != 0
                  ? InkWell(
                      onTap: () {
                        gotoSeeAllScreen(
                            context,
                            model.dashBoardModel.categories[index].categoryName,model.dashBoardModel.categories[index].categoryId);
                      },
                      child: Stack(
                        children: [
                          Image.network(
                            model.dashBoardModel.categories[index].categoryImage,
                            fit: BoxFit.cover,
                            width: MediaQuery.of(context).size.width,
                          ),
                          Container(
                            decoration: BoxDecoration(
                             /* color: Color(0xFFFFFFFFF),
                                image: DecorationImage(
                                image: AssetImage(model.categoriesImage[index]),
                                fit: BoxFit.cover),*/
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
                            child: Container(
                              alignment: Alignment.center,
                              child: Text(
                                model.dashBoardModel.categories[index].categoryName,
                                // model.categoriesName[index],
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
                    )
                  : Container(width: MediaQuery.of(context).size.width, height: 200);
            },
          ),
        ),
      ],
    );
  } //Categories

  //New Products
  Widget newProduct() {
    Size media = MediaQuery.of(context).size;
    double width = media.width;
    double height = media.height;
    return Column(
      children: [
        //New Products title
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
                gotoSeeAllScreen(context, "New Products",null);
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
        //New Products Images
        Container(
          padding: EdgeInsets.only(left: 25),
          color: ColorRes.primaryColor,
          height: 220,
          child: GridView.builder(
              itemCount: model.dashBoardModel != null &&
                         model.dashBoardModel.newProducts.length != 0
                         ? model.dashBoardModel.newProducts.length
                         : 0,
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,childAspectRatio: 0.9),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                // HomeScreenModel product = model.newProductName[index];
                return model.dashBoardModel != null && model.dashBoardModel.newProducts.length != 0
                    ? GestureDetector(
                        onTap: () {
                          gotoProductDetailScreen(context,model.dashBoardModel.newProducts[index]);
                        },
                        child: Card(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 7),
                            margin: EdgeInsets.symmetric(horizontal: 7),
                            child: productView(
                              model.dashBoardModel.newProducts[index].productImage,
                              model.dashBoardModel.newProducts[index].productName,
                              model.dashBoardModel.newProducts[index].discountedPrice,
                              model.dashBoardModel.newProducts[index].price,
                                true
                            ),
                          ),
                        ),
                      )
                    : Container(
                        width: MediaQuery.of(context).size.width,
                        height: 200,
                      );
              }),
        ),
        SizedBox(height: 18),
      ],
    );
  }

  //Trending Products
  Widget trendingProducts() {
    Size media = MediaQuery.of(context).size;
    double width = media.width;
    double height = media.height;
    return Column(
      children: [
        //Trending Products title
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
                gotoSeeAllScreen(context, "Trending Products",null);
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
        //Trending Products Images
        Container(
          padding: EdgeInsets.only(left: 25),
          color: ColorRes.primaryColor,
          height: 220,
          child: GridView.builder(
              itemCount: model.dashBoardModel != null && model.dashBoardModel.trendingProducts.length != 0
                  ? model.dashBoardModel.trendingProducts.length : 0,
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,childAspectRatio: 0.9),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                // HomeScreenModel product = model.trendingProductsName[index];
                return model.dashBoardModel != null && model.dashBoardModel.trendingProducts.length != 0
                    ? GestureDetector(
                        onTap: () {
                          gotoProductDetailScreen(context,model.dashBoardModel.trendingProducts[index]);
                        },
                        child: Card(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 7),
                            margin: EdgeInsets.symmetric(horizontal: 7),
                            child: productView(
                              model.dashBoardModel.trendingProducts[index].productImage,
                              model.dashBoardModel.trendingProducts[index].productName,
                              model.dashBoardModel.trendingProducts[index].discountedPrice,
                              model.dashBoardModel.trendingProducts[index].price,
                                true
                            ),
                          ),
                        ),
                      )
                    : Container(
                        width: MediaQuery.of(context).size.width,
                        height: 200,
                      );
              }),
        ),

        SizedBox(height: 18),
      ],
    );
  }

  //Featured Products
  Widget featuredProducts() {
    Size media = MediaQuery.of(context).size;
    double width = media.width;
    double height = media.height;
    return Column(
      children: [
        //Featured Products title
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
                gotoSeeAllScreen(context, "Featured Products",null);
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
        //Featured Products Images
        Container(
          padding: EdgeInsets.only(left: 25),
          color: ColorRes.primaryColor,
          height: 220,
          child: GridView.builder(
              itemCount: model.dashBoardModel != null &&
                         model.dashBoardModel.featuredProducts.length != 0
                         ? model.dashBoardModel.featuredProducts.length
                         : 0,
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,childAspectRatio: 0.9),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                //  HomeScreenModel product = model.featuredProductsName[index];
                return model.dashBoardModel != null &&
                        model.dashBoardModel.featuredProducts.length != 0
                    ? GestureDetector(
                        onTap: () {
                          gotoProductDetailScreen(context,model.dashBoardModel.featuredProducts[index]);
                        },
                        child: Card(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 7),
                            margin: EdgeInsets.symmetric(horizontal: 7),
                            child: productView(
                              model.dashBoardModel.featuredProducts[index].productImage,
                              model.dashBoardModel.featuredProducts[index].productName,
                              model.dashBoardModel.featuredProducts[index].discountedPrice,
                              model.dashBoardModel.featuredProducts[index].price,
                              true
                            ),
                          ),
                        ),
                      )
                    : Container(
                        width: MediaQuery.of(context).size.width,
                        height: 200,
                      );
              },
          ),
        ),

        SizedBox(height: 18),
      ],
    );
  }
}
