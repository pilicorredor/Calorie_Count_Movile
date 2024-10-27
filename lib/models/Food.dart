import 'dart:convert';

Food foodFromJson(String str) =>
    Food.fromJson(json.decode(str));

String foodToJson(Food data) => json.encode(data.toJson());

class Food {
  int? id;
  String name;
  double quantity;
  String unit;
  double calories;
  String createdAt;

  Food({
     this.id,
     this.name = '',
     this.quantity = 0.0,
     this.unit = '',
     this.calories = 0.0,
     this.createdAt = '',
  });

  @override
  String toString() {
    return 'Food(name: $name, quantity: $quantity, unit: $unit, calories: $calories)';
  }

  factory Food.fromJson(Map<String, dynamic> json) => Food(
    id: json["id"],
    name: json["name"],
    quantity: json["quantity"],
    unit: json["unit"],
    calories: json["calories"],
    createdAt: json["createdAt"],
  );

  Map<String, dynamic> toJson() => {
    "id":id,
    "name": name,
    "quantity": quantity,
    "unit": unit,
    "calories": calories,
    "createdAt": createdAt,
  };
}