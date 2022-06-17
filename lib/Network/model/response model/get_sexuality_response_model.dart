

// To parse this JSON data, do
//
//     final getSexualityResponseModel = getSexualityResponseModelFromJson(jsonString);

import 'dart:convert';



GetSexualityResponseModel getSexualityResponseModelFromJson(String str) => GetSexualityResponseModel.fromJson(json.decode(str));

String getSexualityResponseModelToJson(GetSexualityResponseModel data) => json.encode(data.toJson());

class GetSexualityResponseModel {
  GetSexualityResponseModel({
    this.data,
    this.message,
  });

  List<SexualityData>? data;
  String? message;

  factory GetSexualityResponseModel.fromJson(Map<String, dynamic> json) => GetSexualityResponseModel(
    data: List<SexualityData>.from(json["data"].map((x) => SexualityData.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    "message": message,
  };
}

class SexualityData {
  SexualityData({
    this.id,
    this.name,
    this.status,
  });

  int? id;
  String? name;
  String? status;

  factory SexualityData.fromJson(Map<String, dynamic> json) => SexualityData(
    id: json["id"],
    name: json["name"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "status": status,
  };
}