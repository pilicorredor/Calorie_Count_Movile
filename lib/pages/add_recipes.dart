import 'package:flutter/material.dart';

class AddRecipes extends StatefulWidget {
  const AddRecipes({super.key});

  @override
  _AddRecipes createState() => _AddRecipes();
}

class _AddRecipes extends State<AddRecipes> {
  final _formKey = GlobalKey<FormState>();

  // Controladores para los campos de texto
  final TextEditingController _recipeNameController = TextEditingController();
  final TextEditingController _ingredientsController = TextEditingController();
  final TextEditingController _preparationStepsController = TextEditingController();

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
                onTap: () {
                  // Aquí iría el código para seleccionar una imagen
                },
                child: Container(
                  height: 150,
                  color: Colors.grey[300],
                  child: const Icon(
                    Icons.add_a_photo,
                    size: 50,
                    color: Colors.grey,
                  ),
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
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Receta agregada')),
                    );

                    // Limpiar los campos
                    _recipeNameController.clear();
                    _ingredientsController.clear();
                    _preparationStepsController.clear();
                  }
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
