
class ReligionData {
  ReligionData({
    this.id,
    this.name,
    this.status,
  });

  int? id;
  String? name;
  String? status;

  factory ReligionData.fromJson(Map<String, dynamic> json) => ReligionData(
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
