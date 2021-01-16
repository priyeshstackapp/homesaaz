import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
              padding: const EdgeInsets.only(left: 19),
              child: commonTitle(model.orderDetailsModel!=null && model.orderDetailsModel.orderData!=null ? model.orderDetailsModel.orderData.orderNo : 'My Orders'),
            ),

            SizedBox(height: 10),
            model.orderDetailsModel!=null && model.orderDetailsModel.orderData!=null && model.orderDetailsModel.orderData.orderItemsList.isNotEmpty? Container(
              height: height*0.77,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: model.orderDetailsModel.orderData.orderItemsList.length,
                itemBuilder: (context, index) {
                  OrderItemsList myOrdersItem = model.orderDetailsModel.orderData.orderItemsList[index];
                  return myOrdersDetailView(myOrdersItem, this);
                },
              ),
            ) : Container(),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
