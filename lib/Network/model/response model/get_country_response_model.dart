

// To parse this JSON data, do
//
//     final getCountryResponseModel = getCountryResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:twosoul_multipz/Network/model/response%20model/common_model/country_data.dart';

GetCountryResponseModel getCountryResponseModelFromJson(String str) => GetCountryResponseModel.fromJson(json.decode(str));

String getCountryResponseModelToJson(GetCountryResponseModel data) => json.encode(data.toJson());

class GetCountryResponseModel {
  GetCountryResponseModel({
    this.data,
    this.message,
  });

  List<CountryData>? data;
  String? message;

  factory GetCountryResponseModel.fromJson(Map<String, dynamic> json) => GetCountryResponseModel(
    data: List<CountryData>.from(json["data"].map((x) => CountryData.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    "message": message,
  };
}
