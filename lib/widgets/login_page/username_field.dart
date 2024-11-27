import 'package:flutter/material.dart';

// Widget para el campo de usuario
class UsernameField extends StatelessWidget {
  final TextEditingController controller;

  const UsernameField({super.key, required this.controller});
  

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (value) {
        if (value!.isEmpty) {
          return "se debe completar este campo";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: 'Correo o Nombre de Usuario',
        labelStyle: const TextStyle(color: Colors.black),
        filled: true,
        fillColor: Colors.grey[200], // Fondo claro para el campo
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12), // Bordes redondeados
        ),
      ),
    );
  }
}
