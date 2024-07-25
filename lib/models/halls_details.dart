// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

List<HallsDetails> HallsDetailsFromJson(String str) => List<HallsDetails>.from(
    json.decode(str).map((x) => HallsDetails.fromJson(x)));

String HallsDetailsToJson(List<HallsDetails> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HallsDetails {
  HallsDetails({
    required this.locationName,
    required this.contact,
    required this.sizeMin,
    required this.sizeMax,
    required this.chairPrice,
    required this.times,
    required this.offers,
  });

  String locationName;
  String contact;
  int sizeMin;
  int sizeMax;
  int chairPrice;
  List<String> times;
  List<Offer> offers;

  factory HallsDetails.fromJson(Map<String, dynamic> json) => HallsDetails(
        locationName: json["location_name"],
        contact: json["contact"],
        sizeMin: json["size_min"],
        sizeMax: json["size_max"],
        chairPrice: json["chair_price"],
        times: List<String>.from(json["times"].map((x) => x)),
        offers: List<Offer>.from(json["offers"].map((x) => Offer.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "location_name": locationName,
        "contact": contact,
        "size_min": sizeMin,
        "size_max": sizeMax,
        "chair_price": chairPrice,
        "times": List<dynamic>.from(times.map((x) => x)),
        "offers": List<dynamic>.from(offers.map((x) => x.toJson())),
      };
}

class Offer {
  Offer({
    required this.id,
    required this.name,
    required this.value,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.fkUsersId,
    required this.pivot,
  });

  int id;
  String name;
  int value;
  String description;
  DateTime startDate;
  DateTime endDate;
  int fkUsersId;
  Pivot pivot;

  factory Offer.fromJson(Map<String, dynamic> json) => Offer(
        id: json["id"],
        name: json["name"],
        value: json["value"],
        description: json["description"],
        startDate: DateTime.parse(json["start_date"]),
        endDate: DateTime.parse(json["end_date"]),
        fkUsersId: json["fk_users_id"],
        pivot: Pivot.fromJson(json["pivot"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "value": value,
        "description": description,
        "start_date": startDate.toIso8601String(),
        "end_date": endDate.toIso8601String(),
        "fk_users_id": fkUsersId,
        "pivot": pivot.toJson(),
      };
}

class Pivot {
  Pivot({
    required this.fkHallId,
    required this.fkOfferId,
  });

  int fkHallId;
  int fkOfferId;

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
        fkHallId: json["fk_hall_id"],
        fkOfferId: json["fk_offer_id"],
      );

  Map<String, dynamic> toJson() => {
        "fk_hall_id": fkHallId,
        "fk_offer_id": fkOfferId,
      };
}
