
// To parse this JSON data, do
//
//     final addRewindModel = addRewindModelFromJson(jsonString);

import 'dart:convert';

AddRewindResponseModel addRewindModelFromJson(String str) => AddRewindResponseModel.fromJson(json.decode(str));

String addRewindModelToJson(AddRewindResponseModel data) => json.encode(data.toJson());

class AddRewindResponseModel {
  AddRewindResponseModel({
    this.data,
    this.message,
  });

  List<dynamic>? data;
  String? message;

  factory AddRewindResponseModel.fromJson(Map<String, dynamic> json) => AddRewindResponseModel(
    data: List<dynamic>.from(json["data"].map((x) => x)),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data!.map((x) => x)),
    "message": message,
  };
}
