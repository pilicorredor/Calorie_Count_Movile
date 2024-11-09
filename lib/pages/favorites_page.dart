import 'package:flutter/material.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Lista de alimentos favoritos con imágenes y calorías
    final List<Map<String, dynamic>> favoriteFoods = [
      {
        'name': 'Limonada Cerezada',
        'calories': 95,
        'image': 'https://via.placeholder.com/150'
      },
      {
        'name': 'Pollo a la parrilla',
        'calories': 165,
        'image': 'https://via.placeholder.com/150'
      },
      {
        'name': 'Ensalada de frutas',
        'image': 'https://via.placeholder.com/150'
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Recetas'),
      ),
      body: ListView.builder(
        itemCount: favoriteFoods.length,
        itemBuilder: (context, index) {
          final food = favoriteFoods[index];
          return Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              leading: Image.network(food['image']),
              title: Text(
                food['name'],
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Text('${food['calories']} calorías'),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  // Lógica para eliminar de favoritos
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
