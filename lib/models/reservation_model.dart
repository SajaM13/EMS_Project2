// To parse this JSON data, do
//
//     final reservation = reservationFromJson(jsonString);

import 'dart:convert';

Reservation reservationFromJson(String str) =>
    Reservation.fromJson(json.decode(str));

String reservationToJson(Reservation data) => json.encode(data.toJson());

class Reservation {
  Reservation({
    required this.id,
    required this.type,
    required this.chairsNum,
    required this.startDate,
    required this.userName,
    required this.hallName,
    //required this.issueDate,
    required this.camName,
    required this.filmNum,
    required this.photoNum,
    // required this.adminName,
    required this.foods,
  });

  int id;
  String type;
  int chairsNum;
  DateTime startDate;
  String userName;
  String hallName;
  // DateTime issueDate;
  String camName;
  int filmNum;
  int photoNum;
  // String adminName;
  List<Food> foods;

  factory Reservation.fromJson(Map<String, dynamic> json) => Reservation(
        id: json["id"],
        type: json["type"],
        chairsNum: json["chairs_num"],
        startDate: DateTime.parse(json["start_date"]),
        userName: json["user_name"],
        hallName: json["hall_name"],
        // issueDate: DateTime.parse(json["issue_date"]),
        camName: json["cam_name"],
        filmNum: json["film_num"],
        photoNum: json["photo_num"],
        //  adminName: json["admin_name"],
        foods: List<Food>.from(json["foods"].map((x) => Food.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "chairs_num": chairsNum,
        "start_date": startDate.toIso8601String(),
        "user_name": userName,
        "hall_name": hallName,
        //    "issue_date": issueDate.toIso8601String(),
        "cam_name": camName,
        "film_num": filmNum,
        "photo_num": photoNum,
        //  "admin_name": adminName,
        "foods": List<dynamic>.from(foods.map((x) => x.toJson())),
      };
}

class Food {
  Food({
    required this.name,
    required this.price,
  });

  String name;
  int price;

  factory Food.fromJson(Map<String, dynamic> json) => Food(
        name: json["name"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "price": price,
      };
}
