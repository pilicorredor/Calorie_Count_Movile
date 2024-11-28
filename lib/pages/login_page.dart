import 'package:calorie_counter/main.dart';
import 'package:calorie_counter/models/user.dart';
import 'package:calorie_counter/providers/db_authentication.dart';
import 'package:calorie_counter/providers/user_provider.dart';
import 'package:calorie_counter/widgets/login_page/login_button.dart';
import 'package:calorie_counter/widgets/login_page/password_field.dart';
import 'package:calorie_counter/widgets/login_page/username_field.dart';
import 'package:calorie_counter/widgets/login_page/welcome_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends ConsumerStatefulWidget  {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final username = TextEditingController();
  final password = TextEditingController();

  bool _obscureText = true;
  bool isLoginTrue = false;

  final db = DbAuthentication();

  login() async {
    User? userDetails = await db.getUser(username.text);
    var response =
        await db.login(User(email: username.text, password: password.text));

    if (response == true && userDetails != null) {
      if (!mounted) return;

      // Actualiza el estado global del usuario
      ref.read(userProvider.notifier).setUser(userDetails);

      Fluttertoast.showToast(
        msg: "Login exitoso!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      // Navega a la pantalla principal
      Navigator.pushReplacementNamed(context, 'home');
    } else {
      setState(() {
        isLoginTrue = true;
      });
    }
  }

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const WelcomeMessage(),
                  const SizedBox(height: 30),
                  UsernameField(controller: username),
                  const SizedBox(height: 20),
                  PasswordField(
                    controller: password,
                    obscureText: _obscureText,
                    onIconPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                  const SizedBox(height: 30),
                  LoginButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        login();
                      }
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("¿No tienes una cuenta?"),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, 'signUp');
                        },
                        child: const Text("Registrate"),
                      )
                    ],
                  ),
                  isLoginTrue
                      ? const Text(
                          "Correo electrónico o contraseña incorrectos",
                          style: TextStyle(color: Colors.red),
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
