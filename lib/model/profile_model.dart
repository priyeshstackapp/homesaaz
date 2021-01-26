import 'dart:convert';

ProfileModel profileModelFromJson(String str) => ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  ProfileModel({
    this.firstName,
    this.lastName,
    this.gender,
    this.email,
    this.mobile,
    this.profileImgName,
    this.profileImg,
    this.status,
  });

  String firstName;
  String lastName;
  String gender;
  String email;
  String mobile;
  String profileImgName;
  String profileImg;
  String status;

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
    firstName: json["first_name"],
    lastName: json["last_name"],
    gender: json["gender"],
    email: json["email"],
    mobile: json["mobile"],
    profileImgName: json["profile_img_name"],
    profileImg: json["profile_img"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "first_name": firstName,
    "last_name": lastName,
    "gender": gender,
    "email": email,
    "mobile": mobile,
    "profile_img_name": profileImgName,
    "profile_img": profileImg,
  };
}