// To parse this JSON data, do
//
//     final orderDetailsModel = orderDetailsModelFromJson(jsonString);

import 'dart:convert';

OrderDetailsModel orderDetailsModelFromJson(String str) => OrderDetailsModel.fromJson(json.decode(str));

String orderDetailsModelToJson(OrderDetailsModel data) => json.encode(data.toJson());

class OrderDetailsModel {
  OrderDetailsModel({
    this.orderData,
    this.status,
  });

  OrderData orderData;
  String status;

  factory OrderDetailsModel.fromJson(Map<String, dynamic> json) => OrderDetailsModel(
    orderData: OrderData.fromJson(json["order_data"]),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "order_data": orderData.toJson(),
    "status": status,
  };
}

class OrderData {
  OrderData({
    this.orderNo,
    this.orderStatement,
    this.addressInfo,
    this.currentOrderStatus,
    this.orderStatusHistory,
    this.orderItemsList,
    this.cartSubtotal,
    this.shippingCharges,
    this.totalDiscount,
    this.totalAmount,
  });

  String orderNo;
  String orderStatement;
  String addressInfo;
  String currentOrderStatus;
  List<OrderStatusHistory> orderStatusHistory;
  List<OrderItemsList> orderItemsList;
  String cartSubtotal;
  String shippingCharges;
  String totalDiscount;
  String totalAmount;

  factory OrderData.fromJson(Map<String, dynamic> json) => OrderData(
    orderNo: json["order_no"],
    orderStatement: json["order_statement"],
    addressInfo: json["address_info"],
    currentOrderStatus: json["current_order_status"],
    orderStatusHistory: List<OrderStatusHistory>.from(json["order_status_history"].map((x) => OrderStatusHistory.fromJson(x))),
    orderItemsList: List<OrderItemsList>.from(json["order_items_list"].map((x) => OrderItemsList.fromJson(x))),
    cartSubtotal: json["cart_subtotal"],
    shippingCharges: json["shipping_charges"],
    totalDiscount: json["total_discount"],
    totalAmount: json["total_amount"],
  );

  Map<String, dynamic> toJson() => {
    "order_no": orderNo,
    "order_statement": orderStatement,
    "address_info": addressInfo,
    "current_order_status": currentOrderStatus,
    "order_status_history": List<dynamic>.from(orderStatusHistory.map((x) => x.toJson())),
    "order_items_list": List<dynamic>.from(orderItemsList.map((x) => x.toJson())),
    "cart_subtotal": cartSubtotal,
    "shipping_charges": shippingCharges,
    "total_discount": totalDiscount,
    "total_amount": totalAmount,
  };
}

class OrderItemsList {
  OrderItemsList({
    this.productName,
    this.pimage,
    this.qnty,
    this.price,
    this.discountedPrice,
    this.discountStatus,
  });

  String productName;
  String pimage;
  String qnty;
  String price;
  String discountedPrice;
  String discountStatus;

  factory OrderItemsList.fromJson(Map<String, dynamic> json) => OrderItemsList(
    productName: json["product_name"],
    pimage: json["pimage"],
    qnty: json["qnty"],
    price: json["price"],
    discountedPrice: json["discounted_price"],
    discountStatus: json["discount_status"],
  );

  Map<String, dynamic> toJson() => {
    "product_name": productName,
    "pimage": pimage,
    "qnty": qnty,
    "price": price,
    "discounted_price": discountedPrice,
    "discount_status": discountStatus,
  };
}

class OrderStatusHistory {
  OrderStatusHistory({
    this.statement,
    this.subStatement,
    this.indicatorStatus,
  });

  String statement;
  String subStatement;
  int indicatorStatus;

  factory OrderStatusHistory.fromJson(Map<String, dynamic> json) => OrderStatusHistory(
    statement: json["statement"],
    subStatement: json["sub_statement"],
    indicatorStatus: json["indicator_status"],
  );

  Map<String, dynamic> toJson() => {
    "statement": statement,
    "sub_statement": subStatement,
    "indicator_status": indicatorStatus,
  };
}
