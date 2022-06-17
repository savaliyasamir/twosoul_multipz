


class StateData {
  StateData({
    this.id,
    this.name,
    this.iso2,
    this.countryId,
    this.latitude,
    this.longitude,
    this.active,
  });

  int? id;
  String? name;
  String? iso2;
  String? countryId;
  String? latitude;
  String? longitude;
  String? active;

  factory StateData.fromJson(Map<String, dynamic> json) => StateData(
    id: json["id"],
    name: json["name"],
    iso2: json["iso2"],
    countryId: json["country_id"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "iso2": iso2,
    "country_id": countryId,
    "latitude": latitude,
    "longitude": longitude,
    "active": active,
  };
}