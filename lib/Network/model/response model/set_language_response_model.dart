
// To parse this JSON data, do
//
//     final setLanguageResponseModel = setLanguageResponseModelFromJson(jsonString);

import 'dart:convert';

SetLanguageResponseModel setLanguageResponseModelFromJson(String str) => SetLanguageResponseModel.fromJson(json.decode(str));

String setLanguageResponseModelToJson(SetLanguageResponseModel data) => json.encode(data.toJson());

class SetLanguageResponseModel {
  SetLanguageResponseModel({
    this.data,
    this.message,
  });

  List<dynamic>? data;
  String? message;

  factory SetLanguageResponseModel.fromJson(Map<String, dynamic> json) => SetLanguageResponseModel(
    data: List<dynamic>.from(json["data"].map((x) => x)),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data!.map((x) => x)),
    "message": message,
  };
}
