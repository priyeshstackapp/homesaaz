import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:homesaaz/app.dart';
import 'package:homesaaz/common/colorres.dart';
import 'package:homesaaz/common/common_widget.dart';
import 'package:homesaaz/model/my_order_model.dart';
import 'package:homesaaz/model/order_details_model.dart';
import 'my_orders_detail_screen_view_model.dart';

class MyOrdersDetailScreen extends StatefulWidget {
  String orderId;

  MyOrdersDetailScreen(this.orderId);

  @override
  MyOrdersDetailScreenState createState() => MyOrdersDetailScreenState();
}

class MyOrdersDetailScreenState extends State<MyOrdersDetailScreen> {
  MyOrdersDetailScreenViewModel model;

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    double width = media.width;
    double height = media.height;
    print("Current page --> $runtimeType");
    model ?? (model = MyOrdersDetailScreenViewModel(this));
    return Scaffold(
      backgroundColor: ColorRes.primaryColor,
      appBar: commonAppbar(context),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: commonTitle(model.orderDetailsModel!=null && model.orderDetailsModel.orderData!=null ? "Order Id: "+model.orderDetailsModel.orderData.orderNo : 'My Orders'),
            ),

            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              width: MediaQuery.of(context).size.width,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Icon(Icons.home_rounded,size: 30,),
                SizedBox(width: 10,),
                Expanded(child: Text(model.orderDetailsModel?.orderData?.addressInfo ?? "",style: new TextStyle(
                  fontSize: 14,
                  color: ColorRes.dimGray,
                  fontFamily: 'NeueFrutigerWorld',
                  fontWeight: FontWeight.w400,
                ),))
              ],),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
              height: 2,width: MediaQuery.of(context).size.width,color: ColorRes.dimGray,),

            Container(
              margin: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  Column(
                    children: [
                      Container(
                        height: 25,
                        width: 25,
                        decoration: BoxDecoration(
                            color: ColorRes.redColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        alignment: Alignment.center,
                        child: Text(
                          model.orderDetailsModel?.orderData?.currentOrderStatus == "0" ? "1": "",
                          style: TextStyle(color: ColorRes.whiteColor, fontFamily: 'NeueFrutigerWorld',
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Container(height: 35,width: 2,decoration: BoxDecoration(color: ColorRes.redColor),),
                      Container(
                        height: 25,
                        width: 25,
                        decoration: BoxDecoration(
                            color: ColorRes.redColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        alignment: Alignment.center,
                        child: Text(
                          model.orderDetailsModel?.orderData?.currentOrderStatus == "1" ? "2": "",
                          style: TextStyle(color: ColorRes.whiteColor, fontFamily: 'NeueFrutigerWorld',
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Container(height: 35,width: 2,decoration: BoxDecoration(color: ColorRes.redColor),),
                      Container(
                        height: 25,
                        width: 25,
                        decoration: BoxDecoration(
                            color: ColorRes.redColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        alignment: Alignment.center,
                        child: Text(
                          model.orderDetailsModel?.orderData?.currentOrderStatus == "2" ? "3": "",
                          style: TextStyle(color: ColorRes.whiteColor, fontFamily: 'NeueFrutigerWorld',
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Container(height: 35,width: 2,decoration: BoxDecoration(color: ColorRes.redColor),),
                      Container(
                        height: 25,
                        width: 25,
                        decoration: BoxDecoration(
                            color: ColorRes.redColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        alignment: Alignment.center,
                        child: Text(
                          model.orderDetailsModel?.orderData?.currentOrderStatus == "3" ? "4": "",
                          style: TextStyle(color: ColorRes.whiteColor, fontFamily: 'NeueFrutigerWorld',
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 20,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10,),
                      Container(
                        height: 35,
                        width: MediaQuery.of(context).size.width / 1.3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Your order has been placed successfully",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontFamily: 'NeueFrutigerWorld',
                                fontWeight: model.orderDetailsModel?.orderData?.currentOrderStatus == "0" ? FontWeight.bold : FontWeight.normal
                              ),
                            ),
                            Text(
                              model.orderDetailsModel?.orderData?.currentOrderStatus == "0" ? "${model.orderDetailsModel?.orderData?.orderStatusHistory?.first?.subStatement}" : "",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontFamily: 'NeueFrutigerWorld',
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 25),
                      Container(
                        height: 35,
                        width: MediaQuery.of(context).size.width / 1.3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Your order is being processed",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontFamily: 'NeueFrutigerWorld',
                                  fontWeight: model.orderDetailsModel?.orderData?.currentOrderStatus == "1" ? FontWeight.bold : FontWeight.normal
                              ),
                            ),
                            Text(
                              model.orderDetailsModel?.orderData?.currentOrderStatus == "1" ? "${model.orderDetailsModel?.orderData?.orderStatusHistory?.first?.subStatement}" : "",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: 'NeueFrutigerWorld',
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 25),
                      Container(
                        height: 35,
                        width: MediaQuery.of(context).size.width / 1.3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Your order is out for delivery",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontFamily: 'NeueFrutigerWorld',
                                  fontWeight: model.orderDetailsModel?.orderData?.currentOrderStatus == "2" ? FontWeight.bold : FontWeight.normal
                              ),
                            ),
                            Text(
                              model.orderDetailsModel?.orderData?.currentOrderStatus == "2" ? "${model.orderDetailsModel?.orderData?.orderStatusHistory?.first?.subStatement}" : "",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: 'NeueFrutigerWorld',
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 25),
                      Container(
                        height: 35,
                        width: MediaQuery.of(context).size.width / 1.3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Your order has been delivered successfully",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontFamily: 'NeueFrutigerWorld',
                                  fontWeight: model.orderDetailsModel?.orderData?.currentOrderStatus == "3" ? FontWeight.bold : FontWeight.normal
                              ),
                            ),
                            Text(
                              model.orderDetailsModel?.orderData?.currentOrderStatus == "3" ? "${model.orderDetailsModel?.orderData?.orderStatusHistory?.first?.subStatement}" : "",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: 'NeueFrutigerWorld',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),

            model.orderDetailsModel!=null && model.orderDetailsModel.orderData!=null && model.orderDetailsModel.orderData.orderItemsList.isNotEmpty?
            Container(
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: model.orderDetailsModel.orderData.orderItemsList.length,
                itemBuilder: (context, index) {
                  OrderItemsList myOrdersItem = model.orderDetailsModel.orderData.orderItemsList[index];
                  return myOrdersDetailView(myOrdersItem, this);
                },
              ),
            ) : Container(),
            Padding(
              padding: const EdgeInsets.only(left:20,bottom: 15),
              child: Text(
                "Bill Details",
                style: TextStyle(
                    fontSize: 17,
                    color: ColorRes.charcoal,
                    fontFamily: 'NeueFrutigerWorld',
                    fontWeight: FontWeight.w500),
              ),
            ),
            paymentCard(),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
              height: 2,width: MediaQuery.of(context).size.width,color: ColorRes.dimGray,),
            totalPayment(),
            SizedBox(height: 40),
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
        cardTextShow(App.subtotal, model.orderDetailsModel?.orderData?.cartSubtotal.toString()),
        cardTextShow(App.discount, model.orderDetailsModel?.orderData?.totalDiscount.toString()),
        cardTextShow(App.shipping, model.orderDetailsModel?.orderData?.shippingCharges.toString()),
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
            "₹ ${model.orderDetailsModel?.orderData?.totalAmount}",
            style: new TextStyle(
                fontSize: 17,
                color: ColorRes.redColor,
                fontFamily: 'NeueFrutigerWorld',
                fontWeight: FontWeight.w400),
          ),
        ),
      ],
    );
  }
}
