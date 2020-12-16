import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:homesaaz/common/colorres.dart';
import 'package:homesaaz/common/common_route.dart';
import '../../app.dart';
import 'confirmation_screen_view_model.dart';

class ConfirmationScreen extends StatefulWidget {
  @override
  ConfirmationScreenState createState() => ConfirmationScreenState();
}

class ConfirmationScreenState extends State<ConfirmationScreen> {
  ConfirmationScreenViewModel model;

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    double width = media.width;
    double height = media.height;
    print("Current page --> $runtimeType");
    model ?? (model = ConfirmationScreenViewModel(this));
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
        bottomNavigationBar: InkWell(
          onTap: () async {
            gotoHomeScreen(context);
          },
          child: Container(
            margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
            alignment: Alignment.center,
            height: height * 0.07,
            width: width * 0.92,
            decoration: BoxDecoration(
              color: ColorRes.red,
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Text(
              'Back to Home',
              style: new TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontFamily: 'NeueFrutigerWorld',
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
        backgroundColor: ColorRes.primaryColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(left: height * 0.1, right: height * 0.1),
              child: Image.asset(App.confirmation),
            ),
            SizedBox(height: 30),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Confirmation',
                  style: new TextStyle(
                      fontSize: 30,
                      color: ColorRes.charcoal,
                      fontFamily: 'NeueFrutigerWorld',
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(height: 10),
                Text(
                  'You have successfully\ncompleted your payment procedure',
                  textAlign: TextAlign.center,
                  style: new TextStyle(
                      fontSize: 14,
                      height: 1.5,
                      color: ColorRes.charcoal,
                      fontFamily: 'NeueFrutigerWorld',
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
            //Spacer(),
          ],
        ),
      ),
    );
  }
}
