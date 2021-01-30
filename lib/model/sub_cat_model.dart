// To parse this JSON data, do
//
//     final subCatModel = subCatModelFromJson(jsonString);

import 'dart:convert';

SubCatModel subCatModelFromJson(String str) => SubCatModel.fromJson(json.decode(str));

String subCatModelToJson(SubCatModel data) => json.encode(data.toJson());

class SubCatModel {
  SubCatModel({
    this.categories,
  });

  List<Category> categories;

  factory SubCatModel.fromJson(Map<String, dynamic> json) => SubCatModel(
    categories: List<Category>.from(json["categories"].map((x) => Category.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
  };
}

class Category {
  Category({
    this.subcatId,
    this.subcategoryName,
    this.subcategoryImage,
  });

  String subcatId;
  String subcategoryName;
  String subcategoryImage;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    subcatId: json["subcat_id"],
    subcategoryName: json["subcategory_name"],
    subcategoryImage: json["subcategory_image"],
  );

  Map<String, dynamic> toJson() => {
    "subcat_id": subcatId,
    "subcategory_name": subcategoryName,
    "subcategory_image": subcategoryImage,
  };
}
