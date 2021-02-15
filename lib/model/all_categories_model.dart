// To parse this JSON data, do
//
//     final allCategoriesModel = allCategoriesModelFromJson(jsonString);

import 'dart:convert';

AllCategoriesModel allCategoriesModelFromJson(String str) => AllCategoriesModel.fromJson(json.decode(str));

String allCategoriesModelToJson(AllCategoriesModel data) => json.encode(data.toJson());

class AllCategoriesModel {
  AllCategoriesModel({
    this.categories,
  });

  List<Category> categories;

  factory AllCategoriesModel.fromJson(Map<String, dynamic> json) => AllCategoriesModel(
    categories: List<Category>.from(json["categories"].map((x) => Category.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
  };
}

class Category {
  Category({
    this.catId,
    this.categoryName,
    this.categoryImage,
    this.categoryIcon,
  });

  String catId;
  String categoryName;
  String categoryImage;
  String categoryIcon;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    catId: json["cat_id"],
    categoryName: json["category_name"],
    categoryImage: json["category_image"],
    categoryIcon: json["category_icon"],
  );

  Map<String, dynamic> toJson() => {
    "cat_id": catId,
    "category_name": categoryName,
    "category_image": categoryImage,
    "category_icon": categoryIcon,
  };
}
