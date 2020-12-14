// import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:homesaaz/app.dart';
import 'package:homesaaz/common/colorres.dart';
import 'package:homesaaz/common/common_route.dart';
import 'address_screen_view_model.dart';

class AddressScreen extends StatefulWidget {
  @override
  AddressScreenState createState() => AddressScreenState();
}

class AddressScreenState extends State<AddressScreen> {
  AddressScreenViewModel model;
  int isSelectedIndex = 0;
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    double width = media.width;
    double height = media.height;
    print("Current page --> $runtimeType");
    model ?? (model = AddressScreenViewModel(this));
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: ColorRes.primaryColor,
      appBar: AppBar(
        leading: InkWell(
          child: Image.asset(App.backArrow),
          onTap: () => Navigator.pop(context),
        ),
        elevation: 0,
        backgroundColor: ColorRes.primaryColor,
        actions: [
          InkWell(child: Image.asset(App.userIcon)),
          Image.asset(App.cartIcon),
        ],
      ),
      drawer: Scaffold(
        backgroundColor: ColorRes.whisper,
        body: SafeArea(
          child: Column(
            children: [
              Container(
                height: height * 0.8,
                width: width * width,
                color: ColorRes.primaryColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Text(
                          "Home",
                          style: new TextStyle(
                            fontSize: 20,
                            color: ColorRes.dimGray,
                            fontFamily: 'NeueFrutigerWorld',
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        //        gotoSeeAllScreen(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Text(
                          "Profile",
                          style: new TextStyle(
                            fontSize: 20,
                            color: ColorRes.dimGray,
                            fontFamily: 'NeueFrutigerWorld',
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Text(
                          "My Cart",
                          style: new TextStyle(
                            fontSize: 20,
                            color: ColorRes.dimGray,
                            fontFamily: 'NeueFrutigerWorld',
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Text(
                          "Favorite",
                          style: new TextStyle(
                            fontSize: 20,
                            color: ColorRes.dimGray,
                            fontFamily: 'NeueFrutigerWorld',
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Text(
                          "My Orders",
                          style: new TextStyle(
                            fontSize: 20,
                            color: ColorRes.dimGray,
                            fontFamily: 'NeueFrutigerWorld',
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Text(
                          "Help",
                          style: new TextStyle(
                            fontSize: 20,
                            color: ColorRes.dimGray,
                            fontFamily: 'NeueFrutigerWorld',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: width * 0.08, right: width * 0.1),
                alignment: Alignment.bottomRight,
                child: InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Image.asset(
                    App.cencelIcon,
                    //color: Colors.black,
                    height: 30,
                    width: 30,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Text(
                  "Address",
                  style: new TextStyle(
                    fontSize: 22,
                    color: ColorRes.charcoal,
                    fontFamily: 'NeueFrutigerWorld',
                  ),
                ),
                SizedBox(height: 20),
                ListView.builder(
                  itemCount: model.list.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return addressData(index);
                  },
                ),
              ],
            ),
          ),
          Spacer(),
          Column(
            //mainAxisAlignment: MainAxisAlignment.end,
            //crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // InkWell(
              //   onTap: () {
              //     gotoCreateAddressScreen(context);
              //   },
              //   child: DottedBorder(
              //     color: ColorRes.red,
              //     dashPattern: [4, 4],
              //     strokeWidth: 1,
              //     child: Container(
              //       alignment: Alignment.center,
              //       height: height * 0.07,
              //       width: width * 0.9,
              //       decoration: BoxDecoration(
              //         color: ColorRes.whiteColor,
              //         borderRadius: BorderRadius.circular(5.0),
              //       ),
              //       child: Text(
              //         '+ Add Address',
              //         style: new TextStyle(
              //             fontSize: 20,
              //             color: ColorRes.textColor,
              //             fontFamily: 'NeueFrutigerWorld',
              //             fontWeight: FontWeight.w500),
              //       ),
              //     ),
              //   ),
              // ),
              SizedBox(height: 10),
              InkWell(
                onTap: () {},
                child: Container(
                  alignment: Alignment.center,
                  height: height * 0.07,
                  width: width * 0.92,
                  decoration: BoxDecoration(
                    color: ColorRes.redColor,
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
          )
        ],
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
        child: Row(children: <Widget>[
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  model.list[index].name,
                  style: new TextStyle(
                    fontSize: 16,
                    color: ColorRes.charcoal,
                    fontFamily: 'NeueFrutigerWorld',
                  ),
                ),
                isSelectedIndex == index
                    ? Icon(Icons.radio_button_on_outlined,
                        color: ColorRes.redColor, size: 20)
                    : Icon(Icons.radio_button_off,
                        color: ColorRes.dimGray, size: 20),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
