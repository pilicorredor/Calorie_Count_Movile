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
      userId: json["userId"] is int
          ? json["userId"] as int
          : int.tryParse(json["userId"]?.toString() ?? ''), // Maneja cadenas como enteros
      name: json["name"],
      email: json["email"],
      age: json["age"] is int
          ? json["age"] as int
          : int.tryParse(json["age"]?.toString() ?? ''), // Maneja cadenas como enteros
      weight: json["weight"] is double
          ? json["weight"] as double
          : double.tryParse(json["weight"]?.toString() ?? ''), // Maneja cadenas como dobles
      height: json["height"] is double
          ? json["height"] as double
          : double.tryParse(json["height"]?.toString() ?? ''), // Maneja cadenas como dobles
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
