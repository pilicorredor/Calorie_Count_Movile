import 'dart:io';

import 'package:calorie_counter/models/Recipe.dart';
import 'package:calorie_counter/providers/db_recipes.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddRecipes extends StatefulWidget {
  const AddRecipes({super.key});

  @override
  _AddRecipes createState() => _AddRecipes();
}

class _AddRecipes extends State<AddRecipes> {
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  XFile? _selectedImage;

  // Controladores para los campos de texto
  final TextEditingController _recipeNameController = TextEditingController();
  final TextEditingController _ingredientsController = TextEditingController();
  final TextEditingController _preparationStepsController =
      TextEditingController();

  final DBRecipes dbRecipes = DBRecipes();

  Future<void> _selectImageRecipe() async {
    // Mostrar diálogo de selección
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Seleccionar opción'),
          content: const Text(
              'Elige si deseas tomar una foto o seleccionarla de la galería.'),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop(); // Cerrar el diálogo
                final XFile? pickedFile =
                    await _picker.pickImage(source: ImageSource.camera);
                setState(() {
                  _selectedImage = pickedFile;
                });
              },
              child: const Text('Tomar foto'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop(); // Cerrar el diálogo
                final XFile? pickedFile =
                    await _picker.pickImage(source: ImageSource.gallery);
                setState(() {
                  _selectedImage = pickedFile;
                });
              },
              child: const Text('Seleccionar de galería'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar receta'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Campo para seleccionar una imagen
              GestureDetector(
                onTap: _selectImageRecipe,
                child: Container(
                  height: 150,
                  color: Colors.grey[300],
                  child: _selectedImage != null
                      ? Image.file(File(_selectedImage!.path))
                      : const Icon(Icons.add_a_photo,
                          size: 50, color: Colors.grey),
                ),
              ),
              const SizedBox(height: 16.0),

              // Campo de texto para el nombre de la receta
              TextFormField(
                controller: _recipeNameController,
                decoration: const InputDecoration(
                  labelText: 'Nombre de la receta',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa el nombre de la receta';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),

              // Campo de texto para los ingredientes
              TextFormField(
                controller: _ingredientsController,
                decoration: const InputDecoration(
                  labelText: 'Ingredientes (separados por comas)',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa los ingredientes';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),

              // Campo de texto para los pasos de preparación
              TextFormField(
                controller: _preparationStepsController,
                decoration: const InputDecoration(
                  labelText: 'Pasos de preparación',
                  border: OutlineInputBorder(),
                ),
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa los pasos de preparación';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32.0),

              // Botón para "Agregar" receta
              ElevatedButton.icon(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    // Si hay imagen seleccionada, guarda su ruta como texto
                    String imagePath = _selectedImage?.path ?? '';

                    Recipe newRecipe = Recipe(
                      name: _recipeNameController.text,
                      ingredients: _ingredientsController.text,
                      preparationSteps: _preparationStepsController.text,
                      imagePath: imagePath,
                    );

                    int response = await dbRecipes.addNewRecipe(newRecipe);

                    if (response > 0) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Receta agregada')),
                      );

                      _recipeNameController.clear();
                      _ingredientsController.clear();
                      _preparationStepsController.clear();
                      setState(() {
                        _selectedImage = null;
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Error al agregar la receta')),
                      );
                    }
                  }
                  List<Recipe> recipes = await dbRecipes.getAllRecipes();
                },
                icon: const Icon(Icons.add),
                label: const Text('Agregar receta'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
