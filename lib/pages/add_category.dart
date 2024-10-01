import 'package:flutter/material.dart';
import 'dart:io';
import 'package:calorie_counter/models/category.dart';

class AddCategory extends StatefulWidget {
  final Function(Category) onAddCategory; // Callback para agregar categoría

  const AddCategory({super.key, required this.onAddCategory});

  @override
  _AddCategoryState createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _categoryNameController = TextEditingController();
  File? _image;

  // Método para seleccionar una imagen de la galería
  Future<void> _pickImage() async {
    // Implementa aquí la lógica para seleccionar una imagen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Categoría'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Campo para seleccionar una imagen
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                    image: _image != null
                        ? DecorationImage(
                            image: FileImage(_image!),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: _image == null
                      ? const Icon(
                          Icons.add_a_photo,
                          size: 50,
                          color: Colors.grey,
                        )
                      : null,
                ),
              ),
              const SizedBox(height: 16.0),

              // Campo de texto para el nombre de la categoría
              TextFormField(
                controller: _categoryNameController,
                decoration: const InputDecoration(
                  labelText: 'Nombre de la categoría',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa el nombre de la categoría';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32.0),

              // Botón para "Agregar" categoría
              ElevatedButton.icon(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Obtener el nombre de la categoría
                    String categoryName = _categoryNameController.text;

                    // Establecer la URL de la imagen
                    String imageUrl = _image != null
                        ? _image!.path // Si se seleccionó una imagen, se utiliza su ruta
                        : 'https://www.example.com/default-image.png'; // URL por defecto

                    // Llamar al callback para agregar la categoría
                    widget.onAddCategory(Category(name: categoryName, imageUrl: imageUrl));

                    // Limpiar los campos para ingresar otra categoría
                    _categoryNameController.clear();
                    setState(() {
                      _image = null;
                    });

                    // Volver a la página anterior
                    Navigator.pop(context);
                  }
                },
                icon: const Icon(Icons.add),
                label: const Text('Agregar'),
              ),
              const SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }
}
