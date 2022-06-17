
// To parse this JSON data, do
//
//     final loginRequestModel = loginRequestModelFromJson(jsonString);

import 'dart:convert';

LoginRequestModel loginRequestModelFromJson(String str) => LoginRequestModel.fromJson(json.decode(str));

String loginRequestModelToJson(LoginRequestModel data) => json.encode(data.toJson());

class LoginRequestModel {
  LoginRequestModel({
    this.loginType,
    this.socialId,
  });

  String? loginType;
  String? socialId;

  factory LoginRequestModel.fromJson(Map<String, dynamic> json) => LoginRequestModel(
    loginType: json["login_type"],
    socialId: json["social_id"],
  );

  Map<String, dynamic> toJson() => {
    "login_type": loginType,
    "social_id": socialId,
  };
}
