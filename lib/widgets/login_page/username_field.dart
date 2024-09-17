import 'package:flutter/material.dart';

// Widget para el campo de usuario
class UsernameField extends StatelessWidget {
  const UsernameField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
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