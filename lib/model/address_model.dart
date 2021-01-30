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

FullAddressModel fullAddressModelFromJson(String str) => FullAddressModel.fromJson(json.decode(str));

String fullAddressModelToJson(FullAddressModel data) => json.encode(data.toJson());

class FullAddressModel {
  FullAddressModel({
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

  factory FullAddressModel.fromJson(Map<String, dynamic> json) => FullAddressModel(
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