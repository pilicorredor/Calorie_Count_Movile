import 'package:calorie_counter/pages/charts_page.dart';
import 'package:calorie_counter/pages/favorites_page.dart';
import 'package:calorie_counter/pages/user_page.dart';
import 'package:calorie_counter/providers/ui_provider.dart';
import 'package:calorie_counter/widgets/custom_fab_add_food.dart';
import 'package:calorie_counter/widgets/home_page/custom_navigation_bar.dart';
import 'package:calorie_counter/widgets/home_page/food_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UIProvider>(context);
    final currentIndex = uiProvider
        .bnbIndex; // Obtiene el índice actual de la barra de navegación

    return Scaffold(
      floatingActionButton: const CustomFabAddFood(),
      bottomNavigationBar: const CustomNavigationBar(),
      body: _getBody(
          currentIndex), // Cambia el cuerpo según el índice seleccionado
    );
  }

  // Método para obtener el cuerpo dinámico basado en el índice de la navegación
  Widget _getBody(int currentIndex) {
    
    switch (currentIndex) {
      case 0:
        return Scaffold(
          appBar: AppBar(
            title: const Text('Aplicación de Nutrición'),
            actions: [
              IconButton(
                icon: const Icon(Icons.notifications),
                onPressed: () {},
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header con la info del usuario y el avatar
                  const Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage('utils/assets/usuario.png'),
                        radius: 24,
                      ),
                      SizedBox(width: 12),
                      Text(
                        'Hola \nTom Pikard',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Promocion de la app
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.green[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Row(
                      children: [
                        //Image.asset('utils/assets/avocado.jpg', width: 60),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Un cuerpo saludable viene con buenos nutrientes\nEmpieza tu viaje a la salud ahora',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),
                  // Seccion de categorias de comida
                  const Text(
                    'Categorias',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Grid de categorias
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    physics: const NeverScrollableScrollPhysics(),
                    children: const [
                      FoodCard(
                        title: 'Verduras',
                        icon: Icons.local_florist,
                      ),
                      FoodCard(
                        title: 'Frutas',
                        icon: Icons.local_offer,
                      ),
                      FoodCard(
                        title: 'Nueces',
                        icon: Icons.ac_unit,
                      ),
                      FoodCard(
                        title: 'Comida de mar',
                        icon: Icons.anchor,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      case 1:
        return const FavoritesPage();
      case 2:
        return const ChartsPage();
      case 3:
        return const UserPage();
      default:
        return const ChartsPage(); // Página por defecto
    }
  }

}
