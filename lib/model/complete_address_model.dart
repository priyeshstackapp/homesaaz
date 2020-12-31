import 'dart:convert';

CompleteAddressModel completeAddressModelFromJson(String str) => CompleteAddressModel.fromJson(json.decode(str));

String completeAddressModelToJson(CompleteAddressModel data) => json.encode(data.toJson());

class CompleteAddressModel {
  CompleteAddressModel({
    this.address,
    this.flat,
    this.landmark,
    this.city,
    this.state,
    this.pincode,
    this.mobile,
    this.status,
  });

  String address;
  String flat;
  String landmark;
  String city;
  String state;
  String pincode;
  String mobile;
  String status;

  factory CompleteAddressModel.fromJson(Map<String, dynamic> json) => CompleteAddressModel(
    address: json["address"],
    flat: json["flat"],
    landmark: json["landmark"],
    city: json["city"],
    state: json["state"],
    pincode: json["pincode"],
    mobile: json["mobile"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "address": address,
    "flat": flat,
    "landmark": landmark,
    "city": city,
    "state": state,
    "pincode": pincode,
    "mobile": mobile,
    "status": status,
  };
}
