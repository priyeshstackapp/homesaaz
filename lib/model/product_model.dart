import 'dart:convert';

class ProductModel{
  String productName;
  String productId;
  List<String> productUrl;
  int oldPrice;
  int newPrice;
  String size;
  String description;
  List<String> colors;

  ProductModel(
      {this.productName,
      this.productUrl,
      this.oldPrice,
        this.productId,
      this.newPrice,
      this.size,
      this.description,
      this.colors});
}

ProductDetailModel productDetailModelFromJson(String str) => ProductDetailModel.fromJson(json.decode(str));

String productDetailModelToJson(ProductDetailModel data) => json.encode(data.toJson());

class ProductDetailModel {
  ProductDetailModel({
    this.data,
    this.status,
  });

  List<Datum> data;
  String status;

  factory ProductDetailModel.fromJson(Map<String, dynamic> json) => ProductDetailModel(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "status": status,
  };
}

class Datum {
  Datum({
    this.itemdetId,
    this.productName,
    this.catid,
    this.productImage,
    this.price,
    this.discountedPrice,
    this.discountAvailable,
    this.brandName,
    this.hsnCode,
    this.designName,
    this.qualityName,
    this.sizeName,
    this.sku,
    this.colorName,
    this.description,
  });

  String itemdetId;
  String productName;
  String catid;
  String productImage;
  String price;
  int discountedPrice;
  String discountAvailable;
  String brandName;
  String hsnCode;
  String designName;
  String qualityName;
  String sizeName;
  String sku;
  String colorName;
  String description;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    itemdetId: json["itemdet_id"],
    productName: json["product_name"],
    catid: json["catid"],
    productImage: json["product_image"],
    price: json["price"],
    discountedPrice: json["discounted_price"],
    discountAvailable: json["discount_available"],
    brandName: json["brand_name"],
    hsnCode: json["hsn_code"],
    designName: json["design_name"],
    qualityName: json["quality_name"],
    sizeName: json["size_name"],
    sku: json["sku"],
    colorName: json["color_name"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "itemdet_id": itemdetId,
    "product_name": productName,
    "catid": catid,
    "product_image": productImage,
    "price": price,
    "discounted_price": discountedPrice,
    "discount_available": discountAvailable,
    "brand_name": brandName,
    "hsn_code": hsnCode,
    "design_name": designName,
    "quality_name": qualityName,
    "size_name": sizeName,
    "sku": sku,
    "color_name": colorName,
    "description": description,
  };
}