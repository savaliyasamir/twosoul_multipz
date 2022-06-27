

// To parse this JSON data, do
//
//     final sendMatchFrienedResponseModel = sendMatchFrienedResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:twosoul_multipz/Network/model/response%20model/common_model/user_data_model.dart';

SendMatchFriendResponseModel sendMatchFriendResponseModelFromJson(String str) => SendMatchFriendResponseModel.fromJson(json.decode(str));

String sendMatchFriendResponseModelToJson(SendMatchFriendResponseModel data) => json.encode(data.toJson());

class SendMatchFriendResponseModel {
  SendMatchFriendResponseModel({
    this.data,
    this.message,
  });

  SendData? data;
  String? message;

  factory SendMatchFriendResponseModel.fromJson(Map<String, dynamic> json) => SendMatchFriendResponseModel(
    data: SendData.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
    "message": message,
  };
}

class SendData {
  SendData({
    this.id,
    this.receiver,
    this.sender,
    this.type,
    this.status,
  });

  int? id;
  UserData? receiver;
  UserData? sender;
  String? type;
  String? status;

  factory SendData.fromJson(Map<String, dynamic> json) => SendData(
    id: json["id"],
    receiver: UserData.fromJson(json["receiver"]),
    sender: UserData.fromJson(json["sender"]),
    type: json["type"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "receiver": receiver!.toJson(),
    "sender": sender!.toJson(),
    "type": type,
    "status": status,
  };
}


