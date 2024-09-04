import 'package:flutter/material.dart';

class TitleHomePage extends StatelessWidget {
  final String title;

  const TitleHomePage({super.key, required this.title,});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.purple,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white, // Letra blanca
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
