import 'package:calorie_counter/pages/add_food.dart';
import 'package:calorie_counter/pages/add_recipes.dart';
import 'package:calorie_counter/utils/page_animation_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class CustomFabAddFood extends StatelessWidget {
  final DateTime selectedDate;

  const CustomFabAddFood({
    super.key,
    required this.selectedDate,
  });

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
          PageAnimationRoute(
              widget: AddFood(selectedDate: selectedDate),
              ejex: 0.8,
              ejey: 0.8),
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

    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      backgroundColor: const Color(0xFF6F28B0),
      foregroundColor: Colors.white,
      children: childButtons,
    );
  }
}
