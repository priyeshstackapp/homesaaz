import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:homesaaz/app.dart';
import 'package:homesaaz/common/colorres.dart';
import 'package:homesaaz/common/common_widget.dart';
import 'package:homesaaz/screen/detail/product_detail_view_model.dart';

class ProductDetailScreen extends StatefulWidget {
  @override
  ProductDetailScreenState createState() => ProductDetailScreenState();
}

class ProductDetailScreenState extends State<ProductDetailScreen> {
  ProductDetailViewModel model;
  CarouselController carouselController = CarouselController();

  int _current = 0;
  int _currentColor = 0;

  String firstHalf;
  String secondHalf;

  bool flag = true;

  @override
  Widget build(BuildContext context) {
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
      appBar: AppBar(
        leading: backButton(context),
        elevation: 0,
        backgroundColor: ColorRes.primaryColor,
        actions: [
          InkWell(child: Image.asset(App.userIcon)),
          Image.asset(App.cartIcon),
        ],
      ),
      body: SafeArea(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                height: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
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
                              padding: const EdgeInsets.only(left: 20, bottom: 20),
                              child: Container(
                                height: 20,
                                child: ListView.builder(
                                  itemCount: model.product.productUrl.length,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return Container(
                                      width: 12,
                                      height: 12,
                                      margin: EdgeInsets.symmetric(horizontal: 2.0),
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
                      Container(
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
                                    width: 70,
                                    padding: EdgeInsets.symmetric(horizontal: 5),
                                    child: Image.asset(
                                      model.product.productUrl[itemIndex],
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  _current != itemIndex
                                      ? Container(
                                          width: 70,
                                          padding:
                                              EdgeInsets.symmetric(horizontal: 5),
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
                      Text(
                        model.product.productName,
                        style: TextStyle(fontSize: 25, color: ColorRes.textColor),
                      ),
                      Text(
                        "Product Code: ${model.product.productId}",
                        style: TextStyle(fontSize: 13, color: ColorRes.textColor),
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Row(
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
                            style: TextStyle(fontSize: 22, color: ColorRes.dimGray),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Text(
                        "Size: ${model.product.size}",
                        style: TextStyle(fontSize: 13, color: ColorRes.textColor),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Description",
                        style: TextStyle(fontSize: 16, color: ColorRes.textColor),
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      // Text(model.product.description,style: TextStyle(fontSize: 18,color: ColorRes.textColor),maxLines: 5,),
                      secondHalf.isEmpty
                          ? new Text(firstHalf,
                              style:
                                  TextStyle(fontSize: 14, color: ColorRes.dimGray))
                          : new Column(
                              children: <Widget>[
                                new Text(
                                    flag
                                        ? (firstHalf + "...")
                                        : (firstHalf + secondHalf),
                                    style: TextStyle(
                                        fontSize: 18, color: ColorRes.dimGray)),
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
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Text(
                            "Select Color",
                            style:
                                TextStyle(fontSize: 18, color: ColorRes.textColor),
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
                      )
                    ],
                  ),
                ),
              ),
            ),
            Container(
              height: 50,
              child: Row(
                children: [
                  Container(
                    color: ColorRes.whisper,
                    width: MediaQuery.of(context).size.width/2,
                    padding: EdgeInsets.all(10),
                    alignment: Alignment.center,
                    child: Text(
                      "ADD TO CART",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  Container(
                    color: ColorRes.redColor,
                    width: MediaQuery.of(context).size.width/2,
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "BUY NOW",
                      style: TextStyle(fontSize: 18,color: ColorRes.whiteColor),
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
