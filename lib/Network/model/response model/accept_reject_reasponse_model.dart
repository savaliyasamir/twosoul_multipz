


// To parse this JSON data, do
//
//     final acceptRejectResponseModel = acceptRejectResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:twosoul_multipz/Network/model/response%20model/common_model/user_data_model.dart';

AcceptRejectResponseModel acceptRejectResponseModelFromJson(String str) => AcceptRejectResponseModel.fromJson(json.decode(str));

String acceptRejectResponseModelToJson(AcceptRejectResponseModel data) => json.encode(data.toJson());

class AcceptRejectResponseModel {
  AcceptRejectResponseModel({
    this.data,
    this.message,
  });

  AcceptRejectData? data;
  String? message;

  factory AcceptRejectResponseModel.fromJson(Map<String, dynamic> json) => AcceptRejectResponseModel(
    data: AcceptRejectData.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": data!.toJson(),
    "message": message,
  };
}

class AcceptRejectData {
  AcceptRejectData({
    this.id,
    this.sender,
    this.type,
  });

  int? id;
  UserData? sender;
  String? type;

  factory AcceptRejectData.fromJson(Map<String, dynamic> json) => AcceptRejectData(
    id: json["id"],
    sender: UserData.fromJson(json["sender"]),
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "sender": sender!.toJson(),
    "type": type,
  };
}


