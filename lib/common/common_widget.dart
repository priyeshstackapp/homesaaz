import 'package:flutter/material.dart';
import 'package:homesaaz/app.dart';
import 'package:homesaaz/common/colorres.dart';
import 'package:homesaaz/common/common_route.dart';
import 'package:homesaaz/common/dependency_injection.dart';
import 'package:homesaaz/common/loder_show.dart';
import 'package:homesaaz/model/cart_model.dart';
import 'package:homesaaz/model/my_order_model.dart';
import 'package:homesaaz/model/order_details_model.dart';
import 'package:homesaaz/model/wish_model.dart';
import 'package:homesaaz/screen/cart/cart_screen.dart';
import 'package:homesaaz/screen/checkout/checkout_screen.dart';
import 'package:homesaaz/screen/my_orders/my_orders_screen.dart';
import 'package:homesaaz/screen/my_orders_details/my_orders_detail_screen.dart';
import 'package:homesaaz/service/profile_bloc.dart';
import 'package:rating_bar/rating_bar.dart';

Widget gradientButton(context, {String title}) {
  return Container(
    height: MediaQuery.of(context).size.height * .060,
    width: MediaQuery.of(context).size.width / 1.2,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      boxShadow: [
        BoxShadow(
          color: ColorRes.redColor.withOpacity(0.7),
          offset: Offset(0.0, 3.0), //(x,y)
          blurRadius: 3.0,
        ),
      ],
      gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [ColorRes.redColor, ColorRes.darkRedColor]),
    ),
    child: Center(
        child: Text(title,
            style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'NeueFrutigerWorld',
                fontWeight: FontWeight.w700))),
  );
}

showSnackBar(_scaffoldKey, String message, {bool isError = false}) {
  _scaffoldKey.currentState.showSnackBar(new SnackBar(
    content: new Text(
      message,
      textAlign: TextAlign.center,
      style:
          TextStyle(color: isError ? ColorRes.whiteColor : ColorRes.redColor),
    ),
    backgroundColor: isError ? ColorRes.redColor : ColorRes.whiteColor,
    duration: Duration(seconds: 3),
  ));
}

Widget backButton(context,{bool isBack}) {
  return InkWell(
    onTap: () {
      if(isBack){
        Navigator.pop(context,"--");
      }else {
        Navigator.pop(context);
      }
    },
    child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Image.asset(
        App.left_arrow,
        color: ColorRes.darkRedColor58,
      ),
    ),
  );
}

Widget loginAndSignupbackButton(context) {
  return InkWell(
    onTap: () {
      //   Navigator.pop(context);
    },
    child: Image.asset(
      App.left_arrow,
      color: ColorRes.dimGray.withOpacity(0.3),
      height: 22,
      width: 22,
    ),
  );
}

class CustomTextFieldShadow extends StatelessWidget {
  final String text, name;
  final TextEditingController fieldController;
  final bool obscureText;
  final TextInputType keyboartType;
  final Size media;
  final BuildContext context;
  final int mxline;

  CustomTextFieldShadow(
      {Key key,
      this.text,
      this.fieldController,
      this.name,
      this.obscureText,
      this.keyboartType,
      this.context,
      this.media,
      this.mxline})
      : super(key: key);

  var _keyboartType;
  Widget _prefixiconData;

  @override
  Widget build(BuildContext context) {
    if (obscureText == false && name == "Search") {
      _keyboartType = keyboartType;
      _prefixiconData = Icon(
        Icons.search,
        color: Colors.grey,
      );
    } else {
      _keyboartType = TextInputType.text;
      _prefixiconData = null;
    }
    return Container(
      height: 45,
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFFF),
        borderRadius: BorderRadius.circular(5.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 5.5,
            spreadRadius: 1.5,
            offset: Offset(0.0, 9.0),
          ),
        ],
      ),
      child: TextFormField(
        controller: fieldController,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 5.0),
          prefixIcon: _prefixiconData != null
              ? Padding(
                  padding: EdgeInsets.all(0.0),
                  child: _prefixiconData,
                )
              : null,
          hintText: text,
          hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
          fillColor: ColorRes.transparent,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            borderSide: BorderSide(color: ColorRes.transparent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            borderSide: BorderSide(color: ColorRes.transparent),
          ),
        ),
        obscureText: obscureText,
        keyboardType: _keyboartType,
        minLines: 1,
        maxLines: mxline,
      ),
    );
  }
}

Widget productView(
    String imageUrl,
    String productName,
    int discount,
    String price,
    Function addToCart,
    bool stockOut,
    VoidCallback addToWish,
    VoidCallback increment,
    VoidCallback decrement,
    int count,
    bool wishlistStatus,
    bool productexistInCart,context) {
  return Stack(
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            child: imageUrl!=null && imageUrl.isNotEmpty
                ? Image.network(imageUrl,fit: BoxFit.cover,height: MediaQuery.of(context).size.width/3,)
                : Image.asset(App.defaultImage, fit: BoxFit.cover,height: MediaQuery.of(context).size.width/3),
          ),
          SizedBox(
            height: 5,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 160,
                child: Text(
                  productName +"shbdv jshd hsd shd asjd ksjd asjd hsdhasdha duhsa dh dhsahds".toUpperCase(),
                  style: new TextStyle(
                    color: ColorRes.charcoal,
                    fontFamily: 'NeueFrutigerWorld',
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                  maxLines: 2,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        discount == 0 ? '₹ $price' : "${int.parse(price)-discount}",
                        style: new TextStyle(
                          fontSize: 14,
                          color: ColorRes.red,
                          fontFamily: 'NeueFrutigerWorld',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      discount == 0 ? Container() : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '₹ $price',
                          style: TextStyle(
                            fontSize: 14,
                            color: ColorRes.red,
                            fontFamily: 'NeueFrutigerWorld',
                            fontWeight: FontWeight.w200,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 7,),
           !stockOut ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
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
                                size: MediaQuery.of(context).size.width/35,
                                color: ColorRes.whiteColor,
                              ),
                            ),
                            onTap: decrement),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            '$count',
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
                                size: MediaQuery.of(context).size.width/35,
                                color: ColorRes.whiteColor,
                              ),
                            ),
                            onTap: increment),
                      ],
                    ),
                  ),
                  productexistInCart ? Container() : InkWell(
                    onTap: () async {
                      addToCart.call();
                    },
                    child: Container(
                      decoration: BoxDecoration(color: ColorRes.redColor,borderRadius: BorderRadius.circular(8)),
                      padding: EdgeInsets.symmetric(horizontal:8,vertical: 5),
                      child: Text(
                        "Add to cart",
                        style: TextStyle(
                            color: ColorRes.whiteColor,
                            fontFamily: 'NeueFrutigerWorld',
                            fontWeight: FontWeight.w400,
                            fontSize: 10
                        ),
                      ),),
                  )
                ],
              )
               : Container()
            ],
          ),
        ],
      ),
      wishlistStatus ? Positioned(
        right: 0,
        top: 10,
        child: InkWell(
          onTap: addToWish,
          child: Image.asset('assets/icon/heart.png',height: 20,width: 20),
        ),
      ) : Positioned(
        right: 0,
        top: 10,
        child: InkWell(
          onTap: addToWish,
          child: Image.asset('assets/icon/heart_outline.png',height: 20,width: 20),
        ),
      )
    ],
  );
}

Widget seeAllView(
    String imageUrl,
    String productName,
    int discount,
    String price,
    Function addToCart,
    bool stockOut,
    VoidCallback addToWish,
    VoidCallback increment,
    VoidCallback decrement,
    int count,
    bool wishlistStatus,
    bool productexistInCart,context) {
  return Stack(
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            child: imageUrl!=null && imageUrl.isNotEmpty
                ? Image.network(imageUrl,fit: BoxFit.cover,height: MediaQuery.of(context).size.height/5.5,)
                : Image.asset(App.defaultImage, fit: BoxFit.cover,height: MediaQuery.of(context).size.height/5.5),
          ),
          SizedBox(
            height: 5,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 160,
                child: Text(
                  productName,
                  style: new TextStyle(
                    color: ColorRes.charcoal,
                    fontFamily: 'NeueFrutigerWorld',
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                  maxLines: 2,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        discount == 0 ? '₹ $price' : "${int.parse(price)-discount}",
                        style: new TextStyle(
                          fontSize: 14,
                          color: ColorRes.red,
                          fontFamily: 'NeueFrutigerWorld',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      discount == 0 ? Container() : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '₹ $price',
                          style: TextStyle(
                            fontSize: 14,
                            color: ColorRes.red,
                            fontFamily: 'NeueFrutigerWorld',
                            fontWeight: FontWeight.w200,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 7,),
              !stockOut ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
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
                                size: MediaQuery.of(context).size.width/35,
                                color: ColorRes.whiteColor,
                              ),
                            ),
                            onTap: decrement),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            '$count',
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
                                size: MediaQuery.of(context).size.width/35,
                                color: ColorRes.whiteColor,
                              ),
                            ),
                            onTap: increment),
                      ],
                    ),
                  ),
                  productexistInCart ? Container() : InkWell(
                    onTap: () async {
                      addToCart.call();
                    },
                    child: Container(
                      decoration: BoxDecoration(color: ColorRes.redColor,borderRadius: BorderRadius.circular(8)),
                      padding: EdgeInsets.symmetric(horizontal:8,vertical: 5),
                      child: Text(
                        "Add to cart",
                        style: TextStyle(
                            color: ColorRes.whiteColor,
                            fontFamily: 'NeueFrutigerWorld',
                            fontWeight: FontWeight.w400,
                            fontSize: 10
                        ),
                      ),),
                  )
                ],
              )
                  : Container()
            ],
          ),
        ],
      ),
      wishlistStatus ? Positioned(
        right: 0,
        top: 10,
        child: InkWell(
          onTap: addToWish,
          child: Image.asset('assets/icon/heart.png',height: 20,width: 20),
        ),
      ) : Positioned(
        right: 0,
        top: 10,
        child: InkWell(
          onTap: addToWish,
          child: Image.asset('assets/icon/heart_outline.png',height: 20,width: 20),
        ),
      )
    ],
  );
}

Widget cartProductView(
  CartProduct cartItem,
  VoidCallback removeButton,
  VoidCallback increment,
  VoidCallback decrement,
    context
) {
  return Stack(
    alignment: Alignment.topRight,
    children: [
      Card(
        elevation: 3,
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              cartItem.pimage!=null && cartItem.pimage.isNotEmpty
                  ? Image.network(cartItem.pimage,fit: BoxFit.cover,height: 100,)
                  : Image.asset(App.defaultImage, fit: BoxFit.cover,height: 100),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cartItem.itemname,
                      style: new TextStyle(
                          color: ColorRes.charcoal,
                          fontFamily: 'NeueFrutigerWorld',
                          fontWeight: FontWeight.w400,
                          fontSize: 16),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Product Code: ${cartItem.itemid}',
                      style: new TextStyle(
                          color: ColorRes.gray57,
                          fontFamily: 'NeueFrutigerWorld',
                          fontWeight: FontWeight.w400,
                          fontSize: 11),
                    ),
                    Row(
                      children: [
                        Text(
                          cartItem.itemNewPrice == 0 ? '₹ ${cartItem.itemSubtotal}' : "${int.parse(cartItem.itemprice)-cartItem.itemNewPrice}",
                          style: new TextStyle(
                            fontSize: 16,
                            color: ColorRes.redColor,
                            fontFamily: 'NeueFrutigerWorld',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        cartItem.itemNewPrice == 0 ? Container() : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '₹ ${cartItem.itemSubtotal}',
                            style: TextStyle(
                              fontSize: 16,
                              color: ColorRes.charcoal,
                              fontFamily: 'NeueFrutigerWorld',
                              fontWeight: FontWeight.w200,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
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
                              onTap: decrement),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              '${cartItem.itemqty}',
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
                              onTap: increment),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      GestureDetector(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Icon(
            Icons.clear,
            size: 20,
            color: ColorRes.charcoal.withOpacity(0.5),
          ),
        ),
        onTap: removeButton,
      )
    ],
  );
}

Widget wishProductView(
  WishProduct cartItem,
  VoidCallback removeButton,
  VoidCallback addToCard,
  VoidCallback increment,
  VoidCallback decrement,
    context
) {
  return Stack(
    alignment: Alignment.topRight,
    children: [
      Card(
        elevation: 3,
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              cartItem.productImage!=null && cartItem.productImage.isNotEmpty
                  ? Image.network(cartItem.productImage,fit: BoxFit.cover,height: 100,)
                  : Image.asset(App.defaultImage, fit: BoxFit.cover,height: 100),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cartItem.productName,
                      style: new TextStyle(
                          color: ColorRes.charcoal,
                          fontFamily: 'NeueFrutigerWorld',
                          fontWeight: FontWeight.w400,
                          fontSize: 16),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Product Code: ${cartItem.itemdetId}',
                      style: new TextStyle(
                          color: ColorRes.gray57,
                          fontFamily: 'NeueFrutigerWorld',
                          fontWeight: FontWeight.w400,
                          fontSize: 11),
                    ),
                    Row(
                      children: [
                        Text(
                          cartItem.discountedPrice == 0 ? '₹ ${cartItem.price}' : "${int.parse(cartItem.price)-cartItem.discountedPrice}",
                          style: new TextStyle(
                            fontSize: 16,
                            color: ColorRes.redColor,
                            fontFamily: 'NeueFrutigerWorld',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        cartItem.discountedPrice == 0 ? Container() : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '₹ ${cartItem.price}',
                            style: TextStyle(
                              fontSize: 16,
                              color: ColorRes.charcoal,
                              fontFamily: 'NeueFrutigerWorld',
                              fontWeight: FontWeight.w200,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
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
                              onTap: decrement),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              '${cartItem.count}',
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
                              onTap: increment),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    InkWell(
                      onTap: addToCard,
                      child: Container(
                        color: ColorRes.redColor,
                        padding: EdgeInsets.all(5),
                        child: Text(
                          "Add to cart",
                          style: TextStyle(
                              color: ColorRes.whiteColor,
                              fontFamily: 'NeueFrutigerWorld',
                              fontWeight: FontWeight.w400,
                              fontSize: 12
                          ),
                        ),),
                    ),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      GestureDetector(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Icon(
            Icons.clear,
            size: 20,
            color: ColorRes.charcoal.withOpacity(0.5),
          ),
        ),
        onTap: removeButton,
      )
    ],
  );
}

Widget myOrdersDetailView(OrderItemsList myOrdersItem, MyOrdersDetailScreenState state) {
  return Stack(
    alignment: Alignment.topRight,
    children: [
      Container(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            myOrdersItem.pimage.isNotEmpty ? Image.network(
              myOrdersItem.pimage,
              fit: BoxFit.cover,
              height: 100,
            ) : Image.asset(
              App.defaultImage,
              fit: BoxFit.cover,
              width: 70,
              height: 70,
            ),
            SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  myOrdersItem.productName,
                  style: new TextStyle(
                      color: ColorRes.charcoal,
                      fontFamily: 'NeueFrutigerWorld',
                      fontWeight: FontWeight.w500,
                      fontSize: 14),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Text(
                      'Qty: ${myOrdersItem.qnty}',
                      style: new TextStyle(
                        fontSize: 14,
                        color: ColorRes.dimGray,
                        fontFamily: 'NeueFrutigerWorld',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      ' ₹${myOrdersItem.price}',
                      style: new TextStyle(
                        fontSize: 14,
                        color: ColorRes.redColor,
                        fontFamily: 'NeueFrutigerWorld',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                // Row(
                //   children: array,
                //   mainAxisAlignment: MainAxisAlignment.center,
                // )
              ],
            ),
          ],
        ),
      ),
    ],
  );
}

Widget myOrdersView(MyOrderData myOrdersItem) {

  return Card(
    elevation: 3,
    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Row(
        children: [
          Image.asset(
            App.defaultImage,
            fit: BoxFit.cover,
            width: 120,
            height: 70,
          ),
          SizedBox(width: 10,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Order no: ' + myOrdersItem.orderNo,
                style: new TextStyle(
                    color: ColorRes.gray57,
                    fontFamily: 'NeueFrutigerWorld',
                    fontWeight: FontWeight.w400,
                    fontSize: 16),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                myOrdersItem.orderStatus,
                style: new TextStyle(
                    color: ColorRes.charcoal,
                    fontFamily: 'NeueFrutigerWorld',
                    fontWeight: FontWeight.w400,
                    fontSize: 16),
              ),
              SizedBox(
                height: 5,
              ),

              Text(
                '${myOrdersItem.orderDate} - ${myOrdersItem.orderTime}',
                style: new TextStyle(
                  fontSize: 16,
                  color: ColorRes.redColor,
                  fontFamily: 'NeueFrutigerWorld',
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                '₹ ${myOrdersItem.orderTotal}',
                style: new TextStyle(
                  fontSize: 16,
                  color: ColorRes.redColor,
                  fontFamily: 'NeueFrutigerWorld',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget commonAppbar(context,{bool isBack = false}) {
  return AppBar(
    leading: backButton(context,isBack: isBack),
    elevation: 0,
    backgroundColor: ColorRes.primaryColor,
    actions: [
      GestureDetector(
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
  );
}

Widget commonTitle(title) {
  return Text(
    title,
    style: new TextStyle(
      fontSize: 30,
      color: ColorRes.charcoal,
      fontFamily: 'NeueFrutigerWorld',
    ),
  );
}

BuildContext c;

showLoader(context, {String label}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      c = context;
      return LoaderPage(label: label);
    },
  );
}

hideLoader() {
  Navigator.pop(c);
}
