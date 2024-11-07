import 'package:calorie_counter/models/Food.dart';
import 'package:calorie_counter/models/category_model.dart';
import 'package:calorie_counter/pages/category_detail_page.dart'; // Asegúrate de importar la nueva pantalla
import 'package:calorie_counter/pages/charts_page.dart';
import 'package:calorie_counter/pages/favorites_page.dart';
import 'package:calorie_counter/pages/user_page.dart';
import 'package:calorie_counter/providers/db_foods.dart';
import 'package:calorie_counter/providers/ui_provider.dart';
import 'package:calorie_counter/widgets/addItems/category_list.dart';
import 'package:calorie_counter/widgets/custom_fab_add_food.dart';
import 'package:calorie_counter/widgets/home_page/custom_navigation_bar.dart';
import 'package:calorie_counter/widgets/home_page/food_card.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Lista de categorías
  List<CategoryModel> categories = CategoryList().getAllCategories();
  int lengthCategories = CategoryList().getLenghtCategories();
  DateTime selectedDate = DateTime.now();
  final DBFood dbFood = DBFood();

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UIProvider>(context);
    final currentIndex = uiProvider.bnbIndex; // Obtiene el índice actual

    return Scaffold(
      floatingActionButton: CustomFabAddFood(selectedDate: selectedDate),
      bottomNavigationBar: const CustomNavigationBar(),
      body: _getBody(currentIndex), // Cambia el cuerpo según el índice
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
              IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () {
                  //Navigator.pushNamed(context, 'permissions'); 
                  Navigator.pushReplacementNamed(context, '/permissions');
                  //context.push('/permissions');
                },
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRDwmG52pVI5JZfn04j9gdtsd8pAGbqjjLswg&s',
                        ),
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
                        '\n Lucia',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  EasyDateTimeLine(
                    initialDate: DateTime.now(),
                    onDateChange: (newSelectedDate) {
                      setState(() {
                        selectedDate = newSelectedDate;
                      });
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
                  // Promoción de la app
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
                          width: 70,
                        ),
                        const SizedBox(width: 10),
                        const Expanded(
                          child: Text(
                            'Un cuerpo saludable viene con buenos nutrientes.\n¡Empieza tu viaje a la salud ahora!',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  FutureBuilder<double>(
                    future: getCaloriesForSelectedDate(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Text(
                          'Calculando calorías...',
                          style: TextStyle(fontSize: 18),
                        );
                      } else if (snapshot.hasError) {
                        return const Text(
                          'Error al obtener las calorías',
                          style: TextStyle(fontSize: 18, color: Colors.red),
                        );
                      } else {
                        final caloriesForDay = snapshot.data ?? 0.0;
                        return Text(
                          'Calorías consumidas este día: ${caloriesForDay.toStringAsFixed(1)} kcal',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      }
                    },
                  ),
                  const Text(
                    'Categorías',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Lista de categorías
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: lengthCategories,
                    itemBuilder: (context, index) {
                      final category = categories[index];
                      return FoodCard(
                        category: category,
                        onTap: () =>
                            _navigateToCategoryDetail(category.categoryName),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      case 1:
        return const FavoritesPage(); // Cambiar por tu página de gráficos
      case 2:
        return const ChartsPage(); // Cambiar por tu página de favoritos
      case 3:
        return const UserPage(); // Cambiar por tu página de usuario
      default:
        return const Center(child: Text('Página no encontrada'));
    }
  }

  // Método para navegar a la pantalla de detalle de la categoría
  void _navigateToCategoryDetail(String categoryName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CategoryDetailPage(
            selectedDate: selectedDate, categoryName: categoryName),
      ),
    );
  }

  // Método para obtener calorías del día seleccionado
  Future<double> getCaloriesForSelectedDate() async {
    String formattedDate = DateFormat('dd/MM/yyyy').format(selectedDate);
    List<Food> foods = await dbFood.getFoodsByDate(formattedDate);
    double totalCalories = foods.fold(0, (sum, food) => sum + food.calories);
    return totalCalories;
  }
}
