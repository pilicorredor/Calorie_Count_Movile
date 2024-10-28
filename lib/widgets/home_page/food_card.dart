import 'package:calorie_counter/models/category_model.dart';
import 'package:calorie_counter/utils/utils.dart';
import 'package:flutter/material.dart';

class FoodCard extends StatelessWidget {
  final CategoryModel category;
  final VoidCallback onTap;

  const FoodCard({
    super.key,
    required this.category,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: category.color.toColor(),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Icon(
                category.icon.toIcon(),
                size: 80,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              category.categoryName,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
