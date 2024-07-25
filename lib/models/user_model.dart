// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    required this.user,
    required this.tokenType,
    required this.accessToken,
  });

  UserClass user;
  String tokenType;
  String accessToken;

  factory User.fromJson(Map<String, dynamic> json) => User(
        user: UserClass.fromJson(json["user"]),
        tokenType: json["token_type"],
        accessToken: json["access_token"],
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "token_type": tokenType,
        "access_token": accessToken,
      };
}

class UserClass {
  UserClass({
    required this.id,
    required this.roleId,
    required this.name,
    required this.email,
    required this.contact,
  });

  int id;
  int roleId;
  String name;
  String email;
  String contact;

  factory UserClass.fromJson(Map<String, dynamic> json) => UserClass(
        id: json["id"],
        roleId: json["role_id"],
        name: json["name"],
        email: json["email"],
        contact: json["contact"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "role_id": roleId,
        "name": name,
        "email": email,
        "contact": contact,
      };
}
