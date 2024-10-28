// import 'package:flutter/material.dart';

// class CategoryDetailPage extends StatelessWidget {
//   final String categoryName;

//   const CategoryDetailPage({super.key, required this.categoryName});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(categoryName),
//       ),
//       body: Center(
//         child: Text(
//           'Has seleccionado la categoría: $categoryName',
//           style: const TextStyle(fontSize: 24),
//         ),
//       ),
//     );
//   }
// }

import 'package:calorie_counter/providers/db_foods.dart';
import 'package:flutter/material.dart';
import 'package:calorie_counter/models/food.dart';
import 'package:intl/intl.dart';

class CategoryDetailPage extends StatelessWidget {
  final DateTime selectedDate;
  final DBFood dbFood = DBFood();

  CategoryDetailPage({super.key, required this.selectedDate});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Comidas'),
      ),
      body: FutureBuilder<List<Food>>(
        future: dbFood
            .getFoodsByDate(DateFormat('dd/MM/yyyy').format(selectedDate)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error al cargar las comidas'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay comidas registradas'));
          } else {
            // ListView para mostrar las comidas
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Food food = snapshot.data![index];
                return ListTile(
                  title: Text(food.name),
                  subtitle: Text(
                      'Cantidad: ${food.quantity} ${food.unit}, Calorías: ${food.calories}, Fecha de Creación: ${food.createdAt}'),
                );
              },
            );
          }
        },
      ),
    );
  }
}
