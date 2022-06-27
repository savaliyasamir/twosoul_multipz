// To parse this JSON data, do
//
//     final loginResponseModel = loginResponseModelFromJson(jsonString);

import 'dart:convert';


import 'package:twosoul_multipz/Network/model/response%20model/common_model/user_data_model.dart';

LoginResponseModel loginResponseModelFromJson(String str) => LoginResponseModel.fromJson(json.decode(str));

String loginResponseModelToJson(LoginResponseModel data) => json.encode(data.toJson());

class LoginResponseModel {
  LoginResponseModel({
    this.data,
    this.message,
    this.token,
  });

  UserData? data;
  String? message;
  String? token;

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) => LoginResponseModel(
    data: UserData.fromJson(json["data"]),
    message: json["message"],
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "data": data!.toJson(),
    "message": message,
    "token": token,
  };
}

