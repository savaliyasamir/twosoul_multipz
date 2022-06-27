
// To parse this JSON data, do
//
//     final receiveMatchResponseModel = receiveMatchResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:twosoul_multipz/Network/model/response%20model/common_model/user_data_model.dart';

ReceiveMatchResponseModel receiveMatchResponseModelFromJson(String str) => ReceiveMatchResponseModel.fromJson(json.decode(str));

String receiveMatchResponseModelToJson(ReceiveMatchResponseModel data) => json.encode(data.toJson());

class ReceiveMatchResponseModel {
  ReceiveMatchResponseModel({
    this.data,
    this.links,
    this.meta,
    this.message,
  });

  List<ReceiverMatchData>? data;
  Links? links;
  Meta? meta;
  String? message;

  factory ReceiveMatchResponseModel.fromJson(Map<String, dynamic> json) => ReceiveMatchResponseModel(
    data: List<ReceiverMatchData>.from(json["data"].map((x) => ReceiverMatchData.fromJson(x))),
    links: Links.fromJson(json["links"]),
    meta: Meta.fromJson(json["meta"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    "links": links!.toJson(),
    "meta": meta!.toJson(),
    "message": message,
  };
}

class ReceiverMatchData {
  ReceiverMatchData({
    this.id,
    this.sender,
    this.type,
  });

  int? id;
  UserData? sender;
  String? type;

  factory ReceiverMatchData.fromJson(Map<String, dynamic> json) => ReceiverMatchData(
    id: json["id"],
    sender: UserData.fromJson(json["sender"]),
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "sender": sender!.toJson(),
    "type": type,
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
