import 'package:flutter/material.dart';
import 'package:homesaaz/common/colorres.dart';
import 'package:homesaaz/common/common_route.dart';
import 'package:homesaaz/common/common_widget.dart';
import 'package:homesaaz/model/cart_model.dart';
import 'package:homesaaz/model/wish_model.dart';
import 'package:homesaaz/screen/wish/wish_view_model.dart';

class WishScreen extends StatefulWidget {
  @override
  WishScreenState createState() => WishScreenState();
}

class WishScreenState extends State<WishScreen> {

  WishViewModel model;

  @override
  Widget build(BuildContext context) {
    print("Current page --> $runtimeType");
    model ?? (model = WishViewModel(this));

    Size media = MediaQuery
        .of(context)
        .size;
    double width = media.width;
    double height = media.height;

    return Scaffold(
      backgroundColor: ColorRes.primaryColor,
      appBar: commonAppbar(context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: commonTitle('Wish List'),
          ),
          SizedBox(height: 10),
          model.wishModel != null && model.wishModel.data != null &&
              model.wishModel.data.isNotEmpty ? Container(
            height: height * 0.69,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: model.wishModel.data.length,
              itemBuilder: (context, index) {
                WishProduct cartItem = model.wishModel.data[index];
                return wishProductView(cartItem,
                        () => model.removeFromCart(cartItem.itemdetId),
                        () => model.addToCart(model.wishModel.data[index].itemdetId,model.wishModel.data[index].count),
                        () => setState(() {
                          model.wishModel.data[index].count ++;
                        }), () async {
                      if (model.wishModel.data[index].count != 1) {
                        setState(() {
                          model.wishModel.data[index].count --;
                        });
                      }
                    },context
                );
              },),
          ) : Align(
              alignment: Alignment.center,
              child: Container(child: Text("Nothing in cart!"),)),
        ],
      ),
    );
  }
}
