import 'package:calorie_counter/models/category.dart';
import 'package:calorie_counter/models/category_model.dart';
import 'package:calorie_counter/pages/add_category.dart';
import 'package:calorie_counter/pages/add_food.dart';
import 'package:calorie_counter/pages/add_recipes.dart';
import 'package:calorie_counter/utils/page_animation_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class CustomFabAddFood extends StatelessWidget {
  final Function(Category) onCategoryAdded; // Callback para agregar categoría

  const CustomFabAddFood({super.key, required this.onCategoryAdded});

  @override
  Widget build(BuildContext context) {
    List<SpeedDialChild> childButtons = [];

    childButtons.add(SpeedDialChild(
      backgroundColor: const Color(0xFF6F28B0),
      child: const Icon(Icons.add, color: Colors.white),
      label: 'Agregar Comida',
      labelStyle: const TextStyle(fontSize: 18.0),
      onTap: () {
        Navigator.push(
          context,
          PageAnimationRoute(widget: const AddFood(), ejex: 0.8, ejey: 0.8),
        );
      },
    ));

    childButtons.add(SpeedDialChild(
      backgroundColor: const Color(0xFF6F28B0),
      child: const Icon(Icons.add, color: Colors.white),
      label: 'Agregar receta',
      labelStyle: const TextStyle(fontSize: 18.0),
      onTap: () {
        Navigator.push(
          context,
          PageAnimationRoute(widget: const AddRecipes(), ejex: 0.8, ejey: 0.8),
        );
      },
    ));

    childButtons.add(SpeedDialChild(
      backgroundColor: const Color(0xFF6F28B0),
      child: const Icon(Icons.add, color: Colors.white),
      label: 'Agregar categoría',
      labelStyle: const TextStyle(fontSize: 18.0),
      onTap: () async {
        // Navegar a la página de agregar categoría
        await Navigator.push(
          context,
          PageAnimationRoute(
            widget: AddCategory(
              onAddCategory: (category) {
                // Aquí se maneja el agregado de la categoría
                onCategoryAdded(category); // Llamar al callback con la nueva categoría
              },
            ),
            ejex: 0.8,
            ejey: 0.8,
          ),
        );
      },
    ));

    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      backgroundColor: const Color(0xFF6F28B0),
      foregroundColor: Colors.white,
      children: childButtons,
    );
  }
}
