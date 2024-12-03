import 'package:calorie_counter/models/Food.dart';
import 'package:calorie_counter/models/Recipe.dart';
import 'package:flutter/material.dart';

class RecipeCardItem extends StatelessWidget {
  final Recipe recipe;

  const RecipeCardItem({Key? key, required this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen del alimento (si existe)
            if (recipe.imagePath != null && recipe.imagePath!.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  recipe.imagePath!,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.food_bank_rounded, size: 80);
                  },
                ),
              )
            else
              const Icon(Icons.fastfood, size: 80, color: Colors.grey),

            const SizedBox(width: 15),

            // Detalles del alimento
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    recipe.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Ingredientes: ${recipe.ingredients}',
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Pasos de preparación: ${recipe.preparationSteps}',
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 5),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}