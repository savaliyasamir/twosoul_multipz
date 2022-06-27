


// To parse this JSON data, do
//
//     final homePageResponseModel = homePageResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:twosoul_multipz/Network/model/response%20model/common_model/city_data.dart';
import 'package:twosoul_multipz/Network/model/response%20model/common_model/country_data.dart';
import 'package:twosoul_multipz/Network/model/response%20model/common_model/state_data.dart';
import 'package:twosoul_multipz/Network/model/response%20model/common_model/image_data.dart';

HomePageResponseModel homePageResponseModelFromJson(String str) => HomePageResponseModel.fromJson(json.decode(str));

String homePageResponseModelToJson(HomePageResponseModel data) => json.encode(data.toJson());

class HomePageResponseModel {
  HomePageResponseModel({
    this.data,
    this.links,
    this.meta,
    this.message,
  });

  List<HomeData>? data;
  Links? links;
  Meta? meta;
  String? message;

  factory HomePageResponseModel.fromJson(Map<String, dynamic> json) => HomePageResponseModel(
    data: List<HomeData>.from(json["data"].map((x) => HomeData.fromJson(x))),
    links: Links.fromJson(json["links"]),
    meta: Meta.fromJson(json["meta"])??Meta(),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    "links": links!.toJson(),
    "meta": meta!.toJson(),
    "message": message,
  };
}

class HomeData {
  HomeData({
    this.id,
    this.name,
    this.gender,
    this.age,
    this.distance,
    this.distanceIn,
    this.height,
    this.country,
    this.about,
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

  factory HomeData.fromJson(Map<String, dynamic> json) => HomeData(
    id: json["id"],
    name: json["name"],
    gender: json["gender"],
    age: json["age"],
    distance: json["distance"],
    distanceIn: json["distance_in"],
    height: json['height'],
    about: json['about'],
    country: CountryData.fromJson(json["country"]),
    state: StateData.fromJson(json["state"]),
    city: CityData.fromJson(json["city"]),
    image: List<ImageData>.from(json["image"].map((x) => ImageData.fromJson(x))),
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



class Links {
  Links({
    this.first,
    this.last,
    this.prev,
    this.next,
  });

  String? first;
  String? last;
  String? prev;
  String? next;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
    first: json["first"]??"",
    last: json["last"]??"",
    prev: json["prev"]??"",
    next: json["next"]??"",
  );

  Map<String, dynamic> toJson() => {
    "first": first,
    "last": last,
    "prev": prev,
    "next": next,
  };
}

class Meta {
  Meta({
    this.currentPage,
    this.from,
    this.lastPage,
    this.links,
    this.path,
    this.perPage,
    this.to,
    this.total,
  });

  int? currentPage;
  int? from;
  int? lastPage;
  List<Link>? links;
  String? path;
  String? perPage;
  int? to;
  int? total;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    currentPage: json["current_page"],
    from: json["from"],
    lastPage: json["last_page"],
    links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
    path: json["path"],
    perPage: "${json["per_page"]}",
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "from": from,
    "last_page": lastPage,
    "links": List<Link>.from(links!.map((x) => x.toJson())),
    "path": path,
    "per_page": perPage,
    "to": to,
    "total": total,
  };
}

class Link {
  Link({
    this.url,
    this.label,
    this.active,
  });

  String? url;
  String? label;
  bool? active;

  factory Link.fromJson(Map<String, dynamic> json) => Link(
    url: json["url"] ?? "",
    label: json["label"],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "label": label,
    "active": active,
  };
}
