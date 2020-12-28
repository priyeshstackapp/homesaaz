import 'dart:convert';

LoginPageModel loginPageModelFromJson(String str) => LoginPageModel.fromJson(json.decode(str));

String loginPageModelToJson(LoginPageModel data) => json.encode(data.toJson());

class LoginPageModel {
  LoginPageModel({
    this.uid,
    this.mobile,
    this.email,
    this.name,
    this.status,
  });

  String uid;
  String mobile;
  String email;
  String name;
  String status;

  factory LoginPageModel.fromJson(Map<String, dynamic> json) => LoginPageModel(
    uid: json["uid"],
    mobile: json["mobile"],
    email: json["email"],
    name: json["name"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "uid": uid,
    "mobile": mobile,
    "email": email,
    "name": name,
    "status": status,
  };
}
