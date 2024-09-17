import 'package:flutter/material.dart';

class AddFood extends StatefulWidget {
  const AddFood({super.key});

  @override
  _AddFoodState createState() => _AddFoodState();
}

class _AddFoodState extends State<AddFood> {
  final _formKey = GlobalKey<FormState>();

  // Controladores para los campos de texto
  final TextEditingController _foodNameController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _caloriesController = TextEditingController();

  // Almacena la opción seleccionada en la lista desplegable
  String _selectedUnit = 'gramos';

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
                items: ['gramos', 'kilos', 'porciones', 'Unidades', 'Litros'].map((String value) {
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
              const SizedBox(height: 32.0),

              // Botón para "Agregar" comida
              ElevatedButton.icon(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Aquí iría el código para agregar más alimentos
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Alimento agregado')),
                    );

                    // Limpiar los campos para ingresar otro alimento
                    _foodNameController.clear();
                    _quantityController.clear();
                    _caloriesController.clear();
                    setState(() {
                      _selectedUnit = 'gramos';
                    });
                  }
                },
                icon: const Icon(Icons.add),
                label: const Text('Agregar'),
              ),

              const SizedBox(height: 16.0),

              // Botón para "Registrar Comida"
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Aquí iría el código para finalizar y registrar la comida
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Comida registrada')),
                    );
                  }
                },
                child: const Text('Registrar Comida'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
