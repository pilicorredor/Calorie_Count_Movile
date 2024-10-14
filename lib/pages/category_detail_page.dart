import 'package:flutter/material.dart';

class CategoryDetailPage extends StatelessWidget {
  final String categoryName;

  const CategoryDetailPage({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName),
      ),
      body: Center(
        child: Text(
          'Has seleccionado la categoría: $categoryName',
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
