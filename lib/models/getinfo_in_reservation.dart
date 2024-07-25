// To parse this JSON data, do
//
//     final getInfo = getInfoFromJson(jsonString);

import 'dart:convert';

List<GetInfo> getInfoFromJson(String str) =>
    List<GetInfo>.from(json.decode(str).map((x) => GetInfo.fromJson(x)));

String getInfoToJson(List<GetInfo> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetInfo {
  GetInfo({
    required this.cam,
    required this.food,
  });

  List<Cam> cam;
  List<Foood> food;

  factory GetInfo.fromJson(Map<String, dynamic> json) => GetInfo(
        cam: List<Cam>.from(json["cam"].map((x) => Cam.fromJson(x))),
        food: List<Foood>.from(json["food"].map((x) => Foood.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "cam": List<dynamic>.from(cam.map((x) => x.toJson())),
        "food": List<dynamic>.from(food.map((x) => x.toJson())),
      };
}

class Cam {
  Cam({
    required this.id,
    required this.name,
  });

  int id;
  String name;

  factory Cam.fromJson(Map<String, dynamic> json) => Cam(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class Foood {
  Foood({
    required this.id,
    required this.name,
    required this.price,
    required this.isChecked,
  });

  int id;
  String name;
  double price;
  bool isChecked;

  factory Foood.fromJson(Map<String, dynamic> json) => Foood(
        id: json["id"],
        name: json["name"],
        price: json["price"].toDouble(),
        isChecked: json["IsChecked"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "IsChecked": isChecked,
      };
}
