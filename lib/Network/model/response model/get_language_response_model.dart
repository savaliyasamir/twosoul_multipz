// To parse this JSON data, do
//
//     final getLanguageResponseModel = getLanguageResponseModelFromJson(jsonString);

import 'dart:convert';

GetLanguageResponseModel getLanguageResponseModelFromJson(String str) => GetLanguageResponseModel.fromJson(json.decode(str));

String getLanguageResponseModelToJson(GetLanguageResponseModel data) => json.encode(data.toJson());

class GetLanguageResponseModel {
  GetLanguageResponseModel({
    this.data,
    this.message,
  });

  List<GetLanguage>? data;
  String? message;

  factory GetLanguageResponseModel.fromJson(Map<String, dynamic> json) => GetLanguageResponseModel(
    data: List<GetLanguage>.from(json["data"].map((x) => GetLanguage.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    "message": message,
  };
}

class GetLanguage {
  GetLanguage({
    this.id,
    this.name,
    this.code,
    this.active,
  });

  int? id;
  String? name;
  String? code;
  String? active;

  factory GetLanguage.fromJson(Map<String, dynamic> json) => GetLanguage(
    id: json["id"],
    name: json["name"],
    code: json["code"],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "code": code,
    "active": active,
  };
}
