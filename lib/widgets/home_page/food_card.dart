import 'package:flutter/material.dart';
import 'package:calorie_counter/models/category.dart';

class FoodCard extends StatelessWidget {
  final Category category; // Objeto Category
  final VoidCallback onTap; // Callback para manejar el evento de toque

  const FoodCard({
    super.key,
    required this.category,
    required this.onTap, // Acepta el callback en el constructor
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector( // Detectar toques
      onTap: onTap, // Llama al callback cuando se presiona la tarjeta
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Image.network(
                category.imageUrl, // Usar imageUrl del objeto Category
                height: 80,
                width: 80,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              category.name, // Usar name del objeto Category
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
