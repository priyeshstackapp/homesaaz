// To parse this JSON data, do
//
//     final dashBoardModel = dashBoardModelFromJson(jsonString);

import 'dart:convert';

DashBoardModel dashBoardModelFromJson(String str) => DashBoardModel.fromJson(json.decode(str));

String dashBoardModelToJson(DashBoardModel data) => json.encode(data.toJson());

class DashBoardModel {
  DashBoardModel({
    this.banners,
    this.newProducts,
    this.trendingProducts,
    this.featuredProducts,
    this.categories,
    this.staticBanner,
  });

  List<Banner> banners;
  List<Product> newProducts;
  List<Product> trendingProducts;
  List<Product> featuredProducts;
  List<Category> categories;
  List<Banner> staticBanner;

  factory DashBoardModel.fromJson(Map<String, dynamic> json) => DashBoardModel(
    banners: List<Banner>.from(json["banners"].map((x) => Banner.fromJson(x))),
    newProducts: List<Product>.from(json["new_products"].map((x) => Product.fromJson(x))),
    trendingProducts: List<Product>.from(json["trending_products"].map((x) => Product.fromJson(x))),
    featuredProducts: List<Product>.from(json["featured_products"].map((x) => Product.fromJson(x))),
    categories: List<Category>.from(json["categories"].map((x) => Category.fromJson(x))),
    staticBanner: List<Banner>.from(json["static_banner"].map((x) => Banner.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "banners": List<dynamic>.from(banners.map((x) => x.toJson())),
    "new_products": List<dynamic>.from(newProducts.map((x) => x.toJson())),
    "trending_products": List<dynamic>.from(trendingProducts.map((x) => x.toJson())),
    "featured_products": List<dynamic>.from(featuredProducts.map((x) => x.toJson())),
    "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
    "static_banner": List<dynamic>.from(staticBanner.map((x) => x.toJson())),
  };
}

class Banner {
  Banner({
    this.imageUrl,
    this.actionType,
    this.actionId,
    this.displayStatus,
    this.bannerImg,
  });

  String imageUrl;
  String actionType;
  String actionId;
  String displayStatus;
  String bannerImg;

  factory Banner.fromJson(Map<String, dynamic> json) => Banner(
    imageUrl: json["image_url"] == null ? null : json["image_url"],
    actionType: json["action_type"],
    actionId: json["action_id"],
    displayStatus: json["display_status"],
    bannerImg: json["banner_img"] == null ? null : json["banner_img"],
  );

  Map<String, dynamic> toJson() => {
    "image_url": imageUrl == null ? null : imageUrl,
    "action_type": actionType,
    "action_id": actionId,
    "display_status": displayStatus,
    "banner_img": bannerImg == null ? null : bannerImg,
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
    this.wishlistStatus,
    this.productexistInCart,
    this.count,
  });

  String itemdetId;
  String productName;
  String productImage;
  String price;
  int discountedPrice;
  int count;
  DiscountAvailable discountAvailable;
  String stockStatus;
  bool wishlistStatus;
  bool productexistInCart;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    itemdetId: json["itemdet_id"],
    productName: json["product_name"],
    productImage: json["product_image"],
    price: json["price"],
    discountedPrice: json["discounted_price"],
    discountAvailable: discountAvailableValues.map[json["discount_available"]],
    stockStatus: json["stock_status"],
    wishlistStatus: json["wishlist_status"],
    productexistInCart: json["productexist_in_cart"],
    count: json["prodqty"].toString() == '0' ? 1 : int.parse(json["prodqty"].toString()),
  );

  Map<String, dynamic> toJson() => {
    "itemdet_id": itemdetId,
    "product_name": productName,
    "product_image": productImage,
    "price": price,
    "discounted_price": discountedPrice,
    "discount_available": discountAvailableValues.reverse[discountAvailable],
    "stock_status": stockStatus,
    "wishlist_status": wishlistStatus,
    "productexist_in_cart": productexistInCart,
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
