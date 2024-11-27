import 'package:flutter/material.dart';

class PasswordField extends StatelessWidget {
  final bool obscureText;
  final VoidCallback onIconPressed;

  const PasswordField({
    super.key, 
    required this.obscureText,
    required this.onIconPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      validator: (value) {
        if (value!.isEmpty) {
          return "se debe completar este campo";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: 'Contraseña',
        labelStyle: const TextStyle(color: Colors.black),
        filled: true,
        fillColor: Colors.grey[200], // Fondo claro para el campo
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            obscureText ? Icons.visibility_off : Icons.visibility,
            color: Colors.black,
          ),
          onPressed: onIconPressed,
        ),
      ),
    );
  }
}