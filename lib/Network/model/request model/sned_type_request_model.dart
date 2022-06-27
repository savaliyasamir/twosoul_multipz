

// To parse this JSON data, do
//
//     final typeRequestModel = typeRequestModelFromJson(jsonString);

import 'dart:convert';

AddRewindRequestModel sendTypeRequestModelFromJson(String str) => AddRewindRequestModel.fromJson(json.decode(str));

String sendTypeRequestModelToJson(AddRewindRequestModel data) => json.encode(data.toJson());

class AddRewindRequestModel {
  AddRewindRequestModel({
    this.receiver_id,
  });

  int? receiver_id;

  factory AddRewindRequestModel.fromJson(Map<String, dynamic> json) => AddRewindRequestModel(
    receiver_id: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "type": receiver_id,
  };
}
