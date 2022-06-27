


// To parse this JSON data, do
//
//     final sendMatchFrienedRequestModel = sendMatchFrienedRequestModelFromJson(jsonString);

import 'dart:convert';

SendMatchFriendRequestModel sendMatchFriendRequestModelFromJson(String str) => SendMatchFriendRequestModel.fromJson(json.decode(str));

String sendMatchFriendRequestModelToJson(SendMatchFriendRequestModel data) => json.encode(data.toJson());

class SendMatchFriendRequestModel {
  SendMatchFriendRequestModel({
    this.receiverId,
    this.type,
  });

  int? receiverId;
  int? type;

  factory SendMatchFriendRequestModel.fromJson(Map<String, dynamic> json) => SendMatchFriendRequestModel(
    receiverId: json["receiver_id"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "receiver_id": receiverId,
    "type": type,
  };
}
