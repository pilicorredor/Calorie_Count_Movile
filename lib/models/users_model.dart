import 'dart:convert';

UsersModel featuresModelFromJson(String str) =>
    UsersModel.fromJson(json.decode(str));

String featuresModelToJson(UsersModel data) => json.encode(data.toJson());


class UsersModel {
  UsersModel({
    this.id, 
    required this.username, 
    required this.email
  });

  final int? id;
  final String username;
  final String email;

  factory UsersModel.fromJson(Map<String, dynamic> json) => UsersModel(
    id: json["id"],
    username: json["username"], 
    email: json["email"]);

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "email": email,
  };
}
