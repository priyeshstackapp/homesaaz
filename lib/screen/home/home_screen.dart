import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:homesaaz/app.dart';
import 'package:homesaaz/common/colorres.dart';
import 'package:homesaaz/common/common_route.dart';
import 'package:homesaaz/common/common_widget.dart';
import 'package:homesaaz/common/dependency_injection.dart';
import 'package:homesaaz/common/util.dart';
import 'package:homesaaz/model/dashboard_model.dart';
import 'package:homesaaz/model/search_model.dart';
import 'package:homesaaz/screen/home/home_screen_view_model.dart';
import 'package:homesaaz/service/profile_bloc.dart';

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  HomeScreenViewModel model;

  bool isSearching = false;

  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  Future<bool> _onWillPop() async {
    if(isSearching){
      setState(() {
        isSearching = false;
      });
      return false;
    }else {
      return (await showDialog(
        context: context,
        builder: (context) =>
        new AlertDialog(
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
                FocusScope.of(context).unfocus();
                if(Utils.checkLogin()) {
                  gotoProfileScreen(context);
                }else{
                  gotoLoginScreen(context);
                }
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
                FocusScope.of(context).unfocus();
                if(Utils.checkLogin()) {
                  gotoCartScreen(context);
                }else{
                  gotoLoginScreen(context);
                }
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
            child: Utils.checkLogin() ?
            Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  height: height * 0.8,
                  width: width * width,
                  color: ColorRes.primaryColor,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //Home
                        InkWell(
                          onTap: () {
              FocusScope.of(context).unfocus();
                            replaceWithHomeScreen(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10),
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
              FocusScope.of(context).unfocus();
                            gotoProfileScreen(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10),
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
              FocusScope.of(context).unfocus();
                            gotoCartScreen(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10),
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
                          onTap: () {
              FocusScope.of(context).unfocus();
                            gotoWishScreen(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              "My Wish List",
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
              FocusScope.of(context).unfocus();
                            gotoAddressScreen(context, null);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              "Manage Address",
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
              FocusScope.of(context).unfocus();
                            gotoMyOrdersScreen(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10),
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
                            padding: const EdgeInsets.all(10),
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
              FocusScope.of(context).unfocus();
                            Injector.updateUserData(null);
                            setState(() {});
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10),
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
            ) :
            Column(
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
              FocusScope.of(context).unfocus();
                          gotoLoginScreen(context,isBack: false);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            "Login",
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
              FocusScope.of(context).unfocus();
                          gotoSignUpScreen(context,isBack: false);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            "SignUp",
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 5),

              search(),
              SizedBox(height: 20),

              isSearching ?
              searchProduct() :
              Column(
                children: [
                  //Top Banner --  imageApp.banner_top
                  model.dashBoardModel != null && model.dashBoardModel.banners.length != 0
                      ? CarouselSlider.builder(
                    itemCount: model.dashBoardModel.banners.length,
                    // carouselController: carouselController,
                    itemBuilder: (BuildContext context, int itemIndex) {
                      return InkWell(
                        onTap: () async {
                          if(model.dashBoardModel.staticBanner[1].actionType=="product"){
                            var res = await gotoProductDetailScreen(context, Product(itemdetId: model.dashBoardModel.banners[itemIndex].actionId));
                            if(res!=null){
                              model.dashBoardApi();
                            }
                          }else{
                            gotoSeeAllScreen(context, "Category",model.dashBoardModel.banners[itemIndex].actionId,cat: true);
                          }
                        },
                        child: Container(
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            child: CachedNetworkImage(
                              imageUrl: model.dashBoardModel.banners[itemIndex].imageUrl,
                              placeholder: (context, url) => Image.asset(App.defaultImage,width: MediaQuery.of(context).size.width,fit: BoxFit.cover,),
                              errorWidget: (context, url, error) => Image.asset(App.defaultImage,width: MediaQuery.of(context).size.width,fit: BoxFit.cover,),
                            ),
                          ),
                        ),
                      );
                    },
                    options: CarouselOptions(
                      autoPlay: true,
                      viewportFraction: 1.0,
                      enlargeCenterPage: false,
                    ),
                  )
                      : Container(),

                  SizedBox(height: 14),

                  categories(),
                  SizedBox(height: 50),

                  //New Products
                  newProduct(),

                  //Center Banner
                  model.dashBoardModel != null && model.dashBoardModel.staticBanner.isNotEmpty && model.dashBoardModel.staticBanner[0].displayStatus =="show"
                      ? InkWell(
                      onTap: () async {
                        if(model.dashBoardModel.staticBanner[0].actionType=="product"){
                          var res = await gotoProductDetailScreen(context, Product(itemdetId: model.dashBoardModel.staticBanner[0].actionId));
                          if(res!=null){
                            model.dashBoardApi();
                          }
                        }else{
                          gotoSeeAllScreen(context, "Category",model.dashBoardModel.staticBanner[0].actionId,cat: true);
                        }
                      },
                      child: Image.network(model.dashBoardModel.staticBanner[0].bannerImg,
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width))
                      : Container(),
                  model.dashBoardModel != null && model.dashBoardModel.staticBanner.isNotEmpty
                      ? SizedBox(height: 50) : Container(),

                  SizedBox(height: height * 0.05),

                  //Trending Products
                  trendingProducts(),

                  //Bottom Banner
                  model.dashBoardModel != null && model.dashBoardModel.staticBanner.isNotEmpty && model.dashBoardModel.staticBanner[1].displayStatus =="show"
                      ? InkWell(
                      onTap: () async {
                        if(model.dashBoardModel.staticBanner[1].actionType=="product"){
                          var res = await gotoProductDetailScreen(context, Product(itemdetId: model.dashBoardModel.staticBanner[1].actionId));
                          if(res!=null){
                            model.dashBoardApi();
                          }
                        }else{
                          gotoSeeAllScreen(context, "Category",model.dashBoardModel.staticBanner[1].actionId,cat: true);
                        }
                      },
                      child: Image.network(model.dashBoardModel.staticBanner[1].bannerImg,
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width))
                      : Container(),
                  model.dashBoardModel != null && model.dashBoardModel.staticBanner.isNotEmpty
                      ? SizedBox(height: 50) : Container(),

                  //Featured Products
                  featuredProducts(),
                  model.dashBoardModel != null && model.dashBoardModel.staticBanner.isNotEmpty && model.dashBoardModel.staticBanner[2].displayStatus =="show"
                      ? InkWell(
                      onTap: () async {
                        if(model.dashBoardModel.staticBanner[2].actionType=="product"){
                          var res = await gotoProductDetailScreen(context, Product(itemdetId: model.dashBoardModel.staticBanner[2].actionId));
                          if(res!=null){
                            model.dashBoardApi();
                          }
                        }else{
                          gotoSeeAllScreen(context, "Category",model.dashBoardModel.staticBanner[2].actionId,cat: true);
                        }
                      },
                      child: Image.network(model.dashBoardModel.staticBanner[2].bannerImg,
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width))
                      : Container(),
                  model.dashBoardModel != null && model.dashBoardModel.staticBanner.isNotEmpty
                      ? SizedBox(height: 50) : Container(),
                ],
              )
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
          searchCall: (s) {
            FocusScope.of(context).unfocus();
            if(s.isNotEmpty){
              print(s);
              setState(() {
                isSearching = true;
              });
              model.getSearchData(s);
            }
          },
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
                FocusScope.of(context).unfocus();
                        gotoSeeAllScreen(
                            context,
                            model.dashBoardModel.categories[index].categoryName,model.dashBoardModel.categories[index].categoryId,cat: true);
                      },
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              model.dashBoardModel.categories[index].categoryImage,
                              fit: BoxFit.cover,
                              width: MediaQuery.of(context).size.width,
                            ),
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
                FocusScope.of(context).unfocus();
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
          padding: EdgeInsets.only(left: 20),
          color: ColorRes.primaryColor,
          height: 245,
          child: ListView.builder(
              itemCount: model.dashBoardModel != null &&
                         model.dashBoardModel.newProducts.length != 0
                         ? model.dashBoardModel.newProducts.length
                         : 0,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                // HomeScreenModel product = model.newProductName[index];
                return model.dashBoardModel != null && model.dashBoardModel.newProducts.length != 0
                    ? GestureDetector(
                        onTap: () async {
                          var res = await gotoProductDetailScreen(context, model.dashBoardModel.newProducts[index]);
                          if(res!=null){
                            model.dashBoardApi();
                          }
                        },
                        child: Stack(
                          children: [
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              elevation: 2,
                              child: Container(
                                height: model.dashBoardModel.newProducts[index].stockStatus=="outofstock" ? 200 : 245,
                                padding: EdgeInsets.symmetric(horizontal: 3),
                                margin: EdgeInsets.symmetric(horizontal: 5),
                                child: productView(
                                  model.dashBoardModel.newProducts[index].productImage,
                                  model.dashBoardModel.newProducts[index].productName,
                                  model.dashBoardModel.newProducts[index].discountedPrice,
                                  model.dashBoardModel.newProducts[index].price,() async {
                                 await  model.addToCart(model.dashBoardModel.newProducts[index].itemdetId,model.dashBoardModel.newProducts[index].count);
                                 model.dashBoardModel.newProducts[index].count = 1;
                                 setState(() {

                                 });
                                },
                                    model.dashBoardModel.newProducts[index].stockStatus=="outofstock",
                                    () async {
                                      if(model.dashBoardModel.newProducts[index].wishlistStatus) {
                                        await model.removeFromCart(model.dashBoardModel
                                            .newProducts[index].itemdetId);
                                      }else{
                                        await model.addToWish(model.dashBoardModel
                                            .newProducts[index].itemdetId);
                                      }
                                      model.dashBoardModel.newProducts[index].wishlistStatus = !model.dashBoardModel.newProducts[index].wishlistStatus;
                                      setState(() {

                                      });
                                    },() async {
                                  if(model.dashBoardModel.newProducts[index].productexistInCart){
                                    await model.updateQuantity(model.dashBoardModel.newProducts[index].itemdetId, "plus");
                                  }
                                  setState(() {
                                    model.dashBoardModel.newProducts[index].count ++;
                                  });

                                }, () async {
                                  if (model.dashBoardModel.newProducts[index].count != 1 || model.dashBoardModel.newProducts[index].count != 0) {
                                    if(model.dashBoardModel.newProducts[index].productexistInCart){
                                      await model.updateQuantity(model.dashBoardModel.newProducts[index].itemdetId, "minus");
                                    }
                                    setState(() {
                                      model.dashBoardModel.newProducts[index].count --;
                                    });
                                  }
                                },model.dashBoardModel.newProducts[index].count,
                                  model.dashBoardModel.newProducts[index].wishlistStatus,
                                  model.dashBoardModel.newProducts[index].productexistInCart,
                                  context
                                ),
                              ),
                            ),
                            model.dashBoardModel.newProducts[index].stockStatus=="outofstock" ? Container(
                                decoration: BoxDecoration(color: ColorRes.redColor,borderRadius: BorderRadius.only(topRight: Radius.circular(12),bottomRight: Radius.circular(12),)),
                                padding: EdgeInsets.all(5),
                                // margin: EdgeInsets.only(top: 30),
                                child: Text("Out of stock",style: TextStyle(color: ColorRes.whiteColor,fontSize: 12),)) : Container()
                          ],
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
                FocusScope.of(context).unfocus();
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
          child: ListView.builder(
              itemCount: model.dashBoardModel != null && model.dashBoardModel.trendingProducts.length != 0
                  ? model.dashBoardModel.trendingProducts.length : 0,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                // HomeScreenModel product = model.trendingProductsName[index];
                return model.dashBoardModel != null && model.dashBoardModel.trendingProducts.length != 0
                    ? GestureDetector(
                        onTap: () async {
                          var res = await gotoProductDetailScreen(context, model.dashBoardModel.trendingProducts[index]);
                          if(res!=null){
                            model.dashBoardApi();
                          }
                        },
                        child: Stack(
                          children: [
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              elevation: 2,
                              child: Container(
                                height: model.dashBoardModel.trendingProducts[index].stockStatus=="outofstock" ? 200 : 245,
                                padding: EdgeInsets.symmetric(horizontal: 7),
                                margin: EdgeInsets.symmetric(horizontal: 7),
                                child: productView(
                                  model.dashBoardModel.trendingProducts[index].productImage,
                                  model.dashBoardModel.trendingProducts[index].productName,
                                  model.dashBoardModel.trendingProducts[index].discountedPrice,
                                  model.dashBoardModel.trendingProducts[index].price,
                                        () async {
                                      await model.addToCart(model.dashBoardModel.trendingProducts[index].itemdetId,model.dashBoardModel.trendingProducts[index].count);
                                      model.dashBoardModel.trendingProducts[index].count = 1;
                                      setState(() {

                                      });
                                    },
                                  model.dashBoardModel.trendingProducts[index].stockStatus=="outofstock",
                                        () async {
                                          if(model.dashBoardModel.trendingProducts[index].wishlistStatus) {
                                            await model.removeFromCart(model.dashBoardModel
                                                .trendingProducts[index].itemdetId);
                                          }else{
                                            await model.addToWish(model.dashBoardModel
                                                .trendingProducts[index].itemdetId);
                                          }
                                          model.dashBoardModel.trendingProducts[index].wishlistStatus = !model.dashBoardModel.trendingProducts[index].wishlistStatus;
                                          setState(() {

                                          });
                                    },() async {
                                  if(model.dashBoardModel.newProducts[index].productexistInCart){
                                    await model.updateQuantity(model.dashBoardModel.newProducts[index].itemdetId, "plus");
                                  }
                                  setState(() {
                                    model.dashBoardModel.trendingProducts[index].count ++;
                                  });
                                }, () async {
                                  if (model.dashBoardModel.trendingProducts[index].count != 1 || model.dashBoardModel.trendingProducts[index].count != 0) {
                                    if(model.dashBoardModel.trendingProducts[index].productexistInCart){
                                      await model.updateQuantity(model.dashBoardModel.trendingProducts[index].itemdetId, "minus");
                                    }
                                    setState(() {
                                      model.dashBoardModel.trendingProducts[index].count --;
                                    });
                                  }
                                },model.dashBoardModel.trendingProducts[index].count,
                                  model.dashBoardModel.trendingProducts[index].wishlistStatus,
                                  model.dashBoardModel.trendingProducts[index].productexistInCart,
                                  context
                                ),
                              ),
                            ),
                            model.dashBoardModel.trendingProducts[index].stockStatus=="outofstock" ? Container(
                                decoration: BoxDecoration(color: ColorRes.redColor,borderRadius: BorderRadius.only(topRight: Radius.circular(12),bottomRight: Radius.circular(12),)),
                                padding: EdgeInsets.all(5),
                                // margin: EdgeInsets.only(top: 30),
                                child: Text("Out of stock",style: TextStyle(color: ColorRes.whiteColor,fontSize: 12),)) : Container()
                          ],
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
                FocusScope.of(context).unfocus();
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
          child: ListView.builder(
              itemCount: model.dashBoardModel != null &&
                         model.dashBoardModel.featuredProducts.length != 0
                         ? model.dashBoardModel.featuredProducts.length
                         : 0,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                //  HomeScreenModel product = model.featuredProductsName[index];
                return model.dashBoardModel != null &&
                        model.dashBoardModel.featuredProducts.length != 0
                    ? GestureDetector(
                        onTap: () async {
                          var res = await gotoProductDetailScreen(context, model.dashBoardModel.featuredProducts[index]);
                          if(res!=null){
                            model.dashBoardApi();
                          }
                        },
                        child: Stack(
                          children: [
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Container(
                                height: model.dashBoardModel.featuredProducts[index].stockStatus=="outofstock" ? 200 : 245,
                                padding: EdgeInsets.symmetric(horizontal: 7),
                                margin: EdgeInsets.symmetric(horizontal: 7),
                                child: productView(
                                  model.dashBoardModel.featuredProducts[index].productImage,
                                  model.dashBoardModel.featuredProducts[index].productName,
                                  model.dashBoardModel.featuredProducts[index].discountedPrice,
                                  model.dashBoardModel.featuredProducts[index].price,
                                        () async {
                                      await model.addToCart(model.dashBoardModel.featuredProducts[index].itemdetId,model.dashBoardModel.featuredProducts[index].count);
                                      model.dashBoardModel.featuredProducts[index].count = 1;
                                      setState(() {

                                      });
                                    },
                                    model.dashBoardModel.featuredProducts[index].stockStatus=="outofstock",
                                        () async {
                                    if(model.dashBoardModel.featuredProducts[index].wishlistStatus) {
                                      await model.removeFromCart(model.dashBoardModel
                                          .featuredProducts[index].itemdetId);
                                    }else{
                                      await model.addToWish(model.dashBoardModel
                                          .featuredProducts[index].itemdetId);
                                    }
                                      model.dashBoardModel.featuredProducts[index].wishlistStatus = !model.dashBoardModel.featuredProducts[index].wishlistStatus;
                                      setState(() {

                                      });
                                    },() async {
                                  if(model.dashBoardModel.featuredProducts[index].productexistInCart){
                                    await model.updateQuantity(model.dashBoardModel.featuredProducts[index].itemdetId, "plus");
                                  }
                                  setState(() {
                                    model.dashBoardModel.featuredProducts[index].count ++;
                                  });
                                }, () async {
                                  if (model.dashBoardModel.featuredProducts[index].count != 1 || model.dashBoardModel.featuredProducts[index].count != 0) {
                                    if(model.dashBoardModel.featuredProducts[index].productexistInCart){
                                      await model.updateQuantity(model.dashBoardModel.featuredProducts[index].itemdetId, "minus");
                                    }
                                    setState(() {
                                      model.dashBoardModel.featuredProducts[index].count --;
                                    });
                                  }
                                },model.dashBoardModel.featuredProducts[index].count,
                                  model.dashBoardModel.featuredProducts[index].wishlistStatus,
                                  model.dashBoardModel.featuredProducts[index].productexistInCart,
                                  context
                                ),
                              ),
                            ),
                            model.dashBoardModel.featuredProducts[index].stockStatus=="outofstock" ? Container(
                                decoration: BoxDecoration(color: ColorRes.redColor,borderRadius: BorderRadius.only(topRight: Radius.circular(12),bottomRight: Radius.circular(12),)),
                                padding: EdgeInsets.all(5),
                                // margin: EdgeInsets.only(top: 30),
                                child: Text("Out of stock",style: TextStyle(color: ColorRes.whiteColor,fontSize: 12),)) : Container(),
                          ],
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

  //Featured Products
  Widget searchProduct() {
    return Container(
      padding: EdgeInsets.only(left: 25),
      color: ColorRes.primaryColor,
      child: GridView.builder(
          itemCount: model.searchModel != null &&
                     model.searchModel.searchItem != null
                     ? model.searchModel.searchItem.length
                     : 0,
          shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,mainAxisSpacing: 5,crossAxisSpacing: 5,childAspectRatio: 0.95),
          itemBuilder: (context, index) {
             SearchItem product = model.searchModel.searchItem[index];
            return GestureDetector(
              onTap: () async {
                var res = await gotoProductDetailScreen(context, Product(itemdetId: model.searchModel.searchItem[index].itemdetId));
                if(res!=null){
                  model.dashBoardApi();
                }
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 7),
                  margin: EdgeInsets.symmetric(horizontal: 7),
                  child: searchProductView(
                      null,
                      product.productName,
                      context
                  ),
                ),
              ),
            );
          },
      ),
    );
  }
}
