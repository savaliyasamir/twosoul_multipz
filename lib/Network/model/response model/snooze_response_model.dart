

// To parse this JSON data, do
//
//     final snoozeResponseModel = snoozeResponseModelFromJson(jsonString);

import 'dart:convert';

SnoozeResponseModel snoozeResponseModelFromJson(String str) => SnoozeResponseModel.fromJson(json.decode(str));

String snoozeResponseModelToJson(SnoozeResponseModel data) => json.encode(data.toJson());

class SnoozeResponseModel {
  SnoozeResponseModel({
    this.data,
    this.message,
  });

  List<dynamic>? data;
  String? message;

  factory SnoozeResponseModel.fromJson(Map<String, dynamic> json) => SnoozeResponseModel(
    data: List<dynamic>.from(json["data"].map((x) => x)),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data!.map((x) => x)),
    "message": message,
  };
}
