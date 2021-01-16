// To parse this JSON data, do
//
//     final cartModel = cartModelFromJson(jsonString);

import 'dart:convert';

CartModel cartModelFromJson(String str) => CartModel.fromJson(json.decode(str));

String cartModelToJson(CartModel data) => json.encode(data.toJson());

class CartModel {
  CartModel({
    this.products,
    this.promocode,
    this.actualCartSubtotal,
    this.cartSubtotal,
    this.shippingCharges,
    this.totalItems,
    this.totalDiscount,
    this.totalAmount,
  });

  List<CartProduct> products;
  dynamic promocode;
  int actualCartSubtotal;
  int cartSubtotal;
  int shippingCharges;
  int totalItems;
  int totalDiscount;
  int totalAmount;

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
    products: List<CartProduct>.from(json["products"].map((x) => CartProduct.fromJson(x))),
    promocode: json["promocode"],
    actualCartSubtotal: json["actual_cart_subtotal"],
    cartSubtotal: json["cart_subtotal"],
    shippingCharges: json["shipping_charges"],
    totalItems: json["total_items"],
    totalDiscount: json["total_discount"],
    totalAmount: json["total_amount"],
  );

  Map<String, dynamic> toJson() => {
    "products": List<dynamic>.from(products.map((x) => x.toJson())),
    "promocode": promocode,
    "actual_cart_subtotal": actualCartSubtotal,
    "cart_subtotal": cartSubtotal,
    "shipping_charges": shippingCharges,
    "total_items": totalItems,
    "total_discount": totalDiscount,
    "total_amount": totalAmount,
  };
}

class CartProduct {
  CartProduct({
    this.itemid,
    this.itemname,
    this.pimage,
    this.itemqty,
    this.itemlink,
    this.itemprice,
    this.itemNewPrice,
    this.itemDiscountStatus,
    this.itemSubtotal,
  });

  int itemid;
  String itemname;
  String pimage;
  String itemqty;
  String itemlink;
  String itemprice;
  int itemNewPrice;
  String itemDiscountStatus;
  int itemSubtotal;

  factory CartProduct.fromJson(Map<String, dynamic> json) => CartProduct(
    itemid: json["itemid"],
    itemname: json["itemname"],
    pimage: json["pimage"],
    itemqty: json["itemqty"],
    itemlink: json["itemlink"],
    itemprice: json["itemprice"],
    itemNewPrice: json["item_new_price"],
    itemDiscountStatus: json["item_discount_status"],
    itemSubtotal: json["item_subtotal"],
  );

  Map<String, dynamic> toJson() => {
    "itemid": itemid,
    "itemname": itemname,
    "pimage": pimage,
    "itemqty": itemqty,
    "itemlink": itemlink,
    "itemprice": itemprice,
    "item_new_price": itemNewPrice,
    "item_discount_status": itemDiscountStatus,
    "item_subtotal": itemSubtotal,
  };
}
