import 'package:calorie_counter/models/Food.dart';
import 'package:calorie_counter/providers/db_foods.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CategoryDetailPage extends StatelessWidget {
  final DateTime selectedDate;
  final String categoryName;
  final DBFood dbFood = DBFood();

  CategoryDetailPage(
      {super.key, required this.selectedDate, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Comidas'),
      ),
      body: Padding(
  padding: const EdgeInsets.all(12.0),
  child: Column(
    children: [
      FutureBuilder<double>(
        future: getCaloriesForSelectedDateAndCategory(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text(
              'Calculando calorías...',
              style: TextStyle(fontSize: 18),
            );
          } else if (snapshot.hasError) {
            return const Text(
              'Error al obtener las calorías',
              style: TextStyle(fontSize: 18, color: Colors.red),
            );
          } else {
            final caloriesForDay = snapshot.data ?? 0.0;
            return Text(
              'Calorías totales: ${caloriesForDay.toStringAsFixed(1)} kcal',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            );
          }
        },
      ),
      const SizedBox(height: 20), // Espacio entre los widgets
      Expanded(
        child: FutureBuilder<List<Food>>(
          future: dbFood.getFoodsByCategoryAndDate(
              categoryName, DateFormat('dd/MM/yyyy').format(selectedDate)),
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
                      'Cantidad: ${food.quantity} ${food.unit}, Calorías: ${food.calories}, Fecha de Creación: ${food.createdAt}, Categoria: ${food.categoryName}',
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    ],
  ),
),

      
    );
  }
  
  Future<double> getCaloriesForSelectedDateAndCategory() async {
    String formattedDate = DateFormat('dd/MM/yyyy').format(selectedDate);
    List<Food> foods = await dbFood.getFoodsByCategoryAndDate(categoryName,formattedDate);
    double totalCalories = foods.fold(0, (sum, food) => sum + food.calories);
    return totalCalories;
  }
}
