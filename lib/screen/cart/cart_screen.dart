import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:homesaaz/app.dart';
import 'package:homesaaz/common/colorres.dart';
import 'package:homesaaz/common/common_route.dart';
import 'package:homesaaz/common/common_widget.dart';
import 'package:homesaaz/common/dependency_injection.dart';
import 'package:homesaaz/model/cart_model.dart';
import 'package:homesaaz/model/product_model.dart';
import 'package:homesaaz/screen/cart/cart_view_model.dart';

class CartScreen extends StatefulWidget {
  @override
  CartScreenState createState() => CartScreenState();
}

class CartScreenState extends State<CartScreen> {

  CartViewModel model;

  @override
  Widget build(BuildContext context) {
    print("Current page --> $runtimeType");
    model ?? (model = CartViewModel(this));

    Size media = MediaQuery
        .of(context)
        .size;
    double width = media.width;
    double height = media.height;

    return Scaffold(
      backgroundColor: ColorRes.primaryColor,
      appBar: commonAppbar(context),
      body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: commonTitle('Cart'),
                ),
                SizedBox(height: 10),
                model.cartModel != null && model.cartModel.products != null &&
                    model.cartModel.products.isNotEmpty ? Container(
                  height: height * 0.69,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: model.cartModel.products.length,
                    itemBuilder: (context, index) {
                      CartProduct cartItem = model.cartModel.products[index];
                      return cartProductView(cartItem, () {
                        model.removeFromCart(cartItem);
                      }, () async {
                        await model.updateQuantity(cartItem, 'plus');
                        setState(() {
                          int quant = int.parse(cartItem.itemqty);
                          quant ++;
                          cartItem.itemqty = quant.toString();
                        });
                      }, () async {
                        if (int.parse(cartItem.itemqty) != 1) {
                          await model.updateQuantity(cartItem, 'minus');
                          setState(() {
                            int quant = int.parse(cartItem.itemqty);
                            quant --;
                            cartItem.itemqty = quant.toString();
                          });
                        }
                      },context);
                    },),
                ) : Align(
                    alignment: Alignment.center,
                    child: Container(child: Text("Nothing in cart!"),)),
              ],
            ),

            model.cartModel != null && model.cartModel.products != null &&
                model.cartModel.products.isNotEmpty ?
            InkWell(
              onTap: () {
                gotoAddressScreen(context, model.cartModel);
              },
              child: Container(
                alignment: Alignment.center,
                height: height * 0.06,
                width: width * 0.92,
                padding: EdgeInsets.symmetric(horizontal: 20),
                margin: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  color: ColorRes.red,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(model.cartModel?.totalItems.toString() +" items | ₹"+model.cartModel.totalAmount.toString(),
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontFamily: 'NeueFrutigerWorld',
                          fontWeight: FontWeight.w500),),
                    Text(
                      'Continue',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontFamily: 'NeueFrutigerWorld',
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ) : Container(),
          ]
      ),
    );
  }
}
