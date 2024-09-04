import 'package:calorie_counter/widgets/home_page/custom_navigation_bar.dart';
import 'package:calorie_counter/widgets/home_page/food_card.dart';
import 'package:calorie_counter/widgets/home_page/title_home_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: const CustomNavigationBar(),
    body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TitleHomePage(
              title: 'Bienvenido\nCalorias consumidas',
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2, // Número de columnas
                crossAxisSpacing: 10, // Espacio horizontal entre las cards
                mainAxisSpacing: 10, // Espacio vertical entre las cards
                children: const [
                  FoodCard(
                    imageUrl: 'https://5aldia.cl/wp-content/uploads/2018/03/manzana.jpg',
                    description: 'Manzana - 50Kcal',
                  ),
                  FoodCard(
                    imageUrl: 'https://s2.abcstatics.com/media/bienestar/2020/08/26/arroz-blanco-kUXE--1248x698@abc.jpg',
                    description: 'Arroz - 100Kcal',
                  ),
                  FoodCard(
                    imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/4/45/A_small_cup_of_coffee.JPG/1200px-A_small_cup_of_coffee.JPG',
                    description: 'Cafe - 180Kcal',
                  ),
                  FoodCard(
                    imageUrl: 'https://i.ytimg.com/vi/HyBl-Du7OBc/maxresdefault.jpg',
                    description: 'Pescado - 295Kcal',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}