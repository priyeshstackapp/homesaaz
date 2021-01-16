// To parse this JSON data, do
//
//     final myOrdersModel = myOrdersModelFromJson(jsonString);

import 'dart:convert';

MyOrdersModel myOrdersModelFromJson(String str) => MyOrdersModel.fromJson(json.decode(str));

String myOrdersModelToJson(MyOrdersModel data) => json.encode(data.toJson());

class MyOrdersModel {
  MyOrdersModel({
    this.data,
    this.status,
  });

  List<MyOrderData> data;
  String status;

  factory MyOrdersModel.fromJson(Map<String, dynamic> json) => MyOrdersModel(
    data: List<MyOrderData>.from(json["data"].map((x) => MyOrderData.fromJson(x))),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "status": status,
  };
}

class MyOrderData {
  MyOrderData({
    this.orderId,
    this.orderDate,
    this.orderTime,
    this.orderNo,
    this.totalItems,
    this.orderTotal,
    this.orderStatus,
  });

  String orderId;
  String orderDate;
  String orderTime;
  String orderNo;
  String totalItems;
  String orderTotal;
  String orderStatus;
  int rating = 0;

  factory MyOrderData.fromJson(Map<String, dynamic> json) => MyOrderData(
    orderId: json["order_id"],
    orderDate: json["order_date"],
    orderTime: json["order_time"],
    orderNo: json["order_no"],
    totalItems: json["total_items"],
    orderTotal: json["order_total"],
    orderStatus: json["order_status"],
  );

  Map<String, dynamic> toJson() => {
    "order_id": orderId,
    "order_date": orderDate,
    "order_time": orderTime,
    "order_no": orderNo,
    "total_items": totalItems,
    "order_total": orderTotal,
    "order_status": orderStatus,
  };
}
