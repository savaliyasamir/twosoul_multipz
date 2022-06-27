

// To parse this JSON data, do
//
//     final userMultiImageRequestModel = userMultiImageRequestModelFromJson(jsonString);

import 'dart:convert';

UserMultiImageRequestModel userMultiImageRequestModelFromJson(String str) => UserMultiImageRequestModel.fromJson(json.decode(str));

String userMultiImageRequestModelToJson(UserMultiImageRequestModel data) => json.encode(data.toJson());

class UserMultiImageRequestModel {
  UserMultiImageRequestModel({
    this.image,
  });

  List<dynamic>? image;

  factory UserMultiImageRequestModel.fromJson(Map<String, dynamic> json) => UserMultiImageRequestModel(
    image: List<dynamic>.from(json["image"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "image": List<dynamic>.from(image!.map((x) => x)),
  };
}
