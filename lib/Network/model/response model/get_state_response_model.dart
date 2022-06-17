
// To parse this JSON data, do
//
//     final getStateResponseModel = getStateResponseModelFromJson(jsonString);

import 'dart:convert';

import 'common_model/state_data.dart';

GetStateResponseModel getStateResponseModelFromJson(String str) => GetStateResponseModel.fromJson(json.decode(str));

String getStateResponseModelToJson(GetStateResponseModel data) => json.encode(data.toJson());

class GetStateResponseModel {
  GetStateResponseModel({
    this.data,
    this.message,
  });

  List<StateData>? data;
  String? message;

  factory GetStateResponseModel.fromJson(Map<String, dynamic> json) => GetStateResponseModel(
    data: List<StateData>.from(json["data"].map((x) => StateData.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    "message": message,
  };
}
