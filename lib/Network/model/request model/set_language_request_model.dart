

// To parse this JSON data, do
//
//     final setLanguageRequestModel = setLanguageRequestModelFromJson(jsonString);

import 'dart:convert';

SetLanguageRequestModel setLanguageRequestModelFromJson(String str) => SetLanguageRequestModel.fromJson(json.decode(str));

String setLanguageRequestModelToJson(SetLanguageRequestModel data) => json.encode(data.toJson());

class SetLanguageRequestModel {
  SetLanguageRequestModel({
    this.code,
  });

  String? code;

  factory SetLanguageRequestModel.fromJson(Map<String, dynamic> json) => SetLanguageRequestModel(
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
  };
}
