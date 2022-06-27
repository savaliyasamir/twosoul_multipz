// To parse this JSON data, do
//
//     final communityResponseModel = communityResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:twosoul_multipz/Network/model/response%20model/common_model/city_data.dart';
import 'package:twosoul_multipz/Network/model/response%20model/common_model/country_data.dart';
import 'package:twosoul_multipz/Network/model/response%20model/common_model/image_data.dart';
import 'package:twosoul_multipz/Network/model/response%20model/common_model/state_data.dart';

CommunityResponseModel communityResponseModelFromJson(String str) => CommunityResponseModel.fromJson(json.decode(str));

String communityResponseModelToJson(CommunityResponseModel data) => json.encode(data.toJson());

class CommunityResponseModel {
  CommunityResponseModel({
    this.data,
    this.message,
  });

  List<CommunityData>? data;
  String? message;

  factory CommunityResponseModel.fromJson(Map<String, dynamic> json) => CommunityResponseModel(
    data: List<CommunityData>.from(json["data"].map((x) => CommunityData.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    "message": message,
  };
}

class CommunityData {
  CommunityData({
    this.id,
    this.name,
    this.gender,
    this.age,
    this.distance,
    this.distanceIn,
    this.height,
    this.about,
    this.country,
    this.state,
    this.city,
    this.image,
  });

  int? id;
  String? name;
  String? gender;
  String? age;
  String? distance;
  String? distanceIn;
  int? height;
  String? about;
  CountryData? country;
  StateData? state;
  CityData? city;
  List<ImageData>? image;

  factory CommunityData.fromJson(Map<String, dynamic> json) => CommunityData(
    id: json["id"],
    name: json["name"],
    gender: json["gender"],
    age: json["age"],
    distance: json["distance"],
    distanceIn: json["distance_in"],
    height: json["height"],
    about: json["about"],
    country:json["country"] == null ? null : CountryData.fromJson(json["country"]),
    state:  json["state"]==null?null:StateData.fromJson(json["state"]),
    city:json["city"] == null ? null :CityData.fromJson(json["city"]),
    image:json["image"]!=null ? List<ImageData>.from(json["image"].map((x) => ImageData.fromJson(x))):[],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "gender": gender,
    "age": age,
    "distance": distance,
    "distance_in": distanceIn,
    "height": height,
    "about": about,
    "country": country!.toJson(),
    "state": state!.toJson(),
    "city": city!.toJson(),
    "image": List<ImageData>.from(image!.map((x) => x.toJson())),
  };
}


