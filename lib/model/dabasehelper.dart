class DatabaseHelper {
  String address;
  String city;
  String postalCode;
  String houseNo;
  String roadNo;

  DatabaseHelper(
      {this.address, this.city, this.postalCode, this.houseNo, this.roadNo});

  DatabaseHelper.fromJson(Map<String, dynamic> json) {
    address = json['address']==null ? null :json['address'];
    city = json['city']==null ? null :json['city'];
    postalCode = json['postalCode']==null ? null :json['postalCode'];
    houseNo = json['houseNo']==null ? null :json['houseNo'];
    roadNo = json['roadNo']==null ? null :json['roadNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['city'] = this.city;
    data['postalCode'] = this.postalCode;
    data['houseNo'] = this.houseNo;
    data['roadNo'] = this.roadNo;

    return data;
  }
}
