// To parse this JSON data, do
//
//     final loginResponseModel = loginResponseModelFromJson(jsonString);

import 'dart:convert';

LoginResponseModel loginResponseModelFromJson(String str) => LoginResponseModel.fromJson(json.decode(str));

String loginResponseModelToJson(LoginResponseModel data) => json.encode(data.toJson());

class LoginResponseModel {
  LoginResponseModel({
    this.data,
    this.message,
    this.token,
  });

  Data? data;
  String? message;
  String? token;

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) => LoginResponseModel(
    data: Data.fromJson(json["data"]),
    message: json["message"],
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "data": data!.toJson(),
    "message": message,
    "token": token,
  };
}

class Data {
  Data({
    this.id,
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
    this.height,
    this.designation,
    this.about,
    this.profileStatus,
    this.country,
    this.state,
    this.city,
    this.image,
  });

  int? id;
  String? name;
  String? lookingFor;
  String? relaitonshipStatus;
  String? defaultLanguageCode;
  Religion? sexuality;
  Religion? religion;
  String? gender;
  String? totalLikes;
  String? totalSuperlikes;
  String? totalRewinds;
  String? dob;
  String? age;
  String? height;
  String? designation;
  String? about;
  String? profileStatus;
  dynamic country;
  dynamic state;
  dynamic city;
  List<dynamic>? image;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    name: json["name"],
    lookingFor: json["looking_for"],
    relaitonshipStatus: json["relaitonship_status"],
    defaultLanguageCode: json["default_language_code"],
    sexuality: Religion.fromJson(json["sexuality"]),
    religion: Religion.fromJson(json["religion"]),
    gender: json["gender"],
    totalLikes: json["total_likes"],
    totalSuperlikes: json["total_superlikes"],
    totalRewinds: json["total_rewinds"],
    dob: json["dob"],
    age: json["age"],
    height: json["height"],
    designation: json["designation"],
    about: json["about"],
    profileStatus: json["profile_status"],
    country: json["country"],
    state: json["state"],
    city: json["city"],
    image: List<dynamic>.from(json["image"].map((x) => x)),
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
    "height": height,
    "designation": designation,
    "about": about,
    "profile_status": profileStatus,
    "country": country,
    "state": state,
    "city": city,
    "image": List<dynamic>.from(image!.map((x) => x)),
  };
}

class Religion {
  Religion();

  factory Religion.fromJson(Map<String, dynamic> json) => Religion(
  );

  Map<String, dynamic> toJson() => {
  };
}
