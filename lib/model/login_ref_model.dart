class LoginResponseModel {
  String uid;
  String mobile;
  String email;
  String name;
  String status;

  LoginResponseModel(
      {this.uid, this.mobile, this.email, this.name, this.status});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    mobile = json['mobile'];
    email = json['email'];
    name = json['name'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['mobile'] = this.mobile;
    data['email'] = this.email;
    data['name'] = this.name;
    data['status'] = this.status;
    return data;
  }
}
