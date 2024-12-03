import 'package:calorie_counter/providers/db_authentication.dart';
import 'package:flutter/material.dart';
import 'package:calorie_counter/models/user.dart';

class EditProfilePage extends StatefulWidget {
  final User user;

  const EditProfilePage({Key? key, required this.user}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _ageController;
  late TextEditingController _weightController;
  late TextEditingController _heightController;
  late TextEditingController _genderController;
  late TextEditingController _goalController;

  @override
  void initState() {
    super.initState();
    // Inicializa los controladores con los datos actuales del usuario
    _nameController = TextEditingController(text: widget.user.name);
    _emailController = TextEditingController(text: widget.user.email);
    _ageController = TextEditingController(text: widget.user.age.toString());
    _weightController =
        TextEditingController(text: widget.user.weight.toString());
    _heightController =
        TextEditingController(text: widget.user.height.toString());
    _genderController = TextEditingController(text: widget.user.gender);
    _goalController = TextEditingController(text: widget.user.goal);
  }

  @override
  void dispose() {
    // Limpia los controladores cuando se destruye el widget
    _nameController.dispose();
    _emailController.dispose();
    _ageController.dispose();
    _weightController.dispose();
    _heightController.dispose();
    _genderController.dispose();
    _goalController.dispose();
    super.dispose();
  }

void _saveChanges() async {
  if (_formKey.currentState!.validate()) {
    // Crea un nuevo objeto User con los datos actualizados del formulario
    User updatedUser = User(
      userId: widget.user.userId, // Mantén el userId actual (si se necesita)
      name: _nameController.text,
      email: _emailController.text,
      age: int.parse(_ageController.text),
      weight: double.parse(_weightController.text),
      height: double.parse(_heightController.text),
      gender: _genderController.text,
      goal: _goalController.text,
      password: widget.user.password, // La contraseña no se modifica aquí
    );

    // Llama al método para actualizar los datos del usuario en la base de datos
    DbAuthentication dbAuthentication = DbAuthentication();
    int result = await dbAuthentication.updateUserByEmail(updatedUser);

    if (result > 0) {
      // Si la actualización fue exitosa, devuelve el usuario actualizado
      Navigator.pop(context, updatedUser);
    } else {
      // Muestra un mensaje si hubo un error al actualizar
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error al actualizar el perfil')),
      );
    }
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Perfil'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveChanges,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nombre'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Este campo es obligatorio';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration:
                    const InputDecoration(labelText: 'Correo electrónico'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Este campo es obligatorio';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _ageController,
                decoration: const InputDecoration(labelText: 'Edad'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Este campo es obligatorio';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _weightController,
                decoration: const InputDecoration(labelText: 'Peso'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Este campo es obligatorio';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _heightController,
                decoration: const InputDecoration(labelText: 'Altura'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Este campo es obligatorio';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _genderController,
                decoration: const InputDecoration(labelText: 'Género'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Este campo es obligatorio';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _goalController,
                decoration: const InputDecoration(labelText: 'Meta'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Este campo es obligatorio';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}