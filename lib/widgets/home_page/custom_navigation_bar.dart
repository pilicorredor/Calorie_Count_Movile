import 'package:flutter/material.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed, // Fuerza el modo fijo para mostrar los íconos correctamente
      items: const [
        BottomNavigationBarItem(label: 'Inicio', icon: Icon(Icons.home)),
        BottomNavigationBarItem(label: 'Favoritos', icon: Icon(Icons.favorite)),
        BottomNavigationBarItem(label: 'Gráficos', icon: Icon(Icons.bar_chart_outlined)),
        BottomNavigationBarItem(label: 'Usuario', icon: Icon(Icons.person)),
    ]);
  }
}

