
import 'package:calorie_counter/pages/home_page.dart';
import 'package:calorie_counter/providers/ui_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UIProvider()), // Proveedor para manejar el estado de la barra de navegación
      ],
      child: MaterialApp(
        title: 'Calorie Counter',
        initialRoute: 'home',
        routes: {
          'home': (_) => const HomePage(),
        },
      ),
    );
  }
}
