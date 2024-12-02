import 'package:calorie_counter/models/Recipe.dart';
import 'package:calorie_counter/providers/db_recipes.dart';
import 'package:calorie_counter/widgets/home_page/calories_display_widget.dart';
import 'package:calorie_counter/widgets/recipes_page/recipe_card_item.dart';
import 'package:flutter/material.dart';

class FavoritesPage extends StatelessWidget {
  final DBRecipes dbRecipes = DBRecipes();

  FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Recetas'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            const SizedBox(height: 20), // Espacio entre los widgets
            Expanded(
              child: FutureBuilder<List<Recipe>>(
                future: dbRecipes.getAllRecipes(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(
                        child: Text('Error al cargar las recetas'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                        child: Text('No hay recetas registradas'));
                  } else {
                    // ListView para mostrar las comidas
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        Recipe recipe = snapshot.data![index];
                        return RecipeCardItem(recipe: recipe);
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
