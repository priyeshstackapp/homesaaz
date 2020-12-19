import 'dart:convert';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:homesaaz/app.dart';
import 'package:homesaaz/common/colorres.dart';
import 'package:homesaaz/common/common_route.dart';
import 'package:homesaaz/common/common_widget.dart';
import 'package:homesaaz/screen/checkout/checkout_screen.dart';
import 'package:homesaaz/screen/create_address/create_address_screen.dart';
import 'package:homesaaz/screen/payment/payment_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'address_screen_view_model.dart';

class AddressScreen extends StatefulWidget {
  String address = "";
  String city = "";
  String postalCode = "";
  String houseNo = "";
  String roadNo = "";

  AddressScreen(
      {this.address, this.city, this.postalCode, this.houseNo, this.roadNo});

  @override
  AddressScreenState createState() => AddressScreenState();
}

class AddressScreenState extends State<AddressScreen> {
  AddressScreenViewModel model;
  int isSelectedIndex = 0;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String address;
  String city;
  String postalCode;
  String houseNo;
  String roadNo;

  List<Map> listOfAddress = List();

  @override
  void initState() {
    super.initState();
    getData();
  }

  List data = List();
  SharedPreferences prefs;

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      address = prefs.getString('key');
      city = prefs.getString('key');
      postalCode = prefs.getString('key');
      houseNo = prefs.getString('key');
      roadNo = prefs.getString('key');
      data = jsonDecode(address);
      data = jsonDecode(city);
      data = jsonDecode(postalCode);
      data = jsonDecode(houseNo);
      data = jsonDecode(roadNo);
    });
    print(data);
  }

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    double width = media.width;
    double height = media.height;
    print("Current page --> $runtimeType");
    model ?? (model = AddressScreenViewModel(this));
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
        key: _formKey,
        backgroundColor: ColorRes.primaryColor,
        appBar: commonAppbar(context),
        body: SafeArea(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 19),
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        commonTitle('Address'),
                        SizedBox(height: 20),
                        Container(
                          height: height * 0.57,
                          child: ListView.builder(
                            itemCount: listOfAddress.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                  onTap: () {}, child: addressData(index));
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              addAddressAndContinueButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget addressData(int index) {
    return InkResponse(
      onTap: () {
        isSelectedIndex = index;
        setState(() {});
      },
      child: Container(
        padding: EdgeInsets.only(right: 20, bottom: 20),
        color: ColorRes.whiteColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  listOfAddress[index] == null
                      ? Container()
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              //'Shewrapara, Mirpur, Delhi-1216  ' +
                              listOfAddress[index]['address'] + ', ',
                              // data[index]['city'],
                              style: new TextStyle(
                                fontSize: 18,
                                color: ColorRes.charcoal,
                                fontFamily: 'NeueFrutigerWorld',
                              ),
                              maxLines: 5,
                            ),
                            Text(
                              listOfAddress[index]['city'] +
                                  '-' +
                                  listOfAddress[index]['postalCode'],
                              // data[index]['city'],
                              style: new TextStyle(
                                fontSize: 18,
                                color: ColorRes.charcoal,
                                fontFamily: 'NeueFrutigerWorld',
                              ),
                              maxLines: 5,
                            ),
                          ],
                        )
                  /* listOfAddress[index] == null
                      ? Container()
                      : Text(
                          'House no: ' + listOfAddress[index]['houseNo'],
                          //'House no: 938',
                          style: new TextStyle(
                            fontSize: 18,
                            color: ColorRes.charcoal,
                            fontFamily: 'NeueFrutigerWorld',
                          ),
                        ),
                  listOfAddress[index] == null
                      ? Container()
                      : Text(
                          'Road no: ' + listOfAddress[index]['roadNo'],
                          //'Road no: 9',
                          style: new TextStyle(
                            fontSize: 18,
                            color: ColorRes.charcoal,
                            fontFamily: 'NeueFrutigerWorld',
                          ),
                        ),*/
                ],
              ),
            ),
            listOfAddress[index] == null
                ? Container()
                : Flexible(
                    flex: 2,
                    child: isSelectedIndex == index
                        ? Icon(
                            Icons.radio_button_on_outlined,
                            color: ColorRes.redColor,
                            size: 20,
                          )
                        : Icon(Icons.radio_button_off,
                            color: ColorRes.dimGray, size: 20),
                  )
          ],
        ),
      ),
    );
  }

  //Bottom Add Address and continue payment button
  Widget addAddressAndContinueButton() {
    Size media = MediaQuery.of(context).size;
    double width = media.width;
    double height = media.height;
    return Container(
      height: height * 0.18,
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.end,
        //crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          InkWell(
            onTap: () async {
              Map setData = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreateAddressScreen()),
              );
              print(setData);
              listOfAddress.add(setData);
              print(listOfAddress);
              setState(() {});
            },
            child: DottedBorder(
              color: ColorRes.red,
              dashPattern: [4, 4],
              strokeWidth: 1,
              child: Container(
                alignment: Alignment.center,
                height: height * 0.07,
                width: width * 0.9,
                decoration: BoxDecoration(
                  color: ColorRes.whiteColor,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Text(
                  '+ Add Address',
                  style: new TextStyle(
                      fontSize: 20,
                      color: ColorRes.textColor,
                      fontFamily: 'NeueFrutigerWorld',
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          InkWell(
            onTap: () {
              //print(listOfAddress[isSelectedIndex]);
              listOfAddress.length == 0
                  ? showToast()
                  : gotoPaymentScreen(context,
                      mapAddress: listOfAddress[isSelectedIndex]);
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
                'Continue To Payment',
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

  showToast() {
    return Fluttertoast.showToast(
        msg: "Please any select address",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: ColorRes.whiteColor,
        textColor: ColorRes.textColor,
        fontSize: 16.0);
  }
}
