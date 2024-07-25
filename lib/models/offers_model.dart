// To parse this JSON data, do
//
//     final hallsDetails = hallsDetailsFromJson(jsonString);

import 'dart:convert';

List<off> hallsDetailsFromJson(String str) =>
    List<off>.from(json.decode(str).map((x) => off.fromJson(x)));

String hallsDetailsToJson(List<off> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class off {
  off({
    required this.id,
    required this.name,
    required this.value,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.fkUsersId,
  });

  int id;
  String name;
  int value;
  String description;
  DateTime startDate;
  DateTime endDate;
  int fkUsersId;

  factory off.fromJson(Map<String, dynamic> json) => off(
        id: json["id"],
        name: json["name"],
        value: json["value"],
        description: json["description"],
        startDate: DateTime.parse(json["start_date"]),
        endDate: DateTime.parse(json["end_date"]),
        fkUsersId: json["fk_users_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "value": value,
        "description": description,
        "start_date": startDate.toIso8601String(),
        "end_date": endDate.toIso8601String(),
        "fk_users_id": fkUsersId,
      };
}
