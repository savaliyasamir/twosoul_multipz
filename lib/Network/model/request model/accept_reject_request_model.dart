

// To parse this JSON data, do
//
//     final acceptRejectRequestModel = acceptRejectRequestModelFromJson(jsonString);

import 'dart:convert';

AcceptRejectRequestModel acceptRejectRequestModelFromJson(String str) => AcceptRejectRequestModel.fromJson(json.decode(str));

String acceptRejectRequestModelToJson(AcceptRejectRequestModel data) => json.encode(data.toJson());

class AcceptRejectRequestModel {
  AcceptRejectRequestModel({
    this.senderId,
    this.flag,
  });

  int? senderId;
  int? flag;

  factory AcceptRejectRequestModel.fromJson(Map<String, dynamic> json) => AcceptRejectRequestModel(
    senderId: json["sender_id"],
    flag: json["flag"],
  );

  Map<String, dynamic> toJson() => {
    "sender_id": senderId,
    "flag": flag,
  };
}
