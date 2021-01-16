import 'dart:convert';

AddressModel addressModelFromJson(String str) => AddressModel.fromJson(json.decode(str));

String addressModelToJson(AddressModel data) => json.encode(data.toJson());

class AddressModel {
  AddressModel({
    this.data,
    this.status,
  });

  List<AddressData> data;
  String status;

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
    data: List<AddressData>.from(json["data"].map((x) => AddressData.fromJson(x))),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "status": status,
  };
}

class AddressData {
  AddressData({
    this.addressId,
    this.addressTitle,
    this.address,
    this.mobile,
  });

  String addressId;
  String addressTitle;
  String address;
  String mobile;

  factory AddressData.fromJson(Map<String, dynamic> json) => AddressData(
    addressId: json["address_id"],
    addressTitle: json["address_title"],
    address: json["address"],
    mobile: json["mobile"],
  );

  Map<String, dynamic> toJson() => {
    "address_id": addressId,
    "address_title": addressTitle,
    "address": address,
    "mobile": mobile,
  };
}
