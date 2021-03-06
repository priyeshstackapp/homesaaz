import 'package:flutter/material.dart';
import 'package:homesaaz/common/colorres.dart';
import 'package:homesaaz/common/common_route.dart';
import 'package:homesaaz/common/common_widget.dart';
import 'package:homesaaz/common/util.dart';
import 'package:homesaaz/model/address_model.dart';
import 'package:homesaaz/model/cart_model.dart';
import '../../app.dart';
import 'checkout_screen_view_model.dart';

class CheckoutScreen extends StatefulWidget {
  final AddressData addressData;
  final CartModel cartModel;
  CheckoutScreen(this.addressData, this.cartModel);

  @override
  CheckoutScreenState createState() => CheckoutScreenState();
}

class CheckoutScreenState extends State<CheckoutScreen> {
  CheckoutScreenViewModel model;
  int isSelectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    print("Current page --> $runtimeType");
    model ?? (model = CheckoutScreenViewModel(this));

    Size media = MediaQuery.of(context).size;
    double width = media.width;
    double height = media.height;

    return Scaffold(
      backgroundColor: ColorRes.primaryColor,
      appBar: commonAppbar(context),
      bottomNavigationBar: model.cartModel!=null && model.cartModel.products!=null && model.cartModel.products.isNotEmpty?
      InkWell(
        onTap: () {
          if(select==null){
            Utils.showToast('Please select payment method');
          }else{
            if(select=='Paytm Wallet'){
              model.generateTxnToken(0);
            }else{
              model.placeOrder();
            }
          }
        },
        child: Container(
          alignment: Alignment.center,
          height: height * 0.07,
          width: width * 0.92,
          margin: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: ColorRes.red,
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Text(
            'Buy',
            style: new TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontFamily: 'NeueFrutigerWorld',
                fontWeight: FontWeight.w500),
          ),
        ),
      ) :
      Container(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 19),
              child: commonTitle('Checkout'),
            ),
            SizedBox(height: 10),
            model.cartModel!=null && model.cartModel.products!=null && model.cartModel.products.isNotEmpty?
            Container(
              // height: height * 0.69,
              child: Column(
                children: [
                  //list of Checkout Product
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: model.cartModel.products.length,
                    itemBuilder: (context, index) {
                      CartProduct cartItem = model.cartModel.products[index];
                      return cartProductView(cartItem,(){
                        model.removeFromCart(cartItem);
                      },() async {
                        await model.updateQuantity(cartItem, 'plus');
                        setState(() {
                          int quant = int.parse(cartItem.itemqty);
                          quant ++ ;
                          cartItem.itemqty = quant.toString();
                          model.cartModel.products[index] = cartItem;
                        });
                      },() async {
                        if (int.parse(cartItem.itemqty) != 1) {
                          await model.updateQuantity(cartItem, 'minus');
                          setState(() {
                            int quant = int.parse(cartItem.itemqty);
                            quant -- ;
                            cartItem.itemqty = quant.toString();
                            model.cartModel.products[index] = cartItem;
                          });
                        }
                      },context);
                    },
                  ),
                  //Address Show
                  addressData(),

                  //payment card Details
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 5, bottom: 10, left: 20, right: 20),
                    child: Divider(
                        height: 1, color: ColorRes.gray57.withOpacity(0.5)),
                  ),
                  paymentCard(),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 5, bottom: 10, left: 20, right: 20),
                    child: Divider(height: 1, color: ColorRes.gray57),
                  ),

                  //Total Payment
                  totalPayment(),

                  SizedBox(height: 20),

                  Text(
                    'Payment method',
                    style: TextStyle(
                      fontFamily: 'NeueFrutigerWorld',
                      fontSize: 22,
                      color: ColorRes.redColor,
                      fontWeight: FontWeight.bold
                    ),
                  ),

                  SizedBox(height: 10),

                  Column(
                    children: [
                      addRadioButton(0, 'Paytm Wallet'),
                      addRadioButton(1, 'Cash on delivery'),
                    ],
                  ),

                  SizedBox(height: 10),
                ],
              ),
            ) :
            Container(),
          ],
        ),
      ),
    );
  }

  List paymentOptions=["Paytm Wallet","Cash on delivery"];

  String select;

  Row addRadioButton(int btnValue, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio(
          activeColor: Theme.of(context).primaryColor,
          value: paymentOptions[btnValue],
          groupValue: select,
          onChanged: (value){
            setState(() {
              select=value;
            });
          },
        ),
        Text(title)
      ],
    );
  }

  //Address
  Widget addressData() {
    return Container(
      padding: EdgeInsets.all(15),
      color: ColorRes.whiteColor,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal:10,vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.addressData.addressTitle,
                              style: new TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: ColorRes.charcoal,
                                fontFamily: 'NeueFrutigerWorld',
                              ),
                              maxLines: 5,
                            ),
                            Text(
                              widget.addressData.address,
                              style: new TextStyle(
                                fontSize: 18,
                                color: ColorRes.charcoal,
                                fontFamily: 'NeueFrutigerWorld',
                              ),
                              maxLines: 5,
                            ),
                          ],
                        )
                ],
              ),
            ),
           Flexible(
                    flex: 2,
                    child: CircleAvatar(
                      radius: 5.0,
                      backgroundColor: ColorRes.cornflowerBlue,
                    ),
                  )
          ],
        ),
      ),
    );
  }

  //payment card show the text
  paymentCard() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        cardTextShow(App.subtotal, model.cartModel.actualCartSubtotal.toString()),
        cardTextShow(App.discount, model.cartModel.totalDiscount.toString()),
        cardTextShow(App.shipping, model.cartModel.shippingCharges.toString()),
      ],
    );
  }

  //card text show are use in design in payment card
  cardTextShow(String leftText, String rightText) {
    return Container(
      padding: EdgeInsets.only(bottom: 10, top: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(left: 20),
            child: Text(
              leftText,
              style: new TextStyle(
                  fontSize: 17,
                  color: ColorRes.gray57,
                  fontFamily: 'NeueFrutigerWorld',
                  fontWeight: FontWeight.w400),
            ),
          ),
          Container(
            alignment: Alignment.topRight,
            padding: EdgeInsets.only(right: 20),
            child: Text(
              leftText =="Discount" ? "- ₹ $rightText" : leftText =="Shipping" ? "+ ₹ $rightText" : "₹ $rightText",
              style: new TextStyle(
                  fontSize: 17,
                  color: ColorRes.charcoal,
                  fontFamily: 'NeueFrutigerWorld',
                  fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
    );
  }

  //Total Payment
  totalPayment() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.only(left: 20),
          child: Text(
            App.total,
            style: new TextStyle(
                fontSize: 17,
                color: ColorRes.charcoal,
                fontFamily: 'NeueFrutigerWorld',
                fontWeight: FontWeight.w400),
          ),
        ),
        Container(
          alignment: Alignment.topRight,
          padding: EdgeInsets.only(right: 20),
          child: Text(
            "₹ "+model.cartModel.totalAmount.toString(),
            style: new TextStyle(
                fontSize: 17,
                color: ColorRes.charcoal,
                fontFamily: 'NeueFrutigerWorld',
                fontWeight: FontWeight.w400),
          ),
        ),
      ],
    );
  }
}
