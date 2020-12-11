import 'package:flutter/material.dart';
import 'package:homesaaz/app.dart';
import 'package:homesaaz/common/colorres.dart';

Widget gradientButton(context,{String title,bool isLoading}) {
 return Container(
   height: MediaQuery.of(context).size.height * .060,
   width: MediaQuery.of(context).size.width / 1.2,
   decoration: BoxDecoration(
     borderRadius: BorderRadius.circular(8),
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
         colors: [
           ColorRes.redColor,
           ColorRes.darkRedColor
         ]),
   ),
   child: Center(
       child: isLoading
           ? Padding(
         child: CircularProgressIndicator(
           backgroundColor:
           ColorRes.whiteColor,
         ),
         padding: EdgeInsets.all(5),
       )
           : Text(title,
           style: TextStyle(
               color: Colors.white,
               fontSize: 16,
               fontFamily: 'NeueFrutigerWorld',
               fontWeight: FontWeight.w700))),
 );
}

showSnackBar(_scaffoldKey,String message, {bool isError = false}) {
  _scaffoldKey.currentState.showSnackBar(new SnackBar(
    content: new Text(
      message,
      textAlign: TextAlign.center,
      style: TextStyle(color: isError ? ColorRes.whiteColor : ColorRes.redColor),
    ),
    backgroundColor: isError ? ColorRes.redColor : ColorRes.whiteColor,
    duration: Duration(seconds: 3),
  ));
}

Widget backButton(context) {
  return InkWell(
    onTap: () => Navigator.pop(context),
    child: Image.asset(App.backIcon,),
  );
}