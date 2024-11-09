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
      
      type: BottomNavigationBarType.fixed, 
      items: const [
        BottomNavigationBarItem(label: 'Inicio', icon: Icon(Icons.home)),
        BottomNavigationBarItem(label: 'Recetas', icon: Icon(Icons.receipt)),
        BottomNavigationBarItem(label: 'Gráficos', icon: Icon(Icons.bar_chart_outlined)),
        BottomNavigationBarItem(label: 'Usuario', icon: Icon(Icons.person)),
    ]);
  }
}

