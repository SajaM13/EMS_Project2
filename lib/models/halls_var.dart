import 'dart:convert';

List<Halls> welcomeFromJson(String str) =>
    List<Halls>.from(json.decode(str).map((x) => Halls.fromJson(x)));

String welcomeToJson(List<Halls> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Halls {
  Halls({
    required this.id,
    required this.name,
    required this.locationName,
    required this.rateValue,
    required this.path,
  });

  int id;
  String name;
  String locationName;
  double rateValue;
  String path;

  factory Halls.fromJson(Map<String, dynamic> json) => Halls(
        id: json["id"],
        name: json["name"],
        locationName: json["location_name"],
        rateValue: json["rate_value"].toDouble(),
        path: json["path"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "location_name": locationName,
        "rate_value": rateValue,
        "path": path
      };
}
