import 'dart:convert';

SearchModel searchModelFromJson(String str) => SearchModel.fromJson(json.decode(str));

String searchModelToJson(SearchModel data) => json.encode(data.toJson());

class SearchModel {
  SearchModel({
    this.searchItem,
    this.status,
  });

  List<SearchItem> searchItem;
  String status;

  factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
    searchItem: List<SearchItem>.from(json["data"].map((x) => SearchItem.fromJson(x))),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(searchItem.map((x) => x.toJson())),
    "status": status,
  };
}

class SearchItem {
  SearchItem({
    this.itemdetId,
    this.productName,
    this.categoryName,
  });

  String itemdetId;
  String productName;
  String categoryName;

  factory SearchItem.fromJson(Map<String, dynamic> json) => SearchItem(
    itemdetId: json["itemdet_id"],
    productName: json["product_name"],
    categoryName: json["category_name"],
  );

  Map<String, dynamic> toJson() => {
    "itemdet_id": itemdetId,
    "product_name": productName,
    "category_name": categoryName,
  };
}