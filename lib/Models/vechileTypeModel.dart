// To parse this JSON data, do
//
//     final vechileTypeModel = vechileTypeModelFromJson(jsonString);

import 'dart:convert';

List<VechileTypeModel> vechileTypeModelFromJson(String str) => List<VechileTypeModel>.from(json.decode(str).map((x) => VechileTypeModel.fromJson(x)));

String vechileTypeModelToJson(List<VechileTypeModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VechileTypeModel {
  VechileTypeModel({
    this.id,
    this.image,
    this.vechiletype,
    this.killometterrupe,
  });

  String id;
  String image;
  String vechiletype;
  String killometterrupe;

  factory VechileTypeModel.fromJson(Map<String, dynamic> json) => VechileTypeModel(
    id: json["id"],
    image: json["image"],
    vechiletype: json["vechiletype"],
    killometterrupe: json["killometterrupe"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
    "vechiletype": vechiletype,
    "killometterrupe": killometterrupe,
  };
}
