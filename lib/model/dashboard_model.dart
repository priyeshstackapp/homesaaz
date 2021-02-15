// To parse this JSON data, do
//
//     final dashBoardModel = dashBoardModelFromJson(jsonString);

import 'dart:convert';

DashBoardModel dashBoardModelFromJson(String str) => DashBoardModel.fromJson(json.decode(str));

String dashBoardModelToJson(DashBoardModel data) => json.encode(data.toJson());

List<Category> categoriesFromJson(String json) => List<Category>.from(jsonDecode(json)["categories"].map((x) => Category.fromJson(x)));

class DashBoardModel {
  DashBoardModel({
    this.banners,
    this.newProducts,
    this.trendingProducts,
    this.featuredProducts,
    this.categories,
  });

  List<Banner> banners;
  List<Product> newProducts;
  List<Product> trendingProducts;
  List<Product> featuredProducts;
  List<Category> categories;

  factory DashBoardModel.fromJson(Map<String, dynamic> json) => DashBoardModel(
    banners: List<Banner>.from(json["banners"].map((x) => Banner.fromJson(x))),
    newProducts: List<Product>.from(json["new_products"].map((x) => Product.fromJson(x))),
    trendingProducts: List<Product>.from(json["trending_products"].map((x) => Product.fromJson(x))),
    featuredProducts: List<Product>.from(json["featured_products"].map((x) => Product.fromJson(x))),
    categories: List<Category>.from(json["categories"].map((x) => Category.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "banners": List<dynamic>.from(banners.map((x) => x.toJson())),
    "new_products": List<dynamic>.from(newProducts.map((x) => x.toJson())),
    "trending_products": List<dynamic>.from(trendingProducts.map((x) => x.toJson())),
    "featured_products": List<dynamic>.from(featuredProducts.map((x) => x.toJson())),
    "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
  };
}

class Banner {
  Banner({
    this.imageUrl,
  });

  String imageUrl;

  factory Banner.fromJson(Map<String, dynamic> json) => Banner(
    imageUrl: json["image_url"],
  );

  Map<String, dynamic> toJson() => {
    "image_url": imageUrl,
  };
}

class Category {
  Category({
    this.categoryId,
    this.categoryName,
    this.categoryImage,
    this.categoryIcon,
  });

  String categoryId;
  String categoryName;
  String categoryImage;
  String categoryIcon;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    categoryId: json["category_id"],
    categoryName: json["category_name"],
    categoryImage: json["category_image"],
    categoryIcon: json["category_icon"],
  );

  Map<String, dynamic> toJson() => {
    "category_id": categoryId,
    "category_name": categoryName,
    "category_image": categoryImage,
    "category_icon": categoryIcon,
  };
}

class Product {
  Product({
    this.itemdetId,
    this.productName,
    this.productImage,
    this.price,
    this.discountedPrice,
    this.discountAvailable,
    this.stockStatus,
  });

  String itemdetId;
  String productName;
  String productImage;
  String price;
  int discountedPrice;
  int count = 1;
  DiscountAvailable discountAvailable;
  String stockStatus;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    itemdetId: json["itemdet_id"],
    productName: json["product_name"],
    productImage: json["product_image"],
    price: json["price"],
    discountedPrice: json["discounted_price"],
    discountAvailable: discountAvailableValues.map[json["discount_available"]],
    stockStatus: json["stock_status"],
  );

  Map<String, dynamic> toJson() => {
    "itemdet_id": itemdetId,
    "product_name": productName,
    "product_image": productImage,
    "price": price,
    "discounted_price": discountedPrice,
    "discount_available": discountAvailableValues.reverse[discountAvailable],
    "stock_status": stockStatus,
  };
}

enum DiscountAvailable { NO }

final discountAvailableValues = EnumValues({
  "no": DiscountAvailable.NO
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
