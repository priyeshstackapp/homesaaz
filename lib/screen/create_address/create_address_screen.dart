import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:homesaaz/app.dart';
import 'package:homesaaz/common/colorres.dart';
import 'package:homesaaz/common/common_widget.dart';
import 'package:homesaaz/model/dabasehelper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'create_address_screen_view_model.dart';

class CreateAddressScreen extends StatefulWidget {
   String address;
   String city;
   String postalCode;
   String houseNo;
   String roadNo;

   CreateAddressScreen(
      {Key key,
      this.address,
      this.city,
      this.postalCode,
      this.houseNo,
      this.roadNo})
      : super(key: key);

  @override
  CreateAddressScreenState createState() => CreateAddressScreenState();
}

class CreateAddressScreenState extends State<CreateAddressScreen> {
  CreateAddressScreenViewModel model;
  SharedPreferences prefs;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _address = new TextEditingController();
  final TextEditingController _city = new TextEditingController();
  final TextEditingController _postalCode = new TextEditingController();
  final TextEditingController _houseNo = new TextEditingController();
  final TextEditingController _roadNo = new TextEditingController();
  String address;
  String city;
  String postalCode;
  String houseNo;
  String roadNo;

  @override
  void initState() {
    super.initState();
    shared();
    setState(() {});
  }

  shared() async {
    prefs = await SharedPreferences.getInstance();
  }

  List<DatabaseHelper> dataList = List();

  Future<void> _sendData(BuildContext context) async {
    String textToAddress = address.toString();
    String textToCity = city.toString();
    String textToPostalCode = postalCode.toString();
    String textToHouseNo = houseNo.toString();
    String textToRoadNo = roadNo.toString();

    DatabaseHelper databaseHelper = DatabaseHelper();
    databaseHelper.address = textToAddress;
    databaseHelper.city = textToCity;
    databaseHelper.postalCode = textToPostalCode;
    databaseHelper.houseNo = textToHouseNo;
    databaseHelper.roadNo = textToRoadNo;

    dataList.add(databaseHelper);
    await prefs.setString('key', jsonEncode(dataList));
  }

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    double width = media.width;
    double height = media.height;
    print("Current page --> $runtimeType");
    model ?? (model = CreateAddressScreenViewModel(this));
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: ColorRes.primaryColor,
        appBar: commonAppbar(context),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Text(
                    "Create Address",
                    style: new TextStyle(
                      fontSize: 30,
                      color: ColorRes.charcoal,
                      fontFamily: 'NeueFrutigerWorld',
                    ),
                  ),
                  SizedBox(height: 30),
                  Container(
                    height: height * 0.68,
                    child: addressDetails(),
                  ),
                  SizedBox(height: height * 0.01),
                  InkWell(
                    onTap: () {
                      if (_validateInputs()) {
                        Navigator.pop(context, {
                          "address": _address.text,
                          "city": _city.text,
                          "postalCode": _postalCode.text,
                          /*"houseNo": _houseNo.text,
                          "roadNo": _roadNo.text,*/
                        });
                      }
                      _sendData(context);
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
                        'Add Address',
                        style: new TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontFamily: 'NeueFrutigerWorld',
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  addressDetails() {
    Size media = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //name
          Text(
            'Name',
            style: TextStyle(
              fontFamily: 'NeueFrutigerWorld',
              fontSize: 16,
              color: ColorRes.dimGray,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: media.width * 0.06),
            child: TextFormField(
              //readOnly: true,
              validator: validateName,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade100),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade100),
                ),
                filled: true,
                fillColor: const Color(0xFFFFFFFF),
                hintText: 'Rakesh Patwal',
                hintStyle: TextStyle(
                  fontFamily: 'NeueFrutigerWorld',
                  fontSize: 16,
                  color: ColorRes.charcoal,
                ),
                contentPadding: EdgeInsets.only(left: 0.0, bottom: 10),
              ),
            ),
          ),
          SizedBox(height: 20),

          //Address lane
          Text(
            'Address lane',
            style: TextStyle(
              fontFamily: 'NeueFrutigerWorld',
              fontSize: 16,
              color: ColorRes.dimGray,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: media.width * 0.06),
            child: TextFormField(
              //  readOnly: true,
              controller: _address,
              validator: validateAddress,

              onSaved: (String val) {
                address = val;
              },
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade100),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade100),
                ),
                filled: true,
                fillColor: const Color(0xFFFFFFFF),
                hintText: 'Shewrapara 958',
                hintStyle: TextStyle(
                  fontFamily: 'NeueFrutigerWorld',
                  fontSize: 16,
                  color: ColorRes.charcoal,
                ),
                contentPadding: EdgeInsets.only(left: 0.0, bottom: 10),
              ),
            ),
          ),
          SizedBox(height: 20),

          //City
          Text(
            'City',
            style: TextStyle(
              fontFamily: 'NeueFrutigerWorld',
              fontSize: 16,
              color: ColorRes.dimGray,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: media.width * 0.06),
            child: TextFormField(
              //readOnly: true,
              controller: _city,
              validator: validateCity,

              onSaved: (String val) {
                city = val;
              },
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade100),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade100),
                ),
                //filled: true,
                fillColor: const Color(0xFFFFFFFF),
                hintText: 'Delhi',
                hintStyle: TextStyle(
                  fontFamily: 'NeueFrutigerWorld',
                  fontSize: 16,
                  color: ColorRes.charcoal,
                ),
                contentPadding: EdgeInsets.only(left: 0.0, bottom: 10),
              ),
            ),
          ),
          SizedBox(height: 20),

          //Postal Code
          Text(
            'Postal Code',
            style: TextStyle(
              fontFamily: 'NeueFrutigerWorld',
              fontSize: 16,
              color: ColorRes.dimGray,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: media.width * 0.06),
            child: TextFormField(

              //readOnly: true,
              controller: _postalCode,
              validator: validatePostalCode,
              keyboardType: TextInputType.number,
              onSaved: (String val) {
                postalCode = val;
              },
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade100),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade100),
                ),
                filled: true,
                fillColor: const Color(0xFFFFFFFF),
                hintText: '110065',
                hintStyle: TextStyle(
                  fontFamily: 'NeueFrutigerWorld',
                  fontSize: 16,
                  color: ColorRes.charcoal,
                ),
                contentPadding: EdgeInsets.only(left: 0.0, bottom: 10),
              ),
              onTap: (){

              },

            ),
          ),
          SizedBox(height: 20),

          //Phone Number
          Text(
            'Phone Number',
            style: TextStyle(
              fontFamily: 'NeueFrutigerWorld',
              fontSize: 16,
              color: ColorRes.dimGray,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: media.width * 0.06),
            child: TextFormField(
              //readOnly: true,
              validator: validateMobileNo,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade100),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade100),
                ),
                filled: true,
                fillColor: const Color(0xFFFFFFFF),
                hintText: '+91 9958 314 088',
                hintStyle: TextStyle(
                  fontFamily: 'NeueFrutigerWorld',
                  fontSize: 16,
                  color: ColorRes.charcoal,
                ),
                contentPadding: EdgeInsets.only(left: 0.0, bottom: 10),
              ),
            ),
          ),
          SizedBox(height: 20),

         /* //House No
          Text(
            'House No',
            style: TextStyle(
              fontFamily: 'NeueFrutigerWorld',
              fontSize: 16,
              color: ColorRes.dimGray,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: media.width * 0.06),
            child: TextFormField(
              //readOnly: true,
              controller: _houseNo,
              validator: validateHouseNo,
              keyboardType: TextInputType.number,

              onSaved: (String val) {
                houseNo = val;
              },
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade100),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade100),
                ),
                filled: true,
                fillColor: const Color(0xFFFFFFFF),
                hintText: '938',
                hintStyle: TextStyle(
                  fontFamily: 'NeueFrutigerWorld',
                  fontSize: 16,
                  color: ColorRes.charcoal,
                ),
                contentPadding: EdgeInsets.only(left: 0.0, bottom: 10),
              ),
            ),
          ),
          SizedBox(height: 20),

          //Road No
          Text(
            'Road No',
            style: TextStyle(
              fontFamily: 'NeueFrutigerWorld',
              fontSize: 16,
              color: ColorRes.dimGray,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: media.width * 0.06),
            child: TextFormField(
              //readOnly: true,
              keyboardType: TextInputType.number,

              validator: validateRoadNo,
              controller: _roadNo,
              onSaved: (String val) {
                roadNo = val;
              },
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade100),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade100),
                ),
                filled: true,
                fillColor: const Color(0xFFFFFFFF),
                hintText: '9',
                hintStyle: TextStyle(
                  fontFamily: 'NeueFrutigerWorld',
                  fontSize: 16,
                  color: ColorRes.charcoal,
                ),
                contentPadding: EdgeInsets.only(left: 0.0, bottom: 10),
              ),
            ),
          ),*/
         // SizedBox(height: 20),
        ],
      ),
    );
  }

  //===============================Validation=================================

  //Name
  String validateName(String value) {
    if (value.isEmpty)
      return 'Please enter your name';
     else
      return null;
  }

  //Address lane
  String validateAddress(String value) {
    if (value.isEmpty)
      return 'Please enter your address lane';
    else
      return null;
  }

  //City
  String validateCity(String value) {
    if (value.isEmpty)
      return 'Please enter your city';
    else
      return null;
  }

  //Postal Code
  String validatePostalCode(String value) {
    if (value.isEmpty)
      return 'Please enter your postal code';
    else if(value.length != 6)
      return 'Please enter your 6 digit postal code';
    else
      return null;
  }

  //Phone no
  String validateMobileNo(String value) {
    if (value.isEmpty)
      return 'Please enter your phone number';
    else if (value.length != 10)
      return 'Mobile number must be of 10 digit';
    else
      return null;
  }

 /* //House No
  String validateHouseNo(String value) {
    if (value.isEmpty)
      return 'Please enter house no';
    else
      return null;
  }
  //Road No
  String validateRoadNo(String value) {
    if (value.isEmpty)
      return 'Please enter road no';
    else
      return null;
  }*/

  bool _validateInputs() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      return true;
    } else {
      return false;
    }
  }
}
