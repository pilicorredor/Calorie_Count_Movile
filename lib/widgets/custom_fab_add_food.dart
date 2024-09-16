import 'package:calorie_counter/pages/add_food.dart';
import 'package:calorie_counter/pages/add_recipes.dart';
import 'package:calorie_counter/utils/page_animation_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class CustomFabAddFood extends StatelessWidget {
  const CustomFabAddFood({super.key});

  @override
  Widget build(BuildContext context) {
    List<SpeedDialChild> childButtons = [];

    childButtons.add(SpeedDialChild(
      backgroundColor: const Color(0xFF6F28B0),
      child: const Icon(Icons.add, color: Colors.white), // El ícono del botón se mantiene blanco
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
      child: const Icon(Icons.add, color: Colors.white), // El ícono del botón se mantiene blanco
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
      icon: Icons.add, // "+" ícono principal
      activeIcon: Icons.close, // "x" ícono al estar abierto
      iconTheme: const IconThemeData(color: Colors.white), // Símbolos "+" y "x" en blanco
      backgroundColor: Colors.purple, // Color de fondo del FAB
      children: childButtons,
      spacing: 10.0,
      childMargin: const EdgeInsets.symmetric(horizontal: 6.0),
      childrenButtonSize: const Size(60.0, 60.0),
    );
  }
}
