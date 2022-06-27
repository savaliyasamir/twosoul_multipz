

// To parse this JSON data, do
//
//     final filterDataRequestModel = filterDataRequestModelFromJson(jsonString);

import 'dart:convert';

FilterDataRequestModel filterDataRequestModelFromJson(String str) => FilterDataRequestModel.fromJson(json.decode(str));

String filterDataRequestModelToJson(FilterDataRequestModel data) => json.encode(data.toJson());

class FilterDataRequestModel {
  FilterDataRequestModel({
    this.interestedIn,
    this.ageStart,
    this.ageEnd,
    this.heightStart,
    this.heightEnd,
    this.distance,
    this.sexualityId,
    this.religionId,
    this.lookingFor,
  });

  String? interestedIn;
  int? ageStart;
  int? ageEnd;
  int? heightStart;
  int? heightEnd;
  int? distance;
  int? sexualityId;
  int? religionId;
  int? lookingFor;

  factory FilterDataRequestModel.fromJson(Map<String, dynamic> json) => FilterDataRequestModel(
    interestedIn: json["interested_in"],
    ageStart: json["age_start"],
    ageEnd: json["age_end"],
    heightStart: json["height_start"],
    heightEnd: json["height_end"],
    distance: json["distance"],
    sexualityId: json["sexuality_id"],
    religionId: json["religion_id"],
    lookingFor: json["looking_for"],
  );

  Map<String, dynamic> toJson() => {
    "interested_in": interestedIn,
    "age_start": ageStart,
    "age_end": ageEnd,
    "height_start": heightStart,
    "height_end": heightEnd,
    "distance": distance,
    "sexuality_id": sexualityId,
    "religion_id": religionId,
    "looking_for": lookingFor,
  };
}
