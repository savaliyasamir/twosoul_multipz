
// To parse this JSON data, do
//
//     final createProfileRequestModel = createProfileRequestModelFromJson(jsonString);

import 'dart:convert';

CreateProfileRequestModel createProfileRequestModelFromJson(String str) => CreateProfileRequestModel.fromJson(json.decode(str));

String createProfileRequestModelToJson(CreateProfileRequestModel data) => json.encode(data.toJson());

class CreateProfileRequestModel {
  CreateProfileRequestModel({
    this.name,
    this.gender,
    this.sexualityId,
    this.dob,
    this.height,
    this.relaitonshipStatus,
    this.religionId,
    this.lookingFor,
    this.countryId,
    this.stateId,
    this.cityId,
    this.latitude,
    this.longitude,
  });

  String? name;
  String? gender;
  int? sexualityId;
  String? dob;
  int? height;
  String? relaitonshipStatus;
  int? religionId;
  int? lookingFor;
  int? countryId;
  int? stateId;
  int? cityId;
  double? latitude;
  double? longitude;

  factory CreateProfileRequestModel.fromJson(Map<String, dynamic> json) => CreateProfileRequestModel(
    name: json["name"],
    gender: json["gender"],
    sexualityId: json["sexuality_id"],
    dob: json["dob"],
    height: json["height"],
    relaitonshipStatus: json["relaitonship_status"],
    religionId: json["religion_id"],
    lookingFor: json["looking_for"],
    countryId: json["country_id"],
    stateId: json["state_id"],
    cityId: json["city_id"],
    latitude: json["latitude"],
    longitude: json["longitude"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "gender": gender,
    "sexuality_id": sexualityId,
    "dob": dob,
    "height": height,
    "relaitonship_status": relaitonshipStatus,
    "religion_id": religionId,
    "looking_for": lookingFor,
    "country_id": countryId,
    "state_id": stateId,
    "city_id": cityId,
    "latitude": latitude,
    "longitude": longitude,
  };
}
