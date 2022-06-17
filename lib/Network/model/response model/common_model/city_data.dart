

class CityData {
  CityData({
    this.id,
    this.name,
    this.stateId,
    this.countryId,
    this.latitude,
    this.longitude,
    this.active,
    this.iso2,
  });

  int? id;
  String? name;
  String? stateId;
  String? countryId;
  String? latitude;
  String? longitude;
  String? active;
  String? iso2;

  factory CityData.fromJson(Map<String, dynamic> json) => CityData(
    id: json["id"],
    name: json["name"],
    stateId: json["state_id"] == null ? null : json["state_id"],
    countryId: json["country_id"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    active: json["active"],
    iso2: json["iso2"] == null ? null : json["iso2"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "state_id": stateId == null ? null : stateId,
    "country_id": countryId,
    "latitude": latitude,
    "longitude": longitude,
    "active": active,
    "iso2": iso2 == null ? null : iso2,
  };
}