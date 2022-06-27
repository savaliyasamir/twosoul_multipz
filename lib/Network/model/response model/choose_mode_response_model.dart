
// To parse this JSON data, do
//
//     final chooseModeResponseModel = chooseModeResponseModelFromJson(jsonString);

import 'dart:convert';

ChooseModeResponseModel chooseModeResponseModelFromJson(String str) => ChooseModeResponseModel.fromJson(json.decode(str));

String chooseModeResponseModelToJson(ChooseModeResponseModel data) => json.encode(data.toJson());

class ChooseModeResponseModel {
  ChooseModeResponseModel({
    this.data,
    this.message,
  });

  List<dynamic>? data;
  String? message;

  factory ChooseModeResponseModel.fromJson(Map<String, dynamic> json) => ChooseModeResponseModel(
    data: List<dynamic>.from(json["data"].map((x) => x)),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data!.map((x) => x)),
    "message": message,
  };
}
