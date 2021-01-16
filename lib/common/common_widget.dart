import 'package:flutter/material.dart';
import 'package:homesaaz/app.dart';
import 'package:homesaaz/common/colorres.dart';
import 'package:homesaaz/common/common_route.dart';
import 'package:homesaaz/common/loder_show.dart';
import 'package:homesaaz/model/cart_model.dart';
import 'package:homesaaz/model/my_order_model.dart';
import 'package:homesaaz/model/order_details_model.dart';
import 'package:homesaaz/screen/cart/cart_screen.dart';
import 'package:homesaaz/screen/checkout/checkout_screen.dart';
import 'package:homesaaz/screen/my_orders/my_orders_screen.dart';
import 'package:homesaaz/screen/my_orders_details/my_orders_detail_screen.dart';
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

Widget backButton(context) {
  return InkWell(
    onTap: () {
      Navigator.pop(context);
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
    String imageUrl, String productName, String oldPrice, String newPrice) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      imageUrl.isNotEmpty
          ? Image.network(imageUrl)
          : Image.asset(App.product_name_first, fit: BoxFit.cover),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                '$newPrice',
                style: new TextStyle(
                  fontSize: 16,
                  color: ColorRes.charcoal,
                  fontFamily: 'NeueFrutigerWorld',
                  fontWeight: FontWeight.w400,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '$oldPrice',
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
          Text(
            productName,
            style: new TextStyle(
              color: ColorRes.charcoal,
              fontFamily: 'NeueFrutigerWorld',
              fontWeight: FontWeight.w400,
            ),
            maxLines: 2,
          ),
        ],
      ),
    ],
  );
}

Widget cartProductView(Product cartItem,VoidCallback removeButton,VoidCallback increment,VoidCallback decrement,) {
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
              Image.network(
                cartItem.pimage,
                fit: BoxFit.cover,
                height: 100,
              ),
              SizedBox(
                width: 20,
              ),
              Column(
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
                        '${cartItem.itemprice}',
                        style: new TextStyle(
                          fontSize: 16,
                          color: ColorRes.redColor,
                          fontFamily: 'NeueFrutigerWorld',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '${cartItem.itemSubtotal}',
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
                  Container(
                    color: ColorRes.creamColor,
                    child: Row(
                      children: [
                        GestureDetector(
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Icon(
                                Icons.remove,
                                size: 20,
                                color: ColorRes.charcoal,
                              ),
                            ),
                            onTap: decrement),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            '${cartItem.itemqty}',
                            style: TextStyle(
                              fontSize: 16,
                              color: ColorRes.charcoal,
                              fontFamily: 'NeueFrutigerWorld',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        GestureDetector(
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Icon(
                                Icons.add,
                                size: 20,
                                color: ColorRes.charcoal,
                              ),
                            ),
                            onTap: increment),
                      ],
                    ),
                  ),
                ],
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
  // List<Widget> array = [];
  // var filled = ColorRes.darkYellow;
  // var empty = Colors.grey;
  // for (var i = 1; i <= 5; i++) {
  //   array.add(Icon(
  //     Icons.star,
  //     color: (myOrdersItem.rating < i ? empty : filled),
  //   ));
  // }

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
              myOrdersItem.pimage.isNotEmpty ? Image.network(
                myOrdersItem.pimage,
                fit: BoxFit.cover,
                height: 100,
              ) : Container(),
              SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    myOrdersItem.productName,
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
                    '${myOrdersItem.price}',
                    style: new TextStyle(
                      fontSize: 16,
                      color: ColorRes.redColor,
                      fontFamily: 'NeueFrutigerWorld',
                      fontWeight: FontWeight.w400,
                    ),
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
      child: Column(
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
            '\$${myOrdersItem.orderTotal}',
            style: new TextStyle(
              fontSize: 16,
              color: ColorRes.redColor,
              fontFamily: 'NeueFrutigerWorld',
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget commonAppbar(context) {
  return AppBar(
    leading: backButton(context),
    elevation: 0,
    backgroundColor: ColorRes.primaryColor,
    actions: [
      GestureDetector(
        onTap: () {
          replaceWithProfileScreen(context);
        },
        child: Image.asset(
          App.user,
          color: ColorRes.darkRedColor58,
          height: 16,
          width: 16,
        ),
      ),
      GestureDetector(
        onTap: () {
          replaceWithCartScreen(context);
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
