// To parse this JSON data, do
//
//     final getCityResponseModel = getCityResponseModelFromJson(jsonString);

import 'dart:convert';

import 'common_model/city_data.dart';

GetCityResponseModel getCityResponseModelFromJson(String str) => GetCityResponseModel.fromJson(json.decode(str));

String getCityResponseModelToJson(GetCityResponseModel data) => json.encode(data.toJson());

class GetCityResponseModel {
  GetCityResponseModel({
    this.data,
    this.message,
  });

  List<CityData>? data;
  String? message;

  factory GetCityResponseModel.fromJson(Map<String, dynamic> json) => GetCityResponseModel(
    data: List<CityData>.from(json["data"].map((x) => CityData.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    "message": message,
  };
}

