import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:homesaaz/common/colorres.dart';
import 'package:homesaaz/common/common_route.dart';
import 'package:homesaaz/common/common_widget.dart';
import 'package:homesaaz/model/my_order_model.dart';
import 'my_orders_screen_view_model.dart';

class MyOrdersScreen extends StatefulWidget {
  @override
  MyOrdersScreenState createState() => MyOrdersScreenState();
}

class MyOrdersScreenState extends State<MyOrdersScreen> {
  MyOrdersScreenViewModel model;

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    double width = media.width;
    double height = media.height;
    print("Current page --> $runtimeType");
    model ?? (model = MyOrdersScreenViewModel(this));
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
        backgroundColor: ColorRes.primaryColor,
        appBar: commonAppbar(context),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 19),
                child: commonTitle('My Orders'),
              ),

              SizedBox(height: 10),
              model.ordersModel!=null && model.ordersModel.data!=null && model.ordersModel.data.isNotEmpty?  Container(
                height: height*0.77,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: model.ordersModel.data.length,
                  itemBuilder: (context, index) {
                    MyOrderData myOrdersItem = model.ordersModel.data[index];
                    return InkWell(
                      onTap: (){
                        gotoMyOrderDetailScreen(this.context,myOrdersItem.orderId);
                      },
                      child: myOrdersView(myOrdersItem),
                    );
                  },
                ),
              ) : Align(
                  alignment: Alignment.center,
                  child: Container(child: Text("No orders!"),)),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
