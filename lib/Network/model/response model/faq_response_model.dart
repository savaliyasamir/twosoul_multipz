

// To parse this JSON data, do
//
//     final faqDataResponseModel = faqDataResponseModelFromJson(jsonString);

import 'dart:convert';

FaqDataResponseModel faqDataResponseModelFromJson(String str) => FaqDataResponseModel.fromJson(json.decode(str));

String faqDataResponseModelToJson(FaqDataResponseModel data) => json.encode(data.toJson());

class FaqDataResponseModel {
  FaqDataResponseModel({
    this.data,
    this.message,
  });

  List<Datum>? data;
  String? message;

  factory FaqDataResponseModel.fromJson(Map<String, dynamic> json) => FaqDataResponseModel(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    "message": message,
  };
}

class Datum {
  Datum({
    this.id,
    this.title,
    this.question,
    this.answer,
  });

  int? id;
  String? title;
  String? question;
  String? answer;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    title: json["title"],
    question: json["question"],
    answer: json["answer"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "question": question,
    "answer": answer,
  };
}
