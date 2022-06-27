

// To parse this JSON data, do
//
//     final userMultiImageResponseModel = userMultiImageResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:twosoul_multipz/Network/model/response%20model/common_model/user_data_model.dart';

UserMultiImageResponseModel userMultiImageResponseModelFromJson(String str) => UserMultiImageResponseModel.fromJson(json.decode(str));

String userMultiImageResponseModelToJson(UserMultiImageResponseModel data) => json.encode(data.toJson());

class UserMultiImageResponseModel {
  UserMultiImageResponseModel({
    this.data,
    this.message,
  });

  UserData? data;
  String? message;

  factory UserMultiImageResponseModel.fromJson(Map<String, dynamic> json) => UserMultiImageResponseModel(
    data: UserData.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": data!.toJson(),
    "message": message,
  };
}

