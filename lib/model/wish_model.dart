// To parse this JSON data, do
//
//     final wishModel = wishModelFromJson(jsonString);

import 'dart:convert';

WishModel wishModelFromJson(String str) => WishModel.fromJson(json.decode(str));

String wishModelToJson(WishModel data) => json.encode(data.toJson());

class WishModel {
  WishModel({
    this.data,
  });

  List<WishProduct> data;

  factory WishModel.fromJson(Map<String, dynamic> json) => WishModel(
    data: List<WishProduct>.from(json["data"].map((x) => WishProduct.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class WishProduct {
  WishProduct({
    this.itemdetId,
    this.productName,
    this.productImage,
    this.price,
    this.discountedPrice,
    this.discountAvailable,
  });

  String itemdetId;
  String productName;
  String productImage;
  String price;
  int discountedPrice;
  String discountAvailable;

  factory WishProduct.fromJson(Map<String, dynamic> json) => WishProduct(
    itemdetId: json["itemdet_id"],
    productName: json["product_name"],
    productImage: json["product_image"],
    price: json["price"],
    discountedPrice: json["discounted_price"],
    discountAvailable: json["discount_available"],
  );

  Map<String, dynamic> toJson() => {
    "itemdet_id": itemdetId,
    "product_name": productName,
    "product_image": productImage,
    "price": price,
    "discounted_price": discountedPrice,
    "discount_available": discountAvailable,
  };
}
