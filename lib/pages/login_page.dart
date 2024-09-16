import 'package:calorie_counter/widgets/login_page/login_button.dart';
import 'package:calorie_counter/widgets/login_page/password_field.dart';
import 'package:calorie_counter/widgets/login_page/register_button.dart';
import 'package:calorie_counter/widgets/login_page/username_field.dart';
import 'package:calorie_counter/widgets/login_page/welcome_message.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Fondo blanco
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const WelcomeMessage(), // Mensaje de bienvenida
                const SizedBox(height: 30),
                const UsernameField(), // Campo de usuario
                const SizedBox(height: 20),
                PasswordField(obscureText: _obscureText, onIconPressed: () {
                  setState(() {
                    _obscureText = !_obscureText; // Alternar visibilidad
                  });
                }),
                const SizedBox(height: 30),
                LoginButton(onPressed: () {
                  // Lógica de login
                  Navigator.pushReplacementNamed(context, 'home');
                }),
                const SizedBox(height: 20),
                RegisterButton(onPressed: () {
                  // Acción para el registro (actualmente no hace nada)
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

