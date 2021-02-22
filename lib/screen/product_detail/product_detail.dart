import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:homesaaz/app.dart';
import 'package:homesaaz/common/colorres.dart';
import 'package:homesaaz/common/common_route.dart';
import 'package:homesaaz/common/common_widget.dart';
import 'package:homesaaz/common/dependency_injection.dart';
import 'package:homesaaz/model/dashboard_model.dart';
import 'package:homesaaz/screen/product_detail/product_detail_view_model.dart';

class ProductDetailScreen extends StatefulWidget {
  Product product;
  ProductDetailScreen(this.product);

  @override
  ProductDetailScreenState createState() => ProductDetailScreenState();
}

class ProductDetailScreenState extends State<ProductDetailScreen> {
  ProductDetailViewModel model;
  CarouselController carouselController = CarouselController();
  int _current = 0;
  int _currentColor = 0;

  String firstHalf;
  String secondHalf;

  bool flag = true;

  @override
  Widget build(BuildContext context) {
    print("Current page --> $runtimeType");
    model ?? (model = ProductDetailViewModel(this));

    return WillPopScope(
      onWillPop: () async {
        if(model.reloadStatus){
          Navigator.pop(context,"--");
        }else{
          Navigator.pop(context);
        }
        return false;
      },
      child: Scaffold(
        appBar: commonAppbar(context,isBack: model.reloadStatus),

        body: SafeArea(
          child: model.product==null ? Container() : Stack(
            alignment: Alignment.bottomCenter,
            children: [
              SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Stack(
                            alignment: Alignment.centerLeft,
                            children: [
                              CarouselSlider.builder(
                                itemCount: 1,
                                carouselController: carouselController,
                                itemBuilder: (BuildContext context, int itemIndex) =>
                                    Container(
                                  child: Container(
                                    margin: EdgeInsets.symmetric(horizontal: 5),
                                    child: CachedNetworkImage(
                                      imageUrl: model.product.data[0].productImage,
                                      placeholder: (context, url) => Image.asset(App.defaultImage,width: MediaQuery.of(context).size.width,fit: BoxFit.cover,),
                                      errorWidget: (context, url, error) => Image.asset(App.defaultImage,width: MediaQuery.of(context).size.width,fit: BoxFit.cover,),
                                    ),
                                  ),
                                ),
                                options: CarouselOptions(
                                  autoPlay: false,
                                  viewportFraction: 1.0,
                                  enlargeCenterPage: false,
                                  onPageChanged: (index, reason) {
                                    setState(() {
                                      _current = index;
                                    });
                                  },
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 20, bottom: 5),
                                  child: Container(
                                    height: 20,
                                    child: ListView.builder(
                                      itemCount: 1,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return Container(
                                          width: 6,
                                          height: 6,
                                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: _current == index
                                                ? ColorRes.redColor
                                                : ColorRes.whiteColor,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              model.product.data[0].wishlistStatus ? Positioned(
                                right: 0,
                                top: 10,
                                child: InkWell(
                                  onTap: () async {
                                    if(Injector.loginResponse==null){
                                      gotoLoginScreen(context,isBack: true);
                                    }else {
                                      await model.removeWishList(model.product.data[0].itemdetId);
                                      model.product.data[0].wishlistStatus =
                                      !model.product.data[0].wishlistStatus;
                                      setState(() {

                                      });
                                    }
                                  },
                                  child: Image.asset('assets/icon/heart.png',height: 30,width: 30),
                                ),
                              ) : Positioned(
                                right: 0,
                                top: 10,
                                child: InkWell(
                                  onTap: () async {
                                    if(Injector.loginResponse==null){
                                      gotoLoginScreen(context,isBack: true);
                                    }else {
                                      await model.addToWish(model.product.data[0].itemdetId);
                                      model.product.data[0].wishlistStatus = !model.product.data[0].wishlistStatus;
                                      setState(() {

                                      });
                                    }
                                  },
                                  child: Image.asset('assets/icon/heart_outline.png',height: 30,width: 30),
                                ),
                              )
                            ],
                          ),
                          // child: CachedNetworkImage(
                          //   imageUrl: model.product.data[0].productImage,
                          //   placeholder: (context, url) => Image.asset(App.defaultImage,width: MediaQuery.of(context).size.width,fit: BoxFit.cover,),
                          //   errorWidget: (context, url, error) => Image.asset(App.defaultImage,width: MediaQuery.of(context).size.width,fit: BoxFit.cover,),
                          // ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          height: 40,
                          child: ListView.builder(
                            itemCount: 1,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int itemIndex) =>
                                Opacity(
                              opacity: 1,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _current = itemIndex;
                                    carouselController.animateToPage(_current);
                                  });
                                },
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      width: 80,
                                      padding: EdgeInsets.symmetric(horizontal: 7),
                                      child: CachedNetworkImage(
                                        imageUrl: model.product.data[0].productImage,
                                        placeholder: (context, url) => Image.asset(App.defaultImage,width: MediaQuery.of(context).size.width,fit: BoxFit.cover,),
                                        errorWidget: (context, url, error) => Image.asset(App.defaultImage,width: MediaQuery.of(context).size.width,fit: BoxFit.cover,),
                                      ),
                                    ),
                                    _current != itemIndex
                                        ? Container(
                                            width: 70,
                                            padding:
                                                EdgeInsets.symmetric(horizontal: 7),
                                            color:
                                                ColorRes.whiteColor.withOpacity(0.4),
                                          )
                                        : Container()
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 10),
                              Text(
                                model.product.data[0].productName,
                                style: TextStyle(fontSize: 25, color: ColorRes.nero),
                              ),
                              SizedBox(height: 3),
                              Text(
                                "Product Code: ${model.product.data[0].itemdetId}",
                                style: TextStyle(fontSize: 13, color: ColorRes.textColor.withOpacity(0.7)),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                    Text(
                                      "₹${model.product.data[0].price}",
                                      style:
                                      TextStyle(fontSize: 22, color: ColorRes.redColor),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    model.product.data[0].discountedPrice ==0 ? Container() : Text(
                                      "\$${model.product.data[0].discountedPrice}",
                                      style: TextStyle(fontSize: 22, color: ColorRes.dimGray.withOpacity(0.7)),
                                    ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    width: 100,
                                    decoration: BoxDecoration(border: Border.all(color: ColorRes.dimGray.withOpacity(0.1)),borderRadius: BorderRadius.circular(8)),
                                    padding: EdgeInsets.symmetric(horizontal:5,vertical: 3),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                            child: Container(
                                              decoration: BoxDecoration(color: ColorRes.redColor,borderRadius: BorderRadius.circular(8)),
                                              padding: const EdgeInsets.all(5),
                                              child: Icon(
                                                Icons.remove,
                                                size: MediaQuery.of(context).size.width/25,
                                                color: ColorRes.whiteColor,
                                              ),
                                            ),
                                            onTap: () async {
                                              if (model.product.data[0].prodqty != 1) {
                                                if(model.product.data[0].productexistInCart){
                                                  await model.updateQuantity(model.product.data[0].itemdetId,"minus");
                                                }
                                                setState(() {
                                                  model.product.data[0].prodqty--;
                                                });
                                              }
                                            }),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 10),
                                          child: Text(
                                            '${model.product.data[0].prodqty}',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: ColorRes.charcoal,
                                              fontFamily: 'NeueFrutigerWorld',
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                            child: Container(
                                              decoration: BoxDecoration(color: ColorRes.redColor,borderRadius: BorderRadius.circular(8)),
                                              padding: const EdgeInsets.all(5),
                                              child: Icon(
                                                Icons.add,
                                                size: MediaQuery.of(context).size.width/25,
                                                color: ColorRes.whiteColor,
                                              ),
                                            ),
                                            onTap: () async {
                                              if(model.product.data[0].productexistInCart){
                                                await model.updateQuantity(model.product.data[0].itemdetId,"plus");
                                              }
                                              setState(() {
                                                model.product.data[0].prodqty++;
                                              });
                                            }),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              model.product.data[0].sizeName == "" ? Container() : Text(
                                "Size: ${model.product.data[0].sizeName}",
                                style: TextStyle(fontSize: 13, color: ColorRes.textColor.withOpacity(0.7)),
                              ),
                              model.product.data[0].sizeName == "" ? Container() : SizedBox(
                                height: 20,
                              ),
                              model.product.data[0].hsnCode == "" ? Container() : Text(
                                "HSN Code: ${model.product.data[0].hsnCode}",
                                style: TextStyle(fontSize: 13, color: ColorRes.textColor.withOpacity(0.7)),
                              ),
                              model.product.data[0].hsnCode == "" ? Container() : SizedBox(
                                height: 20,
                              ),
                              model.product.data[0].designName == "" ? Container() : Text(
                                "Design Name: ${model.product.data[0].designName}",
                                style: TextStyle(fontSize: 13, color: ColorRes.textColor.withOpacity(0.7)),
                              ),
                              model.product.data[0].designName == "" ? Container() : SizedBox(
                                height: 20,
                              ),
                              model.product.data[0].description == "" ? Container() : Text(
                                "Description",
                                style: TextStyle(fontSize: 16, color: ColorRes.textColor.withOpacity(0.8)),
                              ),
                              model.product.data[0].description == "" ? Container() : SizedBox(
                                height: 7,
                              ),
                              // Text(model.product.description,style: TextStyle(fontSize: 18,color: ColorRes.textColor),maxLines: 5,),
                              model.product.data[0].description == "" ? Container() : secondHalf.isEmpty
                                  ? new Text(firstHalf,
                                  style:
                                  TextStyle(fontSize: 14, color: ColorRes.dimGray,height: 1.5))
                                  : new Column(
                                children: <Widget>[
                                  new Text(
                                      flag
                                          ? (firstHalf + "...")
                                          : (firstHalf + secondHalf),
                                      style: TextStyle(
                                          fontSize: 14, color: ColorRes.dimGray,height:1.5)),
                                  new GestureDetector(
                                    child: new Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        new Text(
                                          flag ? "More" : "Less",
                                          style: new TextStyle(
                                              color: ColorRes.redColor,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    onTap: () {
                                      setState(() {
                                        flag = !flag;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 5, bottom: 10),
                          child: Divider(height: 1, color: ColorRes.gray57),
                        ),
                        // Container(
                        //   padding: const EdgeInsets.symmetric(horizontal: 15),
                        //   child: Row(
                        //     children: [
                        //       Text(
                        //         "Select Color",
                        //         style:
                        //             TextStyle(fontSize: 18, color: ColorRes.textColor.withOpacity(0.8)),
                        //       ),
                        //       Container(
                        //         height: 40,
                        //         child: ListView.builder(
                        //           itemCount: model.product.data[0].colors.length,
                        //           shrinkWrap: true,
                        //           scrollDirection: Axis.horizontal,
                        //           itemBuilder: (BuildContext context, int itemIndex) =>
                        //               GestureDetector(
                        //             onTap: () {
                        //               setState(() {
                        //                 _currentColor = itemIndex;
                        //               });
                        //             },
                        //             child: Stack(
                        //               alignment: Alignment.center,
                        //               children: [
                        //                 Padding(
                        //                   padding: const EdgeInsets.symmetric(
                        //                       horizontal: 10),
                        //                   child: ClipRRect(
                        //                     borderRadius: BorderRadius.circular(40),
                        //                     child: Container(
                        //                       width: 40,
                        //                       decoration: BoxDecoration(
                        //                         color: Color(int.parse(
                        //                             '0xff${model.product.colors[itemIndex]}')),
                        //                       ),
                        //                       // padding: EdgeInsets.symmetric(horizontal: 5),
                        //                     ),
                        //                   ),
                        //                 ),
                        //                 _currentColor != itemIndex
                        //                     ? Container(
                        //                         width: 40,
                        //                         padding:
                        //                             EdgeInsets.symmetric(horizontal: 5),
                        //                         color: ColorRes.whiteColor
                        //                             .withOpacity(0.4),
                        //                       )
                        //                     : Container()
                        //               ],
                        //             ),
                        //           ),
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.only(
                        //       top: 10, bottom: 10),
                        //   child: Divider(height: 1, color: ColorRes.gray57),
                        // ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height*0.22,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                height: 50,
                child: Row(
                  children: [
                    !model.product.data[0].productexistInCart ? InkWell(
                      onTap: () async {
                        if(Injector.loginResponse==null){
                          gotoLoginScreen(context,isBack: true);
                        }else {
                          await model.addToCart(true);
                          await model.getCartData();
                          model.product.data[0].productexistInCart = !model.product.data[0].productexistInCart;
                          setState(() {});
                        }
                      },
                      child: Container(
                        color: ColorRes.whisper,
                        width: MediaQuery.of(context).size.width/2,
                        padding: EdgeInsets.all(10),
                        alignment: Alignment.center,
                        child: Text(
                          "ADD TO CART",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ) : Container() ,
                    InkWell(
                      onTap: () async {
                        if(Injector.loginResponse==null){
                          gotoLoginScreen(context,isBack: true);
                        }else {
                          await model.addToCart(false);
                          var cart = await model.getCartData();
                          model.product.data[0].productexistInCart = !model.product.data[0].productexistInCart;
                          setState(() {});
                          if (cart != null) {
                            gotoAddressScreen(context, cart);
                          }
                        }
                      },
                      child: Container(
                        color: ColorRes.red,
                        width: model.product.data[0].productexistInCart ? MediaQuery.of(context).size.width : MediaQuery.of(context).size.width/2,
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "BUY NOW",
                          style: TextStyle(fontSize: 18,color: ColorRes.whiteColor),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
