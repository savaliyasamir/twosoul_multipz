

// To parse this JSON data, do
//
//     final createProfileResponseModel = createProfileResponseModelFromJson(jsonString);

import 'dart:convert';
import 'common_model/user_data_model.dart';

CreateProfileResponseModel createProfileResponseModelFromJson(String str) => CreateProfileResponseModel.fromJson(json.decode(str));

String createProfileResponseModelToJson(CreateProfileResponseModel data) => json.encode(data.toJson());

class CreateProfileResponseModel {
  CreateProfileResponseModel({
    this.data,
    this.message,
  });

  UserData? data;
  String? message;

  factory CreateProfileResponseModel.fromJson(Map<String, dynamic> json) => CreateProfileResponseModel(
    data: UserData.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": data!.toJson(),
    "message": message,
  };
}









