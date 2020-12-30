import 'dart:convert';

AddressModel addressModelFromJson(String str) => AddressModel.fromJson(json.decode(str));

String addressModelToJson(AddressModel data) => json.encode(data.toJson());

class AddressModel {
  AddressModel({
    this.data,
    this.status,
  });

  List<Datum> data;
  String status;

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
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
    this.addressId,
    this.addressTitle,
    this.address,
    this.mobile,
  });

  String addressId;
  String addressTitle;
  String address;
  String mobile;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
