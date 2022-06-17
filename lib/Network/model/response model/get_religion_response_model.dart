



// To parse this JSON data, do
//
//     final getReligionResponseModel = getReligionResponseModelFromJson(jsonString);

import 'dart:convert';

import 'common_model/religion_data.dart';

GetReligionResponseModel getReligionResponseModelFromJson(String str) => GetReligionResponseModel.fromJson(json.decode(str));

String getReligionResponseModelToJson(GetReligionResponseModel data) => json.encode(data.toJson());

class GetReligionResponseModel {
  GetReligionResponseModel({
    this.data,
    this.message,
  });

  List<ReligionData>? data;
  String? message;

  factory GetReligionResponseModel.fromJson(Map<String, dynamic> json) => GetReligionResponseModel(
    data: List<ReligionData>.from(json["data"].map((x) => ReligionData.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    "message": message,
  };
}

