import 'package:calorie_counter/pages/charts_page.dart';
import 'package:calorie_counter/pages/favorites_page.dart';
import 'package:calorie_counter/pages/user_page.dart';
import 'package:calorie_counter/providers/ui_provider.dart';
import 'package:calorie_counter/widgets/home_page/custom_navigation_bar.dart';
import 'package:calorie_counter/widgets/home_page/food_card.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
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
                        backgroundImage: NetworkImage(
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRDwmG52pVI5JZfn04j9gdtsd8pAGbqjjLswg&s'),
                        radius: 24,
                      ),
                      SizedBox(width: 12),
                      Text(
                        'Hola\n',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      Text(
                        '\n Tom Pikard',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  EasyDateTimeLine(
                    initialDate: DateTime.now(),
                    onDateChange: (selectedDate) {
                      //`selectedDate` the new date selected.
                    },
                    activeColor: const Color.fromARGB(255, 238, 155, 255),
                    locale: "es",
                    headerProps: const EasyHeaderProps(
                      dateFormatter: DateFormatter.monthOnly(),
                    ),
                    dayProps: const EasyDayProps(
                      height: 56.0,
                      width: 56.0,
                      dayStructure: DayStructure.dayNumDayStr,
                      inactiveDayStyle: DayStyle(
                        borderRadius: 48.0,
                        dayNumStyle: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                      activeDayStyle: DayStyle(
                        dayNumStyle: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Promocion de la app
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 221, 194, 233),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Image.network(
                            'https://cdn.pixabay.com/photo/2018/09/03/11/51/avocado-3651037_960_720.png',
                            width: 70),
                        const SizedBox(width: 10),
                        const Expanded(
                          child: Text(
                            'Un cuerpo saludable viene con buenos nutrientes.\n¡Empieza tu viaje a la salud ahora!',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontStyle: FontStyle.italic 
                              ),
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
                        imageURL:
                            'https://i.pinimg.com/564x/05/79/17/057917d2ef441b2e09d5a5e91a64cb08.jpg',
                      ),
                      FoodCard(
                        title: 'Frutas',
                        imageURL:
                            'https://i.pinimg.com/564x/cd/5e/8c/cd5e8cef99d7a9202fec45876d27e849.jpg',
                      ),
                      FoodCard(
                        title: 'Nueces',
                        imageURL:
                            'https://i.pinimg.com/564x/45/ba/9f/45ba9f97cd8a9a768e7c9aeae739acaa.jpg',
                      ),
                      FoodCard(
                        title: 'Comida de mar',
                        imageURL:
                            'https://i.pinimg.com/564x/c4/67/b4/c467b4e25343b42d0d4d45d2c0243e6a.jpg',
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
