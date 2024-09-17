import 'package:flutter/material.dart';

class FoodCard extends StatelessWidget {
  final String title;
  final String imageURL;

  const FoodCard({super.key, required this.title, required this.imageURL});

  @override
  Widget build(BuildContext context) {
    return Container(
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
              imageURL,
              height: 80,
              width: 80,
              fit: BoxFit.cover,
          )),
          const SizedBox(height: 8),
          Text(title, style: const TextStyle(fontSize: 18)),
        ],
      ),
    );
  }
}
