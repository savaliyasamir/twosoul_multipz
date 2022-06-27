
// To parse this JSON data, do
//
//     final contactUsRequestModel = contactUsRequestModelFromJson(jsonString);

import 'dart:convert';

ContactUsRequestModel contactUsRequestModelFromJson(String str) => ContactUsRequestModel.fromJson(json.decode(str));

String contactUsRequestModelToJson(ContactUsRequestModel data) => json.encode(data.toJson());

class ContactUsRequestModel {
  ContactUsRequestModel({
    this.name,
    this.email,
    this.mobileCode,
    this.mobile,
    this.message,
    this.type,
  });

  String? name;
  String? email;
  String? mobileCode;
  int? mobile;
  String? message;
  int? type;

  factory ContactUsRequestModel.fromJson(Map<String, dynamic> json) => ContactUsRequestModel(
    name: json["name"],
    email: json["email"],
    mobileCode: json["mobile_code"],
    mobile: json["mobile"],
    message: json["message"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "mobile_code": mobileCode,
    "mobile": mobile,
    "message": message,
    "type": type,
  };
}
