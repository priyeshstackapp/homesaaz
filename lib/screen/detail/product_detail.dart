import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:homesaaz/app.dart';
import 'package:homesaaz/common/colorres.dart';
import 'package:homesaaz/common/common_route.dart';
import 'package:homesaaz/common/common_widget.dart';
import 'package:homesaaz/screen/detail/product_detail_view_model.dart';

class ProductDetailScreen extends StatefulWidget {
  @override
  ProductDetailScreenState createState() => ProductDetailScreenState();
}

class ProductDetailScreenState extends State<ProductDetailScreen> {
  ProductDetailViewModel model;
  CarouselController carouselController = CarouselController();
  int quantity =1;
  int _current = 0;
  int _currentColor = 0;

  String firstHalf;
  String secondHalf;

  bool flag = true;

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    double width = media.width;
    double height = media.height;
    print("Current page --> $runtimeType");
    model ?? (model = ProductDetailViewModel(this));

    if (model.product.description.length > 200) {
      firstHalf = model.product.description.substring(0, 200);
      secondHalf = model.product.description
          .substring(200, model.product.description.length);
    } else {
      firstHalf = model.product.description;
      secondHalf = "";
    }

    return Scaffold(
      appBar: commonAppbar(context),

      body: SafeArea(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            SingleChildScrollView(
              child: Container(

                height: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Stack(
                          alignment: Alignment.centerLeft,
                          children: [
                            CarouselSlider.builder(
                              itemCount: model.product.productUrl.length,
                              carouselController: carouselController,
                              itemBuilder: (BuildContext context, int itemIndex) =>
                                  Container(
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 5),
                                  child: Image.asset(
                                    model.product.productUrl[itemIndex],
                                    fit: BoxFit.cover,
                                    width: MediaQuery.of(context).size.width,
                                  ),
                                ),
                              ),
                              options: CarouselOptions(
                                autoPlay: false,
                                viewportFraction: 1.0,
                                enlargeCenterPage: false,
                                onPageChanged: (index, reason) {
                                  setState(() {
                                    _current = index;
                                  });
                                },
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20, bottom: 5),
                                child: Container(
                                  height: 20,
                                  child: ListView.builder(
                                    itemCount: model.product.productUrl.length,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return Container(
                                        width: 6,
                                        height: 6,
                                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: _current == index
                                              ? ColorRes.redColor
                                              : ColorRes.whiteColor,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        height: 40,
                        child: ListView.builder(
                          itemCount: model.product.productUrl.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int itemIndex) =>
                              Opacity(
                            opacity: 1,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _current = itemIndex;
                                  carouselController.animateToPage(_current);
                                });
                              },
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    width: 80,
                                    padding: EdgeInsets.symmetric(horizontal: 7),
                                    child: Image.asset(
                                      model.product.productUrl[itemIndex],
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  _current != itemIndex
                                      ? Container(
                                          width: 70,
                                          padding:
                                              EdgeInsets.symmetric(horizontal: 7),
                                          color:
                                              ColorRes.whiteColor.withOpacity(0.4),
                                        )
                                      : Container()
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10),
                            Text(
                              model.product.productName,
                              style: TextStyle(fontSize: 25, color: ColorRes.nero),
                            ),
                            SizedBox(height: 3),
                            Text(
                              "Product Code: ${model.product.productId}",
                              style: TextStyle(fontSize: 13, color: ColorRes.textColor.withOpacity(0.7)),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left:8.0),
                              child: Row(
                                children: [
                                  Text(
                                    "\$${model.product.newPrice}",
                                    style:
                                    TextStyle(fontSize: 22, color: ColorRes.redColor),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "\$${model.product.oldPrice}",
                                    style: TextStyle(fontSize: 22, color: ColorRes.dimGray.withOpacity(0.7)),
                                  ),
                                  SizedBox(
                                    width: media.width * 0.30,
                                  ),
                                  Container(
                                    color: ColorRes.creamColor,
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                            child: Padding(
                                              padding: const EdgeInsets.all(5),
                                              child: Icon(
                                                Icons.add,
                                                size: 20,
                                                color: ColorRes.charcoal,
                                              ),
                                            ),
                                            onTap: () {
                                              setState(() {
                                                quantity++;
                                              });
                                            }),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 10),
                                          child: Text(
                                            '${quantity}',
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: ColorRes.charcoal,
                                              fontFamily: 'NeueFrutigerWorld',
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                            child: Padding(
                                              padding: const EdgeInsets.all(5),
                                              child: Icon(
                                                Icons.remove,
                                                size: 20,
                                                color: ColorRes.charcoal,
                                              ),
                                            ),
                                            onTap: () {
                                              if (quantity != 1) {
                                                setState(() {
                                                  quantity--;
                                                });
                                              }
                                            }),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Text(
                              "Size: ${model.product.size}",
                              style: TextStyle(fontSize: 13, color: ColorRes.textColor.withOpacity(0.7)),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Description",
                              style: TextStyle(fontSize: 16, color: ColorRes.textColor.withOpacity(0.8)),
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            // Text(model.product.description,style: TextStyle(fontSize: 18,color: ColorRes.textColor),maxLines: 5,),
                            secondHalf.isEmpty
                                ? new Text(firstHalf,
                                style:
                                TextStyle(fontSize: 14, color: ColorRes.dimGray,height: 1.5))
                                : new Column(
                              children: <Widget>[
                                new Text(
                                    flag
                                        ? (firstHalf + "...")
                                        : (firstHalf + secondHalf),
                                    style: TextStyle(
                                        fontSize: 14, color: ColorRes.dimGray,height:1.5)),
                                new GestureDetector(
                                  child: new Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      new Text(
                                        flag ? "More" : "Less",
                                        style: new TextStyle(
                                            color: ColorRes.redColor,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  onTap: () {
                                    setState(() {
                                      flag = !flag;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 5, bottom: 10),
                        child: Divider(height: 1, color: ColorRes.gray57),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          children: [
                            Text(
                              "Select Color",
                              style:
                                  TextStyle(fontSize: 18, color: ColorRes.textColor.withOpacity(0.8)),
                            ),
                            Container(
                              height: 40,
                              child: ListView.builder(
                                itemCount: model.product.colors.length,
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (BuildContext context, int itemIndex) =>
                                    GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _currentColor = itemIndex;
                                    });
                                  },
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(40),
                                          child: Container(
                                            width: 40,
                                            decoration: BoxDecoration(
                                              color: Color(int.parse(
                                                  '0xff${model.product.colors[itemIndex]}')),
                                            ),
                                            // padding: EdgeInsets.symmetric(horizontal: 5),
                                          ),
                                        ),
                                      ),
                                      _currentColor != itemIndex
                                          ? Container(
                                              width: 40,
                                              padding:
                                                  EdgeInsets.symmetric(horizontal: 5),
                                              color: ColorRes.whiteColor
                                                  .withOpacity(0.4),
                                            )
                                          : Container()
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10, bottom: 10),
                        child: Divider(height: 1, color: ColorRes.gray57),
                      ),
                      SizedBox(
                        height: height*0.22,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              height: 50,
              child: Row(
                children: [
                  InkWell(
                    onTap: (){
                      gotoCartScreen(context);

                    },
                    child: Container(
                      color: ColorRes.whisper,
                      width: MediaQuery.of(context).size.width/2,
                      padding: EdgeInsets.all(10),
                      alignment: Alignment.center,
                      child: Text(
                        "ADD TO CART",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      gotoAddressScreen(context);

                    },
                    child: Container(
                      color: ColorRes.red,
                      width: MediaQuery.of(context).size.width/2,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "BUY NOW",
                        style: TextStyle(fontSize: 18,color: ColorRes.whiteColor),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
