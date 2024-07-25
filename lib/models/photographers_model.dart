import 'dart:convert';
//import 'package:http/http.dart' as http;

List<Photographers> photographersFromJson(String str) =>
    List<Photographers>.from(
        json.decode(str).map((x) => Photographers.fromJson(x)));

String photographersToJson(List<Photographers> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Photographers {
  int id;
  String name;
  String description;
  //List<String> availability;
  String contact;

  Photographers({
    required this.id,
    required this.name,
    required this.description,
    // required this.availability,
    required this.contact,
  });

  factory Photographers.fromJson(Map<String, dynamic> json) => Photographers(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        // availability: List<String>.from(json["availability"].map((x) => x)),
        contact: json["contact"],
      );

  Map<String, dynamic> toJson() => {
        // we dont need it in get
        "id": id,
        "name": name,
        "description": description,
        // "availability": List<dynamic>.from(availability.map((x) => x)),
        "contact": contact,
      };
}
