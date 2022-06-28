import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:twosoul_multipz/Network/model/response%20model/common_model/city_data.dart';
import 'package:twosoul_multipz/Network/model/response%20model/common_model/religion_data.dart';
import 'package:twosoul_multipz/Network/model/response%20model/common_model/state_data.dart';
import 'country_data.dart';
import 'image_data.dart';
import 'sexuality_data.dart';

class FirebaseUserModel {
  FirebaseUserModel(
      {this.id,
      this.name,
      this.lookingFor,
      this.relaitonshipStatus,
      this.defaultLanguageCode,
      this.sexuality,
      this.religion,
      this.gender,
      this.totalLikes,
      this.totalSuperlikes,
      this.totalRewinds,
      this.dob,
      this.age,
      this.distance,
      this.distanceIn,
      this.height,
      this.designation,
      this.about,
      this.profileStatus,
      this.country,
      this.state,
      this.city,
        this.image,
      this.isOnline});

  int? id;
  String? name;
  String? lookingFor;
  String? relaitonshipStatus;
  String? defaultLanguageCode;
  SexualityData? sexuality;
  ReligionData? religion;
  String? gender;
  String? totalLikes;
  String? totalSuperlikes;
  String? totalRewinds;
  String? dob;
  String? age;
  String? distance;
  String? distanceIn;
  int? height;
  String? designation;
  String? about;
  String? profileStatus;
  CountryData? country;
  StateData? state;
  CityData? city;
  List<ImageData>? image;
  bool? isOnline;

  factory FirebaseUserModel.fromJson(Map<String, dynamic> json) =>
      FirebaseUserModel(
        id: json["id"],
        name: json["name"],
        lookingFor: json["looking_for"] ?? "",
        relaitonshipStatus: json["relaitonship_status"],
        defaultLanguageCode: json["default_language_code"],
        sexuality: json["sexuality"] == null
            ? null
            : SexualityData.fromJson(json["sexuality"]),
        religion: json["religion"] == null
            ? null
            : ReligionData.fromJson(json["religion"]),
        gender: json["gender"],
        totalLikes: json["total_likes"] ?? "",
        totalSuperlikes: json["total_superlikes"] ?? "",
        totalRewinds: json["total_rewinds"] ?? "",
        dob: json["dob"] ?? "",
        age: json["age"],
        distance: json["distance"] ?? "",
        distanceIn: json["distanceIn"] ?? "",
        height: json["height"],
        designation: json["designation"] ?? "",
        about: json["about"],
        profileStatus: json["profile_status"] ?? "",
        country: json["country"] == null
            ? null
            : CountryData.fromJson(json["country"]),
        state: json["state"] == null ? null : StateData.fromJson(json["state"]),
        city: json["city"] == null ? null : CityData.fromJson(json["city"]),
        image:json["image"]!=null ? List<ImageData>.from(json["image"].map((x) => ImageData.fromJson(x))):[],
        isOnline: json["isOnline"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "looking_for": lookingFor,
        "relaitonship_status": relaitonshipStatus,
        "default_language_code": defaultLanguageCode,
        "sexuality": sexuality!.toJson(),
        "religion": religion!.toJson(),
        "gender": gender,
        "total_likes": totalLikes,
        "total_superlikes": totalSuperlikes,
        "total_rewinds": totalRewinds,
        "dob": dob,
        "age": age,
        "distance": distance,
        "distanceIn": distanceIn,
        "height": height,
        "designation": designation,
        "about": about,
        "profile_status": profileStatus,
        "country": country!.toJson(),
        "state": state!.toJson(),
        "city": city!.toJson(),
    "image": List<ImageData>.from(image!.map((x) => x)).toList(),
        "isOnline": isOnline
      };

  factory FirebaseUserModel.fromDocument(DocumentSnapshot doc) {
    int? id = doc.get("id");
    String? name = doc.get("name");
    String? lookingFor = doc.get("looking_for");
    String? relaitonshipStatus = doc.get("relaitonship_status");
    String? defaultLanguageCode = doc.get("default_language_code");
    SexualityData? sexuality = doc.get("sexuality");
    ReligionData? religion = doc.get("religion");
    String? gender = doc.get("gender");
    String? totalLikes = doc.get("total_likes");
    String? totalSuperlikes = doc.get("total_superlikes");
    String? totalRewinds = doc.get("total_rewinds");
    String? dob = doc.get("dob");
    String? age = doc.get("age");
    String? distance = doc.get("distance");
    String? distanceIn = doc.get("distanceIn");
    int? height = doc.get("height");
    String? designation = doc.get("designation");
    String? about = doc.get("about");
    String? profileStatus = doc.get("profile_status");
    CountryData? country = doc.get("country");
    StateData? state = doc.get("state");
    CityData? city = doc.get("city");
    List<ImageData>? image = doc.get("image");
    bool? isOnline = doc.get("isOnline");

    return FirebaseUserModel(
      id: id,
      name: name,
      lookingFor: lookingFor,
      relaitonshipStatus: relaitonshipStatus,
      defaultLanguageCode: defaultLanguageCode,
      sexuality: sexuality,
      religion: religion,
      gender: gender,
      totalLikes: totalLikes,
      totalSuperlikes: totalSuperlikes,
      totalRewinds: totalRewinds,
      dob: dob,
      age: age,
      distance: distance,
      distanceIn: distanceIn,
      height: height,
      designation: designation,
      about: about,
      profileStatus: profileStatus,
      country: country,
      state: state,
      city: city,
      image: image!.toList(),
      isOnline: isOnline,
    );
  }
}
