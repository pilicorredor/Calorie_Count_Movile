import 'package:flutter/material.dart';

class FoodCard extends StatelessWidget {
  final String imageUrl;
  final String description;

  const FoodCard({super.key, required this.imageUrl, required this.description});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 180,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 5,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                height: 120,
                width: double.infinity, // Asegura que la imagen cubra todo el ancho
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                description,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}