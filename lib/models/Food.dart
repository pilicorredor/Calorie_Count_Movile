class Food {
  String name;
  double quantity;
  String unit;
  double calories;

  Food({
    required this.name,
    required this.quantity,
    required this.unit,
    required this.calories,
  });

  @override
  String toString() {
    return 'Food(name: $name, quantity: $quantity, unit: $unit, calories: $calories)';
  }
}