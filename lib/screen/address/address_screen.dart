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
import 'package:homesaaz/model/cart_model.dart';
import 'package:homesaaz/screen/create_address/create_address_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'address_screen_view_model.dart';

class AddressScreen extends StatefulWidget {
  CartModel cartModel;
  AddressScreen(this.cartModel);
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

  @override
  Widget build(BuildContext context) {
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
                padding: const EdgeInsets.only(left: 19,bottom: 120),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    commonTitle('Address'),
                    SizedBox(height: 20),

                    //Show List of Address
                    model.addressModel != null ? Expanded(
                      child: ListView.builder(
                        itemCount: model.addressModel.data.length == null ? null :model.addressModel.data.length,
                        // physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return addressData(index);
                        },
                      ),
                    ) : Container(),
                  ],
                ),
              ),
              widget.cartModel!=null ? addAddressAndContinueButton() : Container(),
            ],
          ),
        ),
      ),
    );
  }

  //List of Address
  Widget addressData(int index) {
    return InkWell(
      onTap: () {
        isSelectedIndex = index;
        setState(() {});
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical:5),
        child: Card(
          child: Container(
            padding: EdgeInsets.only(right: 10,left: 10, bottom: 10),
            color: ColorRes.whiteColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                isSelectedIndex == index
                    ? Icon(
                  Icons.radio_button_on_outlined,
                  color: ColorRes.redColor,
                  size: 20,
                )
                    : Icon(Icons.radio_button_off,
                    color: ColorRes.dimGray, size: 20),
                SizedBox(width: 20,),
                Expanded(
                  flex: 9,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            model.addressModel.data[index].addressTitle +',',
                            style: new TextStyle(
                              fontSize: 18,
                              color: ColorRes.charcoal,
                              fontFamily: 'NeueFrutigerWorld',
                            ),
                            maxLines: 10,
                          ),
                          Text(
                            model.addressModel.data[index].address,
                            style: new TextStyle(
                              fontSize: 18,
                              color: ColorRes.charcoal,
                              fontFamily: 'NeueFrutigerWorld',
                            ),
                            maxLines: 10,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                model.addressModel.data[index] == null ? Container() : Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () async {
                        var res = await gotoCreateAddressScreen(context, true, model.addressModel.data[index]);
                        if(res!=null){
                          model.addressListApi();
                        }
                      },
                      child: Image.asset(App.editIcon, color: ColorRes.redColor,height: 20,),
                    ),
                    SizedBox(height: 15,),
                    InkWell(
                      onTap: (){
                        showDialog(
                          context: context,
                          builder: (context) => new AlertDialog(
                            title: new Text('Confirmation'),
                            content: new Text('Do you want to delete this address?'),
                            actions: <Widget>[
                              new FlatButton(
                                onPressed: () => Navigator.of(context).pop(false),
                                child: new Text('No'),
                              ),
                              new FlatButton(
                                onPressed: () async {
                                  Navigator.pop(context);
                                  await model.deleteAddressApiCall(model.addressModel.data[index].addressId);
                                },
                                child: new Text('Yes'),
                              ),
                            ],
                          ),
                        );
                      },
                      child: Image.asset(App.deleteIcon,color: ColorRes.redColor,height: 20,),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //Bottom Add Address and continue payment button
  Widget addAddressAndContinueButton() {
    return Container(
      height: 120,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          InkWell(
            onTap: () async {
             var res = await gotoCreateAddressScreen(context, false, null);
             if(res!=null){
               model.addressListApi();
             }
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: DottedBorder(
                color: ColorRes.red,
                dashPattern: [4, 4],
                strokeWidth: 1,
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
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
          ),
          SizedBox(height: 10),
          InkWell(
            onTap: () {
              gotoCheckoutScreen(context, model.addressModel.data[isSelectedIndex],widget.cartModel);
            },
            child: Container(
              alignment: Alignment.center,
              height: 50,
              margin: EdgeInsets.symmetric(horizontal: 10),
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
        backgroundColor: ColorRes.redColor,
        textColor: ColorRes.whiteColor,
        fontSize: 16.0);
  }
}
