import 'dart:convert';

Recipe recipeFromJson(String str) => Recipe.fromJson(json.decode(str));

String recipeToJson(Recipe data) => json.encode(data.toJson());

class Recipe {
  int? id;
  String name;
  String ingredients;
  String preparationSteps;
  String? imagePath;

  Recipe({
    this.id,
    this.name = '',
    this.ingredients = '',
    this.preparationSteps = '',
    this.imagePath,
  });

  @override
  String toString() {
    return 'Recipe(name: $name, ingredients: $ingredients, preparationSteps: $preparationSteps, imagePath: $imagePath)';
  }

  factory Recipe.fromJson(Map<String, dynamic> json) => Recipe(
        id: json["id"],
        name: json["name"],
        ingredients: json["ingredients"],
        preparationSteps: json["preparationSteps"],
        imagePath: json["imagePath"], // Añadir el campo de la imagen
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "ingredients": ingredients,
        "preparationSteps": preparationSteps,
        "imagePath": imagePath, // Añadir el campo de la imagen
      };
}
