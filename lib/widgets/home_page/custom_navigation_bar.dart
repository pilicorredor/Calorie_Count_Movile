import 'package:calorie_counter/providers/ui_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UIProvider>(context);

    return BottomNavigationBar(
      currentIndex: uiProvider.bnbIndex,
      onTap: (int i) => uiProvider.bnbIndex = i,
      
      type: BottomNavigationBarType.fixed, // Fuerza el modo fijo para mostrar los íconos correctamente
      items: const [
        BottomNavigationBarItem(label: 'Inicio', icon: Icon(Icons.home)),
        BottomNavigationBarItem(label: 'Favoritos', icon: Icon(Icons.favorite)),
        BottomNavigationBarItem(label: 'Gráficos', icon: Icon(Icons.bar_chart_outlined)),
        BottomNavigationBarItem(label: 'Usuario', icon: Icon(Icons.person)),
    ]);
  }
}

