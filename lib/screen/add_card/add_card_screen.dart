import 'package:credit_card_slider/card_background.dart';
import 'package:credit_card_slider/card_network_type.dart';
import 'package:credit_card_slider/credit_card_widget.dart';
import 'package:credit_card_slider/validity.dart';
import 'package:flutter/material.dart';
import 'package:homesaaz/common/colorres.dart';
import 'package:homesaaz/common/common_widget.dart';

class AddCardScreen extends StatefulWidget {
  @override
  _AddCardScreenState createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  TextEditingController cardName = TextEditingController(text: "");
  TextEditingController cardNumber = TextEditingController(text: "");
  TextEditingController expiryMonth = TextEditingController(text: "");
  TextEditingController expiryYear = TextEditingController(text: "");

  FocusNode monthFocusNode = new FocusNode();
  FocusNode numberFocusNode = new FocusNode();
  FocusNode yearFocusNode = new FocusNode();

  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  String name = "";
  String number = "";
  int month = 00;
  int year = 00;

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    double width = media.width;
    double height = media.height;

    return Scaffold(
      appBar: commonAppbar(context),
      key: scaffoldKey,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CreditCard(
              cardBackground: GradientCardBackground(LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0xFF4AA3F2), Color(0xFFAF92FB)],
                stops: [0.3, 0.95],
              )),
              cardNumber: number,
              cardNetworkType: getCardTypeFrmNumber(number) == CardType.Master
                  ? CardNetworkType.mastercard
                  : CardNetworkType.visaBasic,
              cardHolderName: name,
              validity: Validity(validThruMonth: month, validThruYear: year),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              child: TextFormField(
                style: TextStyle(fontSize: 16, color: ColorRes.dimGray),
                cursorColor: ColorRes.dimGray,
                controller: cardName,
                onFieldSubmitted: (String value) {
                  FocusScope.of(context).requestFocus(numberFocusNode);
                },
                decoration: InputDecoration(
                  hintText: "Cardholder Name",
                  hintStyle: TextStyle(color: ColorRes.dimGray, fontSize: 16),
                  focusColor: ColorRes.dimGray,
                  focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: ColorRes.dimGray.withOpacity(0.5))),
                  enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: ColorRes.dimGray.withOpacity(0.3))),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              child: TextFormField(
                style: TextStyle(fontSize: 16, color: ColorRes.dimGray),
                cursorColor: ColorRes.dimGray,
                controller: cardNumber,
                focusNode: numberFocusNode,
                onChanged: (String value) {
                  if (value.length == 16)
                    FocusScope.of(context).requestFocus(monthFocusNode);
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Card Number",
                  hintStyle: TextStyle(color: ColorRes.dimGray, fontSize: 16),
                  focusColor: ColorRes.dimGray,
                  focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: ColorRes.dimGray.withOpacity(0.5))),
                  enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: ColorRes.dimGray.withOpacity(0.3))),
                ),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 10, bottom: 10, left: 30, right: 7),
                  child: Container(
                    width: 30,
                    child: TextFormField(
                      maxLength: 2,
                      style: TextStyle(fontSize: 16, color: ColorRes.dimGray),
                      cursorColor: ColorRes.dimGray,
                      controller: expiryMonth,
                      focusNode: monthFocusNode,
                      onChanged: (String value) {
                        if (value.length == 2)
                          FocusScope.of(context).requestFocus(yearFocusNode);
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: "11",
                        counterText: "",
                        hintStyle:
                            TextStyle(color: ColorRes.dimGray, fontSize: 16),
                        focusColor: ColorRes.dimGray,
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: ColorRes.dimGray.withOpacity(0.5))),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: ColorRes.dimGray.withOpacity(0.3))),
                      ),
                    ),
                  ),
                ),
                Text(
                  "/",
                  style: TextStyle(color: ColorRes.dimGray, fontSize: 16),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 7),
                  child: Container(
                    width: 30,
                    child: TextFormField(
                      maxLength: 2,
                      style: TextStyle(fontSize: 16, color: ColorRes.dimGray),
                      cursorColor: ColorRes.dimGray,
                      controller: expiryYear,
                      focusNode: yearFocusNode,
                      onFieldSubmitted: (_) => FocusScope.of(context).unfocus(),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: "24",
                        counterText: "",
                        hintStyle:
                            TextStyle(color: ColorRes.dimGray, fontSize: 16),
                        focusColor: ColorRes.dimGray,
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: ColorRes.dimGray.withOpacity(0.5))),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: ColorRes.dimGray.withOpacity(0.3))),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            InkWell(
              onTap: () {
                if (validation()) {
                  setState(() {
                    name = cardName.text.trim();
                    month = int.parse(expiryMonth.text.trim());
                    year = int.parse(expiryYear.text.trim());
                  });
                }
              },
              child: Container(
                alignment: Alignment.center,
                height: height * 0.07,
                width: width * 0.5,
                margin: EdgeInsets.only(bottom: 30),
                decoration: BoxDecoration(
                  color: ColorRes.red,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Text(
                  'Generate',
                  style: new TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontFamily: 'NeueFrutigerWorld',
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static CardType getCardTypeFrmNumber(String input) {
    CardType cardType;
    if (input.startsWith(new RegExp(
        r'((5[1-5])|(222[1-9]|22[3-9][0-9]|2[3-6][0-9]{2}|27[01][0-9]|2720))'))) {
      cardType = CardType.Master;
    } else if (input.startsWith(new RegExp(r'[4]'))) {
      cardType = CardType.Visa;
    } else if (input
        .startsWith(new RegExp(r'((506(0|1))|(507(8|9))|(6500))'))) {
      cardType = CardType.Verve;
    } else if (input.length <= 8) {
      cardType = CardType.Others;
    } else {
      cardType = CardType.Invalid;
    }
    return cardType;
  }

  bool validation() {
    if (cardName.text == '') {
      showSnackBar(scaffoldKey, 'Enter Cardholder name', isError: true);
      return false;
    } else if (cardNumber.text == '') {
      showSnackBar(scaffoldKey, 'Enter card number', isError: true);
      return false;
    } else if (cardNumber.text.trim().length < 16 ||
        cardNumber.text.trim().length > 16) {
      showSnackBar(scaffoldKey, 'Enter valid 16 digit card number',
          isError: true);
      return false;
    } else if (expiryMonth.text == '') {
      showSnackBar(scaffoldKey, 'Enter expiry month', isError: true);
      return false;

    }else if (int.parse(expiryMonth.text.trim()) > 12 || int.parse(expiryMonth.text.trim()) < 1) {
      showSnackBar(scaffoldKey,'Enter valid month',isError: true);

    } else if (int.parse(expiryMonth.text.trim()) > 12 ||
        int.parse(expiryMonth.text.trim()) < 1) {
      showSnackBar(scaffoldKey, 'Enter expiry month', isError: true);

      return false;
    } else if (expiryYear.text == '') {
      showSnackBar(scaffoldKey, 'Enter expiry year', isError: true);
      return false;

    }else if (int.parse("20"+ expiryYear.text.trim()) <= DateTime.now().year) {
      if(int.parse("20"+ expiryYear.text.trim()) == DateTime.now().year){
        if(int.parse(expiryMonth.text.trim()) == DateTime.now().month){
          showSnackBar(scaffoldKey,'Current month card is not valid for transaction, Please add another card',isError: true);
          return false;
        }else if(int.parse(expiryMonth.text.trim()) < DateTime.now().month){
          showSnackBar(scaffoldKey,'Your card is expired, Please add another card',isError: true);
          return false;
        }else{
          return true;
        }
      }
      showSnackBar(scaffoldKey,'Your card is expired, Please add another card',isError: true);

    } else if (int.parse("20" + expiryYear.text.trim()) <=
        DateTime.now().year) {
      showSnackBar(scaffoldKey, 'Enter expiry year', isError: true);
      return false;
    } else if (int.parse(expiryYear.text.trim()) > 99 ||
        int.parse(expiryYear.text.trim()) < 1) {
      showSnackBar(scaffoldKey, 'Enter expiry year', isError: true);

      return false;
    }
    return true;
  }
}

enum CardType {
  Master,
  Visa,
  Verve,
  Others, // Any other card issuer
  Invalid // We'll use this when the card is invalid
}
