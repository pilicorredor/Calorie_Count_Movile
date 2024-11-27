import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  final int? userId;
  final String? name;
  final String? email;
  final int? age;
  final double? weight;
  final double? height;
  final String? gender;
  final String? goal;
  final String? password;

  User({
    this.userId,
    this.name,
    this.email,
    this.age,
    this.weight,
    this.height,
    this.gender,
    this.goal,
    this.password,
  });

  @override
  String toString() {
    return 'User(id: $userId, name: $name, email: $email, age: $age, weight: $weight, height: $height, gender: $gender, goal: $goal, password: $password)';
  }

  factory User.fromJson(Map<String, dynamic> json) => User(
        userId: json["name"],
        name: json["name"],
        email: json["email"],
        age: json["age"],
        weight: json["weight"],
        height: json["height"],
        gender: json["gender"],
        goal: json["goal"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "name": name,
        "email": email,
        "age": age,
        "weight": weight,
        "height": height,
        "gender": gender,
        "goal": goal,
        "password": password,
      };
}
