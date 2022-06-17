

class ImageData {
  ImageData({
    this.id,
    this.imagename,
    this.thumbnailImage,
    this.imageableId,
    this.imageableType,
    this.isDefault,
  });

  int? id;
  String? imagename;
  String? thumbnailImage;
  String? imageableId;
  String? imageableType;
  String? isDefault;

  factory ImageData.fromJson(Map<String, dynamic> json) => ImageData(
    id: json["id"],
    imagename: json["imagename"],
    thumbnailImage: json["thumbnailImage"],
    imageableId: json["imageable_id"],
    imageableType: json["imageable_type"],
    isDefault: json["is_default"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "imagename": imagename,
    "thumbnailImage": thumbnailImage,
    "imageable_id": imageableId,
    "imageable_type": imageableType,
    "is_default": isDefault,
  };
}