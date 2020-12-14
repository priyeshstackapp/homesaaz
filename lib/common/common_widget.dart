import 'package:flutter/material.dart';
import 'package:homesaaz/app.dart';
import 'package:homesaaz/common/colorres.dart';
import 'package:homesaaz/common/common_route.dart';
import 'package:homesaaz/screen/home/home_screen_view_model.dart';

Widget gradientButton(context, {String title, bool isLoading}) {
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
          colors: [ColorRes.redColor, ColorRes.darkRedColor]),
    ),
    child: Center(
        child: isLoading
            ? Padding(
                child: CircularProgressIndicator(
                  backgroundColor: ColorRes.whiteColor,
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

showSnackBar(_scaffoldKey, String message, {bool isError = false}) {
  _scaffoldKey.currentState.showSnackBar(new SnackBar(
    content: new Text(
      message,
      textAlign: TextAlign.center,
      style:
          TextStyle(color: isError ? ColorRes.whiteColor : ColorRes.redColor),
    ),
    backgroundColor: isError ? ColorRes.redColor : ColorRes.whiteColor,
    duration: Duration(seconds: 3),
  ));
}

Widget backButton(context) {
  return InkWell(
    onTap: () => Navigator.pop(context),
    child: Image.asset(
      App.backIcon,
      color: ColorRes.redColor,
    ),
  );
}

class CustomTextFieldShadow extends StatelessWidget {
  final String text, name;
  final TextEditingController fieldController;
  final bool obscureText;
  final TextInputType keyboartType;
  final Size media;
  final BuildContext context;
  final int mxline;

  CustomTextFieldShadow(
      {Key key,
      this.text,
      this.fieldController,
      this.name,
      this.obscureText,
      this.keyboartType,
      this.context,
      this.media,
      this.mxline})
      : super(key: key);

  var _keyboartType;
  Widget _prefixiconData;

  @override
  Widget build(BuildContext context) {
    if (obscureText == false && name == "Search") {
      _keyboartType = keyboartType;
      _prefixiconData = Icon(
        Icons.search,
        color: Colors.grey,
      );
    } else {
      _keyboartType = TextInputType.text;
      _prefixiconData = null;
    }
    return Container(
      height: 45,
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFFF),
        borderRadius: BorderRadius.circular(5.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 5.5,
            spreadRadius: 1.5,
            offset: Offset(0.0, 9.0),
          ),
        ],
      ),
      child: TextFormField(
        controller: fieldController,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 5.0),
          prefixIcon: _prefixiconData != null
              ? Padding(
                  padding: EdgeInsets.all(0.0),
                  child: _prefixiconData,
                )
              : null,
          hintText: text,
          hintStyle:
              TextStyle(color: Colors.grey, fontSize: media.width * 0.050),
          fillColor: ColorRes.transparent,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            borderSide: BorderSide(color: ColorRes.transparent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            borderSide: BorderSide(color: ColorRes.transparent),
          ),
        ),
        obscureText: obscureText,
        keyboardType: _keyboartType,
        minLines: 1,
        maxLines: mxline,
      ),
    );
  }
}

Widget productView(String imageUrl,String productName,String oldPrice,String newPrice){
  return Column(
    children: <Widget>[
      Image.asset(
        imageUrl,
        fit: BoxFit.cover,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                '$newPrice',
                style: new TextStyle(
                  fontSize: 15,
                  color: ColorRes.charcoal,
                  fontFamily: 'NeueFrutigerWorld',
                  fontWeight: FontWeight.w400,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '$oldPrice',
                  style: TextStyle(
                    fontSize: 14,
                    color: ColorRes.charcoal,
                    fontFamily: 'NeueFrutigerWorld',
                    fontWeight: FontWeight.w200,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
              ),
            ],
          ),
          Text(
            productName,
            style: new TextStyle(
              color: ColorRes.charcoal,
              fontFamily: 'NeueFrutigerWorld',
              fontWeight: FontWeight.w400,
            ),
            maxLines: 2,
          ),
        ],
      ),
    ],
  );
}










