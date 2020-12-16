import 'package:flutter/material.dart';
import 'package:homesaaz/app.dart';
import 'package:homesaaz/common/colorres.dart';
import 'package:homesaaz/common/common_widget.dart';
import 'package:homesaaz/model/cart_model.dart';
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

    return Scaffold(
      appBar: commonAppbar(context),
      body: Stack(
        children : [
          ListView.builder(
            itemCount: model.newProductName.length,
            itemBuilder: (context, index) {
              CartModel cartItem = model.newProductName[index];
            return cartProductView(cartItem,this,model.newProductName);
          },)
        ]
      ),
    );
  }
}
