import 'dart:convert';

ProductListModel productListModelFromJson(String str) => ProductListModel.fromJson(json.decode(str));

String productListModelToJson(ProductListModel data) => json.encode(data.toJson());

class ProductListModel {
  ProductListModel({
    this.productList,
  });

  List<ProductList> productList;

  factory ProductListModel.fromJson(Map<String, dynamic> json) => ProductListModel(
    productList: List<ProductList>.from(json["product_list"].map((x) => ProductList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "product_list": List<dynamic>.from(productList.map((x) => x.toJson())),
  };
}

class ProductList {
  ProductList({
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

  factory ProductList.fromJson(Map<String, dynamic> json) => ProductList(
    itemdetId: json["itemdet_id"] == null ? null : json["itemdet_id"],
    productName: json["product_name"],
    productImage: json["product_image"],
    price: json["price"],
    discountedPrice: json["discounted_price"],
    discountAvailable: json["discount_available"],
  );

  Map<String, dynamic> toJson() => {
    "itemdet_id": itemdetId == null ? null : itemdetId,
    "product_name": productName,
    "product_image": productImage,
    "price": price,
    "discounted_price": discountedPrice,
    "discount_available": discountAvailable,
  };
}