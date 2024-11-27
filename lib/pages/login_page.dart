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
  final username = TextEditingController();
  final password = TextEditingController();

  bool _obscureText = true;

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Fondo blanco
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
                key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const WelcomeMessage(), // Mensaje de bienvenida
                  const SizedBox(height: 30),
                  const UsernameField(), // Campo de usuario
                  const SizedBox(height: 20),
                  PasswordField(
                      obscureText: _obscureText,
                      onIconPressed: () {
                        setState(() {
                          _obscureText = !_obscureText; // Alternar visibilidad
                        });
                      }),
                  const SizedBox(height: 30),
                  LoginButton(onPressed: () {
                    // Lógica de login
                    if(formKey.currentState!.validate()){
                        Navigator.pushReplacementNamed(context, 'home');
                    }
                  }),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("¿No tienes una cuenta?"),
                      TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, 'signUp');
                          },
                          child: const Text("Registrate"))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
