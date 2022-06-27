

// To parse this JSON data, do
//
//     final cOntactUsResponseModel = cOntactUsResponseModelFromJson(jsonString);

import 'dart:convert';

ContactUsResponseModel contactUsResponseModelFromJson(String str) => ContactUsResponseModel.fromJson(json.decode(str));

String contactUsResponseModelToJson(ContactUsResponseModel data) => json.encode(data.toJson());

class ContactUsResponseModel {
  ContactUsResponseModel({
    this.data,
    this.message,
  });

  Data? data;
  String? message;

  factory ContactUsResponseModel.fromJson(Map<String, dynamic> json) => ContactUsResponseModel(
    data: Data.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": data!.toJson(),
    "message": message,
  };
}

class Data {
  Data({
    this.id,
    this.name,
    this.email,
    this.mobileCode,
    this.mobile,
    this.message,
    this.image,
    this.type,
  });

  int? id;
  String? name;
  String? email;
  String? mobileCode;
  String? mobile;
  String? message;
  String? image;
  String? type;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    mobileCode: json["mobile_code"],
    mobile: json["mobile"],
    message: json["message"],
    image: json["image"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "mobile_code": mobileCode,
    "mobile": mobile,
    "message": message,
    "image": image,
    "type": type,
  };
}
