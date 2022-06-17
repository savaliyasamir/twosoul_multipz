

class CountryData {
  CountryData({
    this.id,
    this.name,
    this.iso2,
    this.phonecode,
    this.latitude,
    this.longitude,
    this.region,
    this.emoji,
    this.emojiU,
    this.active,
  });

  int? id;
  String? name;
  String? iso2;
  String? phonecode;
  String? latitude;
  String? longitude;
  String? region;
  String? emoji;
  String? emojiU;
  String? active;

  factory CountryData.fromJson(Map<String, dynamic> json) => CountryData(
    id: json["id"],
    name: json["name"],
    iso2: json["iso2"],
    phonecode: json["phonecode"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    region: json["region"],
    emoji: json["emoji"],
    emojiU: json["emojiU"],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "iso2": iso2,
    "phonecode": phonecode,
    "latitude": latitude,
    "longitude": longitude,
    "region": region,
    "emoji": emoji,
    "emojiU": emojiU,
    "active": active,
  };
}