import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:homesaaz/common/colorres.dart';
import 'package:homesaaz/common/common_widget.dart';
import 'package:homesaaz/model/address_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'create_address_screen_view_model.dart';

class CreateAddressScreen extends StatefulWidget {
  bool edit;
  AddressData addressData;

  CreateAddressScreen(this.edit, this.addressData);

  @override
  CreateAddressScreenState createState() => CreateAddressScreenState();
}

class CreateAddressScreenState extends State<CreateAddressScreen> {
  CreateAddressScreenViewModel model;
  SharedPreferences prefs;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController addressCont = new TextEditingController();
  // final TextEditingController cityCont = new TextEditingController();
  final TextEditingController stateCont = new TextEditingController();
  final TextEditingController postalCodeCont = new TextEditingController();
  final TextEditingController houseNoCont = new TextEditingController();
  final TextEditingController mobileCont = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if(widget.edit){
      List<String> addr = widget.addressData.address.split(',');
      houseNoCont.text = widget.addressData.addressTitle.trim();
      postalCodeCont.text = addr[addr.length-1].trim();
      // cityCont.text = addr[addr.length-3];
      stateCont.text = addr[addr.length-2].trim();
      // addr.removeAt(addr.length-1);
      addr.removeAt(addr.length-1);
      addr.removeAt(addr.length-1);
      String lane = '';
      addr.forEach((element) {
        lane = lane + element + "," ;
      });
      addressCont.text = lane.trim();
      mobileCont.text = widget.addressData.mobile.trim();
    }
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
                  // SizedBox(height: 10),
                  commonTitle(widget.edit ? "Update Address": 'Create Address'),

                  SizedBox(height: 30),
                  Container(
                    height: height * 0.68,
                    child: addressDetails(),
                  ),
                  SizedBox(height: height * 0.01),
                  InkWell(
                    onTap: () {
                      setState(() {
                        if (_validateInputs()) {
                          model.addEditAddressListApi(widget.edit,id: widget.edit ? widget.addressData.addressId: "");
                        }
                      });

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
                        widget.edit ? "Update Address": 'Add Address',
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
            'House/Flat no.',
            style: TextStyle(
              fontFamily: 'NeueFrutigerWorld',
              fontSize: 16,
              color: ColorRes.textColor,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: media.width * 0.06),
            child: TextFormField(
              //readOnly: true,
              validator: validateHouse,
              controller: houseNoCont,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade100),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade100),
                ),
                filled: true,
                fillColor: const Color(0xFFFFFFFF),
                hintText: 'Enter your hourse/flat no.',
                hintStyle: TextStyle(
                  fontFamily: 'NeueFrutigerWorld',
                  fontSize: 14,
                  color: ColorRes.charcoal.withOpacity(0.7),
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
              color: ColorRes.textColor,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: media.width * 0.06),
            child: TextFormField(
              //  readOnly: true,
              controller: addressCont,
              validator: validateAddress,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade100),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade100),
                ),
                filled: true,
                fillColor: const Color(0xFFFFFFFF),
                hintText: 'Enter Address lane',
                hintStyle: TextStyle(
                  fontFamily: 'NeueFrutigerWorld',
                  fontSize: 14,
                  color: ColorRes.charcoal.withOpacity(0.7),
                ),
                contentPadding: EdgeInsets.only(left: 0.0, bottom: 10),
              ),
            ),
          ),
          SizedBox(height: 20),

          // //City
          // Text(
          //   'City',
          //   style: TextStyle(
          //     fontFamily: 'NeueFrutigerWorld',
          //     fontSize: 16,
          //     color: ColorRes.textColor,
          //   ),
          // ),
          // Padding(
          //   padding: EdgeInsets.only(right: media.width * 0.06),
          //   child: TextFormField(
          //     //readOnly: true,
          //     controller: cityCont,
          //     validator: validateCity,
          //     decoration: InputDecoration(
          //       enabledBorder: UnderlineInputBorder(
          //         borderSide: BorderSide(color: Colors.grey.shade100),
          //       ),
          //       focusedBorder: UnderlineInputBorder(
          //         borderSide: BorderSide(color: Colors.grey.shade100),
          //       ),
          //       //filled: true,
          //       fillColor: const Color(0xFFFFFFFF),
          //       hintText: 'Enter city',
          //       hintStyle: TextStyle(
          //         fontFamily: 'NeueFrutigerWorld',
          //         fontSize: 14,
          //         color: ColorRes.charcoal.withOpacity(0.7),
          //       ),
          //       contentPadding: EdgeInsets.only(left: 0.0, bottom: 10),
          //     ),
          //   ),
          // ),
          // SizedBox(height: 20),
          Text(
            'State',
            style: TextStyle(
              fontFamily: 'NeueFrutigerWorld',
              fontSize: 16,
              color: ColorRes.textColor,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: media.width * 0.06),
            child: TextFormField(
              //readOnly: true,
              controller: stateCont,
              validator: validateState,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade100),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade100),
                ),
                //filled: true,
                fillColor: const Color(0xFFFFFFFF),
                hintText: 'Enter state',
                hintStyle: TextStyle(
                  fontFamily: 'NeueFrutigerWorld',
                  fontSize: 14,
                  color: ColorRes.charcoal.withOpacity(0.7),
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
              color: ColorRes.textColor,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: media.width * 0.06),
            child: TextFormField(
              maxLength: 6,
              //readOnly: true,
              controller: postalCodeCont,
              validator: validatePostalCode,
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
                hintText: 'Enter postal code',
                counterText: '',
                hintStyle: TextStyle(
                  fontFamily: 'NeueFrutigerWorld',
                  fontSize: 14,
                  color: ColorRes.charcoal.withOpacity(0.7),
                ),
                contentPadding: EdgeInsets.only(left: 0.0, bottom: 10),
              ),
            ),
          ),
          SizedBox(height: 20),

          //Phone Number
          Text(
            'Phone Number',
            style: TextStyle(
              fontFamily: 'NeueFrutigerWorld',
              fontSize: 16,
              color: ColorRes.textColor,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: media.width * 0.06),
            child: TextFormField(
              //readOnly: true,
              maxLength: 10,
              controller: mobileCont,
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
                hintText: 'Enter phone number',
                counterText: '',
                hintStyle: TextStyle(
                  fontFamily: 'NeueFrutigerWorld',
                  fontSize: 14,
                  color: ColorRes.charcoal.withOpacity(0.7),
                ),
                contentPadding: EdgeInsets.only(left: 0.0, bottom: 10),
              ),
            ),
          ),
          SizedBox(height: 20),
          // SizedBox(height: 20),
        ],
      ),
    );
  }

  //===============================Validation=================================

  //Name
  String validateHouse(String value) {
    if (value.isEmpty)
      return 'Please enter your house/flat no.';
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
  //State
  String validateState(String value) {
    if (value.isEmpty)
      return 'Please enter your state';
    else
      return null;
  }

  //Postal Code
  String validatePostalCode(String value) {
    if (value.isEmpty)
      return 'Please enter your postal code';
    else if (value.length != 6)
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
