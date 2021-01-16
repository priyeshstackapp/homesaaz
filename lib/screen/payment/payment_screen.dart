import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:homesaaz/common/colorres.dart';
import 'package:homesaaz/common/common_route.dart';
import 'package:homesaaz/common/common_widget.dart';
import 'package:homesaaz/model/address_model.dart';
import 'package:homesaaz/screen/payment/payment_screen_view_model.dart';
import '../../app.dart';

class PaymentScreen extends StatefulWidget {
  final AddressData addressData;

  PaymentScreen({Key key, @required this.addressData}) : super(key: key);

  @override
  PaymentScreenState createState() => PaymentScreenState();
}

class PaymentScreenState extends State<PaymentScreen> {
  PaymentScreenViewModel model;

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    double width = media.width;
    double height = media.height;
    print("Current page --> $runtimeType");
    model ?? (model = PaymentScreenViewModel(this));
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
        backgroundColor: ColorRes.primaryColor,
        appBar: commonAppbar(context),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Title
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  commonTitle('Payment'),
                ],
              ),
            ),
            SizedBox(height: 18),

            //Card
            card(),
            SizedBox(height: height * 0.05),

            //payment card Details
            paymentCard(),

            Padding(
              padding: const EdgeInsets.only(
                  top: 5, bottom: 10, left: 20, right: 20),
              child: Divider(height: 1, color: ColorRes.gray57),
            ),
            //Total Payment
            totalPayment(),
            Spacer(),

            //Add Cart and Checkout
            addCartAndCheckOut(),
            SizedBox(height: 5),
          ],
        ),
      ),
    );
  }

  //Payment card
  card() {
    Size media = MediaQuery.of(context).size;
    double height = media.height;
    return Container(
      color: ColorRes.primaryColor,
      height: height * 0.25,
      child: ListView.builder(
          itemCount: model.paymentImage.length,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(left: 20, right: 10),
              child: Image.asset(model.paymentImage[index]),
            );
          }),
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

  //Bottom Add card and checkout button
  addCartAndCheckOut() {
    Size media = MediaQuery.of(context).size;
    double width = media.width;
    double height = media.height;
    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: Column(
        children: [
          InkWell(
            onTap: () async {
              gotoAddCardScreen(context);
            },
            child: DottedBorder(
              color: ColorRes.red,
              dashPattern: [4, 4],
              strokeWidth: 1,
              child: Container(
                alignment: Alignment.center,
                height: height * 0.055,
                width: width * 0.9,
                decoration: BoxDecoration(
                  color: ColorRes.whiteColor,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Text(
                  '+ Add Card',
                  style: new TextStyle(
                    fontSize: 20,
                    color: ColorRes.textColor,
                    fontFamily: 'NeueFrutigerWorld',
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          InkWell(
            onTap: () {
              gotoCheckoutScreen(context, addressData: widget.addressData);
            },
            child: Container(
              alignment: Alignment.center,
              height: height * 0.07,
              width: width * 0.92,
              decoration: BoxDecoration(
                color: ColorRes.red,
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Text(
                'Checkout',
                style: new TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontFamily: 'NeueFrutigerWorld',
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
