

// To parse this JSON data, do
//
//     final receiveMatchRequestModel = receiveMatchRequestModelFromJson(jsonString);

import 'dart:convert';

ReceiveMatchRequestModel receiveMatchRequestModelFromJson(String str) => ReceiveMatchRequestModel.fromJson(json.decode(str));

String receiveMatchRequestModelToJson(ReceiveMatchRequestModel data) => json.encode(data.toJson());

class ReceiveMatchRequestModel {
  ReceiveMatchRequestModel({
    this.type,
  });

  int? type;

  factory ReceiveMatchRequestModel.fromJson(Map<String, dynamic> json) => ReceiveMatchRequestModel(
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
  };
}
