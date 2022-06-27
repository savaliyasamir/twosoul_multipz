

// To parse this JSON data, do
//
//     final createProfileResponseModel = createProfileResponseModelFromJson(jsonString);

import 'dart:convert';
import 'package:twosoul_multipz/Network/model/response%20model/common_model/firebase_Response_Model.dart';

import 'common_model/user_data_model.dart';

CreateProfileResponseModel createProfileResponseModelFromJson(String str) => CreateProfileResponseModel.fromJson(json.decode(str));

String createProfileResponseModelToJson(CreateProfileResponseModel data) => json.encode(data.toJson());

class CreateProfileResponseModel {
  CreateProfileResponseModel({
    this.data,
    this.message,
  });

  FirebaseUserModel? data;
  String? message;

  factory CreateProfileResponseModel.fromJson(Map<String, dynamic> json) => CreateProfileResponseModel(
    data: FirebaseUserModel.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": data!.toJson(),
    "message": message,
  };
}









