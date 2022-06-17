
import 'package:twosoul_multipz/Network/model/response%20model/common_model/city_data.dart';
import 'package:twosoul_multipz/Network/model/response%20model/common_model/religion_data.dart';
import 'package:twosoul_multipz/Network/model/response%20model/common_model/state_data.dart';
import 'country_data.dart';
import 'image_data.dart';
import 'sexuality_data.dart';

class UserData {
  UserData({
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
  SexualityData? sexuality;
  ReligionData? religion;
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
  CountryData? country;
  StateData? state;
  CityData? city;
  List<ImageData>? image;

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    id: json["id"],
    name: json["name"],
    lookingFor: json["looking_for"],
    relaitonshipStatus: json["relaitonship_status"],
    defaultLanguageCode: json["default_language_code"],
    sexuality:SexualityData.fromJson(json["sexuality"]),
    religion: ReligionData.fromJson(json["religion"]),
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
    country: CountryData.fromJson(json["country"]),
    state: StateData.fromJson(json["state"]),
    city: CityData.fromJson(json["city"]),
    image: List<ImageData>.from(json["image"].map((x) => x)),
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
    "country": country!.toJson(),
    "state": state!.toJson(),
    "city": city!.toJson(),
    "image": List<ImageData>.from(image!.map((x) => x)),
  };
}