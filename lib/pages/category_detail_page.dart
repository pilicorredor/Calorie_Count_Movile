import 'package:calorie_counter/models/Food.dart';
import 'package:calorie_counter/providers/db_foods.dart';
import 'package:calorie_counter/widgets/home_page/calories_display_widget.dart';
import 'package:calorie_counter/widgets/home_page/food_card_item.dart';
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
      CaloriesDisplayWidget(
                    futureCalories: getCaloriesForSelectedDateAndCategory(),
                    icon: const Icon(
                      Icons.food_bank_sharp,
                      color: Colors.blue,
                      size: 40,
                    ),
                    text: "Calorías de esta categoría: ",
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
                  return FoodCardItem(food: food);
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
