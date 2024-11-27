import 'package:flutter/material.dart';

class PasswordFieldSignUp extends StatelessWidget {
  final bool obscureText;
  final VoidCallback onIconPressed;
  final String title;
  final String? Function(String?)? validator;
  final TextEditingController controller;

  const PasswordFieldSignUp({
    Key? key,
    required this.obscureText,
    required this.onIconPressed,
    required this.title,
    required this.validator,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller, // Usamos el controlador para manejar el texto
      obscureText: obscureText,
      validator: validator,
      decoration: InputDecoration(
        labelText: title,
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