import 'package:flutter/material.dart';

class FoodCard extends StatelessWidget {
  final String title;
  final IconData icon;

  const FoodCard({super.key, required this.title, required this.icon});

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
          Icon(icon, size: 40),
          const SizedBox(height: 8),
          Text(title, style: const TextStyle(fontSize: 18)),
        ],
      ),
    );
  }
}
