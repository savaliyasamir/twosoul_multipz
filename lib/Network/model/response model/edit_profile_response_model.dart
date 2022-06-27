

// To parse this JSON data, do
//
//     final editProfileResponseModel = editProfileResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:twosoul_multipz/Network/model/response%20model/common_model/user_data_model.dart';

EditProfileResponseModel editProfileResponseModelFromJson(String str) => EditProfileResponseModel.fromJson(json.decode(str));

String editProfileResponseModelToJson(EditProfileResponseModel data) => json.encode(data.toJson());

class EditProfileResponseModel {
  EditProfileResponseModel({
    this.data,
    this.message,
  });

  UserData? data;
  String? message;

  factory EditProfileResponseModel.fromJson(Map<String, dynamic> json) => EditProfileResponseModel(
    data: UserData.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": data!.toJson(),
    "message": message,
  };
}

