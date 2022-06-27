



// To parse this JSON data, do
//
//     final editProfileRequestModel = editProfileRequestModelFromJson(jsonString);

import 'dart:convert';

EditProfileRequestModel editProfileRequestModelFromJson(String str) => EditProfileRequestModel.fromJson(json.decode(str));

String editProfileRequestModelToJson(EditProfileRequestModel data) => json.encode(data.toJson());

class EditProfileRequestModel {
  EditProfileRequestModel({
    this.name,
    this.height,
    this.relaitonshipStatus,
    this.sexualityId,
    this.lookingFor,
    this.designation,
    this.about,
  });

  String? name;
  int? height;
  String? relaitonshipStatus;
  int? sexualityId;
  int? lookingFor;
  String? designation;
  String? about;

  factory EditProfileRequestModel.fromJson(Map<String, dynamic> json) => EditProfileRequestModel(
    name: json["name"],
    height: json["height"],
    relaitonshipStatus: json["relaitonship_status"],
    sexualityId: json["sexuality_id"],
    lookingFor: json["looking_for"],
    designation: json["designation"],
    about: json["about"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "height": height,
    "relaitonship_status": relaitonshipStatus,
    "sexuality_id": sexualityId,
    "looking_for": lookingFor,
    "designation": designation,
    "about": about,
  };
}
