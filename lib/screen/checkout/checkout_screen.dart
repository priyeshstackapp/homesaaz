import 'package:flutter/material.dart';
import 'package:homesaaz/common/colorres.dart';
import 'package:homesaaz/common/common_widget.dart';
import 'package:homesaaz/model/cart_model.dart';
import 'package:homesaaz/screen/cart/cart_view_model.dart';

import '../../app.dart';
import 'checkout_screen_view_model.dart';

class CheckoutScreen extends StatefulWidget {
  final int itemHolder ;

  CheckoutScreen({Key key, @required this.itemHolder}) : super(key: key);
  @override
  CheckoutScreenState createState() => CheckoutScreenState();
}

class CheckoutScreenState extends State<CheckoutScreen> {

  CheckoutScreenViewModel model;

  @override
  Widget build(BuildContext context) {
    print("Current page --> $runtimeType");
    model ?? (model = CheckoutScreenViewModel(this));

    Size media = MediaQuery.of(context).size;
    double width = media.width;
    double height = media.height;

    return Scaffold(
      backgroundColor: ColorRes.primaryColor,
      appBar: commonAppbar(context),
      body: Stack(
          alignment: Alignment.bottomCenter,
          children : [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    "Checkout",
                    style: new TextStyle(
                      fontSize: 30,
                      color: ColorRes.charcoal,
                      fontFamily: 'NeueFrutigerWorld',
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  height: height*0.69,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemCount: model.newProductName.length,
                          itemBuilder: (context, index) {
                            CartModel cartItem = model.newProductName[index];
                            return checkoutProductView(cartItem,this,model.newProductName);
                          },),

                        Text( widget.itemHolder.toString(),
                          style: TextStyle(fontSize: 22),
                          textAlign: TextAlign.center,),
                        //payment card Details
                        paymentCard(),

                        Padding(
                          padding: const EdgeInsets.only(
                              top: 5, bottom: 10, left: 20, right: 20),
                          child: Divider(height: 1, color: ColorRes.gray57),
                        ),
                        //Total Payment
                        totalPayment(),
                      ],
                    ),
                  ),
                )

              ],
            ),
            InkWell(
              onTap: () {

              },
              child: Container(
                alignment: Alignment.center,
                height: height * 0.07,
                width: width * 0.92,
                margin: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  color: ColorRes.red,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Text(
                  'Continue',
                  style: new TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontFamily: 'NeueFrutigerWorld',
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ]
      ),
    );
  }
  //payment card show the text
  paymentCard() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        cardTextShow(App.subtotal, "₹160.00"),
        cardTextShow(App.discount, "5%"),
        cardTextShow(App.shipping, "₹10.00"),
      ],
    );
  }

  //card text show are use in design in payment card
  cardTextShow(String leftText, String rightText) {
    return Container(
      padding: EdgeInsets.only(bottom: 10, top: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(left: 20),
            child: Text(
              leftText,
              style: new TextStyle(
                  fontSize: 17,
                  color: ColorRes.gray57,
                  fontFamily: 'NeueFrutigerWorld',
                  fontWeight: FontWeight.w400),
            ),
          ),
          Container(
            alignment: Alignment.topRight,
            padding: EdgeInsets.only(right: 20),
            child: Text(
              rightText,
              style: new TextStyle(
                  fontSize: 17,
                  color: ColorRes.charcoal,
                  fontFamily: 'NeueFrutigerWorld',
                  fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
    );
  }

  //Total Payment
  totalPayment() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.only(left: 20),
          child: Text(
            App.total,
            style: new TextStyle(
                fontSize: 17,
                color: ColorRes.charcoal,
                fontFamily: 'NeueFrutigerWorld',
                fontWeight: FontWeight.w400),
          ),
        ),
        Container(
          alignment: Alignment.topRight,
          padding: EdgeInsets.only(right: 20),
          child: Text(
            '₹162.00',
            style: new TextStyle(
                fontSize: 17,
                color: ColorRes.charcoal,
                fontFamily: 'NeueFrutigerWorld',
                fontWeight: FontWeight.w400),
          ),
        ),
      ],
    );
  }
}
