import 'dart:convert';

EditAddressModel editAddressModelFromJson(String str) => EditAddressModel.fromJson(json.decode(str));

String editAddressModelToJson(EditAddressModel data) => json.encode(data.toJson());

class EditAddressModel {
  EditAddressModel({
    this.isnew,
    this.addresscount,
    this.addressdata,
    this.status,
  });

  int isnew;
  String addresscount;
  Addressdata addressdata;
  String status;

  factory EditAddressModel.fromJson(Map<String, dynamic> json) => EditAddressModel(
    isnew: json["isnew"],
    addresscount: json["addresscount"],
    addressdata: Addressdata.fromJson(json["addressdata"]),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "isnew": isnew,
    "addresscount": addresscount,
    "addressdata": addressdata.toJson(),
    "status": status,
  };
}

class Addressdata {
  Addressdata({
    this.address,
    this.flat,
    this.landmark,
    this.city,
    this.state,
    this.pincode,
    this.mobile,
    this.locName,
    this.addrId,
  });

  String address;
  String flat;
  String landmark;
  String city;
  String state;
  String pincode;
  String mobile;
  String locName;
  String addrId;

  factory Addressdata.fromJson(Map<String, dynamic> json) => Addressdata(
    address: json["address"],
    flat: json["flat"],
    landmark: json["landmark"],
    city: json["city"],
    state: json["state"],
    pincode: json["pincode"],
    mobile: json["mobile"],
    locName: json["loc_name"],
    addrId: json["addr_id"],
  );

  Map<String, dynamic> toJson() => {
    "address": address,
    "flat": flat,
    "landmark": landmark,
    "city": city,
    "state": state,
    "pincode": pincode,
    "mobile": mobile,
    "loc_name": locName,
    "addr_id": addrId,
  };
}
