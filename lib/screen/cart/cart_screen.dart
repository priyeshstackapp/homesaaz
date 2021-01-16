import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:homesaaz/common/colorres.dart';
import 'package:homesaaz/common/common_route.dart';
import 'package:homesaaz/common/common_widget.dart';
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

    Size media = MediaQuery.of(context).size;
    double width = media.width;
    double height = media.height;

    return Scaffold(
      backgroundColor: ColorRes.primaryColor,
      appBar: commonAppbar(context),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children : [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: commonTitle('Cart'),
              ),
              SizedBox(height: 10),
              model.cartModel!=null && model.cartModel.products!=null? Container(
                height: height*0.69,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: model.cartModel.products.length,
                  itemBuilder: (context, index) {
                    Product cartItem = model.cartModel.products[index];
                    return cartProductView(cartItem,(){
                      print("RemoveButton");
                    },() {
                      setState(() {
                        int quant = int.parse(cartItem.itemqty);
                        quant ++ ;
                        cartItem.itemqty = quant.toString();
                      });
                    },() {
                      if (int.parse(cartItem.itemqty) != 1) {
                        setState(() {
                          int quant = int.parse(cartItem.itemqty);
                          quant -- ;
                          cartItem.itemqty = quant.toString();
                        });
                      }
                    });
                },),
              ) : Align(
                  alignment: Alignment.center,
                  child: Container(child: Text("Nothing in cart!"),)),
            ],
          ),
          model.cartModel!=null && model.cartModel.products!=null? InkWell(
            onTap: (){
              gotoAddressScreen(context);

            },
            child: Container(
              alignment: Alignment.center,
              height: height * 0.07,
              width: width * 0.92,
              margin: EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                color: ColorRes.red,
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Text(
                'Continue',
                style: new TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontFamily: 'NeueFrutigerWorld',
                    fontWeight: FontWeight.w500),
              ),
            ),
          ) : Container(),
        ]
      ),
    );
  }

}
