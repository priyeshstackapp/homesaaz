import 'package:flutter/material.dart';
import 'package:homesaaz/app.dart';
import 'package:homesaaz/common/colorres.dart';
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
            color: Colors.grey.withOpacity(0.4),
            blurRadius: 2.5,
            spreadRadius: 1.5,
            offset: Offset(0.0, 0.0),
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


//================================Home Screen Products Details=======================================
Widget newTrendingAndFeaturedProducts(context,String title, HomeScreenViewModel model, int i){
  Size media = MediaQuery.of(context).size;
  double width = media.width;
  double height = media.height;
  return Column(
    children: [
      //All Products Title
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(left: 25),
              child: Text(
                title,
                style: new TextStyle(
                    fontSize: 20,
                    color: ColorRes.charcoal,
                    fontFamily: 'NeueFrutigerWorld',
                    fontWeight: FontWeight.w400),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.topRight,
              padding: EdgeInsets.only(right: 20),
              child: Text(
                "See all",
                style: new TextStyle(
                    fontSize: 14,
                    color: ColorRes.charcoal,
                    fontFamily: 'NeueFrutigerWorld',
                    fontWeight: FontWeight.w400),
              ),
            ),
          ),
        ],
      ),
      SizedBox(height: 18),

      //All Products Images, price and product name
      Container(
        padding: EdgeInsets.only(left: 25),
        color: ColorRes.primaryColor,
        height: height*0.4,
        child: ListView.builder(
            itemCount: countShow(model, i),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Column(
                  children: <Widget>[
                    Image.asset(
                      imageShow(model ,i,index),
                      fit: BoxFit.cover,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              productNameAfterShow(model ,i,index),
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
                                productNameBeforeShow(model ,i,index),
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
                        Padding(
                          padding:EdgeInsets.only(right:width*0.16),
                          child: Text(
                          productNameShow(model ,i,index),
                            style: new TextStyle(
                              color: ColorRes.charcoal,
                              fontFamily: 'NeueFrutigerWorld',
                              fontWeight: FontWeight.w400,
                            ),
                            maxLines: 2,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }),
      ),
    ],
  );
}

//All product show length in List view
countShow(HomeScreenViewModel model, int i) {
  if(i == 1) {
    return model.newProductImage.length;
  } else if(i == 2) {
    return model.trendingProductsImage.length;
  }else if(i == 3){
    return model.featuredProductsImage.length;
  }
}

//All product Images
imageShow(HomeScreenViewModel model, int i ,int index) {
  if(i == 1) {
    return model.newProductImage[index];
  } else if(i == 2) {
    return model.trendingProductsImage[index];
  }else if(i == 3){
    return model.featuredProductsImage[index];
  }
}

//All product after prices
productNameAfterShow(HomeScreenViewModel model, int i ,int index) {
  if(i == 1) {
    return model.newProductName[index].productPriceAfter;
  } else if(i == 2) {
    return model.trendingProductsName[index].productPriceAfter;
  }else if(i == 3){
    return  model.featuredProductsName[index].productPriceAfter;
  }
}

//All product before prices
productNameBeforeShow(HomeScreenViewModel model, int i, int index) {
  if(i == 1) {
    return model.newProductName[index].productPriceBefore;
  } else if(i == 2) {
    return model.trendingProductsName[index].productPriceBefore;
  }else if(i == 3){
    return  model.featuredProductsName[index].productPriceBefore;
  }
}

//All product name
productNameShow(HomeScreenViewModel model, int i, int index) {
  if(i == 1) {
    return model.newProductName[index].productName;
  } else if(i == 2) {
    return model.trendingProductsName[index].productName;
  }else if(i == 3){
    return  model.featuredProductsName[index].productName;
  }
}

//Top,Center,Bottom Banner
Widget bannerShow(String images){
  return Stack(
    children: [
      Image.asset(images),
    ],
  );
}









