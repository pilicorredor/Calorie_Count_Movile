import 'package:calorie_counter/models/category_model.dart';
import 'package:calorie_counter/utils/constants.dart';
import 'package:calorie_counter/utils/icon_list.dart';
import 'package:calorie_counter/utils/utils.dart';
import 'package:calorie_counter/widgets/addItems/category_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';

class AddFood extends StatefulWidget {

  const AddFood({super.key});

  @override
  State<AddFood> createState() => _AddFoodState();
}

class _AddFoodState extends State<AddFood> {
  final _formKey = GlobalKey<FormState>();
  var catList = CategoryList().catList;
  
  // Controladores para los campos de texto
  final TextEditingController _foodNameController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _caloriesController = TextEditingController();
  final TextEditingController _newCategoryController = TextEditingController();

  // Almacena la categoría seleccionada
  String _selectedCategory = 'Selecciona Categoría';
  String _selectedUnit = 'gramos';

  final List<String> _categories = ['Frutas', 'Verduras', 'Postres'];
  String? _selectedIcon;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Comida'),
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

              // Campo de texto para el nombre del alimento
              TextFormField(
                controller: _foodNameController,
                decoration: const InputDecoration(
                  labelText: 'Nombre del alimento',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa el nombre del alimento';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),

              // Campo de texto para la cantidad
              TextFormField(
                controller: _quantityController,
                decoration: const InputDecoration(
                  labelText: 'Cantidad',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa la cantidad';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Por favor, ingresa un número válido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),

              // Dropdown para seleccionar la unidad de medida
              DropdownButtonFormField<String>(
                value: _selectedUnit,
                items: ['gramos', 'kilos', 'porciones', 'Unidades', 'Litros']
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selectedUnit = newValue!;
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'Unidad de medida',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),

              // Campo de texto para las calorías
              TextFormField(
                controller: _caloriesController,
                decoration: const InputDecoration(
                  labelText: 'Calorías',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa las calorías';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Por favor, ingresa un número válido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),

              // Botón para seleccionar la categoría
              GestureDetector(
                onTap: _selectCategory,
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.category_outlined, size: 30.0),
                      const SizedBox(width: 16.0),
                      Text(
                        _selectedCategory,
                        style: const TextStyle(fontSize: 16.0),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32.0),

              // Botón para "Agregar" comida
              ElevatedButton.icon(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Alimento agregado')),
                    );
                    _foodNameController.clear();
                    _quantityController.clear();
                    _caloriesController.clear();
                    setState(() {
                      _selectedUnit = 'gramos';
                      _selectedCategory = 'Selecciona Categoría';
                    });
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


void _selectCategory() {
  final categoryList = CategoryList().catList; // Obtener la lista de categorías

  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Column(
        mainAxisSize: MainAxisSize.min, // Para que el modal ajuste su tamaño
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: categoryList.length,
              itemBuilder: (context, index) {
                var category = categoryList[index];
                return ListTile(
                  leading: Icon(
                    category.icon.toIcon(), 
                    color: Theme.of(context).iconTheme.color,
                    size: 35.0,
                  ),
                  title: Text(category.category),
                  onTap: () {
                    setState(() {
                      _selectedCategory = category.category;
                    });
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ),
          ListTile(
            leading: const Icon(Icons.add),
            title: const Text('Crear nueva categoría'),
            onTap: () {
              Navigator.pop(context); // Cierra el modal
              _showCreateCategoryDialog(); // Muestra el diálogo para crear una nueva categoría
            },
          ),
        ],
      );
    },
  );
}


// Muestra el diálogo para crear una nueva categoría
void _showCreateCategoryDialog() {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Crear nueva categoría'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Campo de texto para el nombre de la categoría
              TextField(
                controller: _newCategoryController,
                decoration: const InputDecoration(
                  hintText: 'Nombre de la categoría',
                ),
              ),
              const SizedBox(height: 16.0),

              // Botón para seleccionar el ícono
              GestureDetector(
                onTap: _selectIcon, // Abre el diálogo para seleccionar ícono
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.insert_emoticon, size: 30.0),
                      const SizedBox(width: 16.0),
                      Text(
                        _selectedIcon != null
                            ? 'Ícono seleccionado: $_selectedIcon'
                            : 'Seleccionar Ícono',
                        style: const TextStyle(fontSize: 16.0),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16.0),

              // Botón para seleccionar el color
              GestureDetector(
                onTap: _selectColor, // Abre el diálogo para seleccionar color
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: FeaturesModel().color.toColor(),
                        radius: 18.0, // Tamaño del círculo
                      ),
                      const SizedBox(width: 16.0),
                      Text(
                        'Seleccionar Color',
                        style: const TextStyle(fontSize: 16.0),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (_newCategoryController.text.isNotEmpty &&
                  _selectedIcon != null &&
                  FeaturesModel().color != null) {
                setState(() {
                  _categories.add(_newCategoryController.text);
                  _selectedCategory = _newCategoryController.text;
                });
                Navigator.pop(context);
              }
            },
            child: const Text('Crear'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancelar'),
          ),
        ],
      );
    },
  );
}

// Método para seleccionar un color
void _selectColor() {
  showModalBottomSheet(
    shape: Constants.bottomSheet(),
    isDismissible: false,
    context: context,
    builder: (context) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          MaterialColorPicker(
            selectedColor: FeaturesModel().color.toColor(),
            physics: const NeverScrollableScrollPhysics(),
            circleSize: 50.0,
            onColorChange: (Color color) {
              var hexColor =
                  '#${color.value.toRadixString(16).substring(2, 8)}';
              setState(() {
                FeaturesModel().color = hexColor; // Actualiza el color en el modelo
              });
            },
          ),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Constants.customButton(
              Colors.green,
              Colors.transparent,
              'Listo',
            ),
          ),
        ],
      );
    },
  );
}


// Muestra el diálogo con la cuadrícula de íconos
  void _selectIcon() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Selecciona un ícono'),
          content: SizedBox(
            width: double.maxFinite,
            child: GridView.builder(
              shrinkWrap: true,
              itemCount: IconList().iconMap.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5, // Número de íconos por fila
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
              ),
              itemBuilder: (context, index) {
                String key = IconList().iconMap.keys.elementAt(index);
                IconData icon = IconList().iconMap[key]!;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedIcon = key; // Guardar el ícono seleccionado
                    });
                    Navigator.pop(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: _selectedIcon == key
                            ? Colors.blue
                            : Colors.transparent,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Icon(icon, size: 30.0),
                  ),
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }
}
