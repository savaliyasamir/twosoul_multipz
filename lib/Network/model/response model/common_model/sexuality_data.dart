

class SexualityData {
  SexualityData({
    this.id,
    this.name,
    this.status,
  });

  int? id;
  String? name;
  String? status;

  factory SexualityData.fromJson(Map<String, dynamic> json) => SexualityData(
    id: json["id"],
    name: json["name"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "status": status,
  };
}