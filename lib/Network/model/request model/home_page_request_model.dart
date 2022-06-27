

// To parse this JSON data, do
//
//     final homePageRequestModel = homePageRequestModelFromJson(jsonString);

import 'dart:convert';

HomePageRequestModel homePageRequestModelFromJson(String str) => HomePageRequestModel.fromJson(json.decode(str));

String homePageRequestModelToJson(HomePageRequestModel data) => json.encode(data.toJson());

class HomePageRequestModel {
  HomePageRequestModel({
    this.deviceToken,
    this.latitude,
    this.longitude,
    this.distance,
    this.limit,
  });

  String? deviceToken;
  double? latitude;
  double? longitude;
  int? distance;
  int? limit;

  factory HomePageRequestModel.fromJson(Map<String, dynamic> json) => HomePageRequestModel(
    deviceToken: json["device_token"],
    latitude: json["latitude"].toDouble(),
    longitude: json["longitude"].toDouble(),
    distance: json["distance"],
    limit: json["limit"],

  );

  Map<String, dynamic> toJson() => {
    "device_token": deviceToken,
    "latitude": latitude,
    "longitude": longitude,
    "distance": distance,
    "limit": limit,
  };
}
