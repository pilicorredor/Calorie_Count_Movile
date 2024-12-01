import 'package:calorie_counter/models/user.dart';
import 'package:calorie_counter/providers/db_authentication.dart';
import 'package:calorie_counter/widgets/signup_page/password_field_signup.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _dateController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  final name = TextEditingController();
  final email = TextEditingController();
  final age = TextEditingController();
  final weight = TextEditingController();
  final height = TextEditingController();
  ValueNotifier<String?> gender = ValueNotifier<String?>(null);
  final goal = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _obscureTextPassword = true;
  bool _obscureTextConfirmPassword = true;

  final formKey = GlobalKey<FormState>();

  // Método para abrir el selector de fecha
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      locale: const Locale('es', 'CO'),
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _dateController.text = DateFormat('dd/MM/yyyy')
            .format(selectedDate); // Actualiza el controlador
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // Inicializa el controlador con la fecha actual
    _dateController.text = DateFormat('dd/MM/yyyy').format(selectedDate);
  }

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
                  const Text(
                    "Registro",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 30),

                  // Campo de Nombre
                  TextFormField(
                    controller: name,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "se debe completar este campo";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(labelText: "Nombre"),
                  ),
                  const SizedBox(height: 20),

                  // Campo de Correo
                  TextFormField(
                    controller: email,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "se debe completar este campo";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(labelText: "Correo"),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 20),

                  // Campo de Fecha de Cumpleaños
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "se debe completar este campo";
                      }
                      return null;
                    },
                    readOnly: true, // Hace que el campo sea solo de lectura
                    controller:
                        _dateController, // Muestra la fecha seleccionada
                    decoration: InputDecoration(
                      labelText: "Fecha de cumpleaños",
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.calendar_today),
                        onPressed: () => _selectDate(context),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Campo de Altura
                  TextFormField(
                    controller: height,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "se debe completar este campo";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(labelText: "Altura (cm)"),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 20),

                  // Campo de Peso
                  TextFormField(
                    controller: weight,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "se debe completar este campo";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(labelText: "Peso (Kg)"),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 20),

                  // Campo de Género
                  ValueListenableBuilder<String?>(
                    valueListenable: gender, // Escuchamos los cambios en gender
                    builder: (context, value, child) {
                      return DropdownButtonFormField<String>(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Se debe completar este campo";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(labelText: "Género"),
                        value: value, // Valor seleccionado
                        items: const [
                          DropdownMenuItem(
                              value: "Masculino", child: Text("Masculino")),
                          DropdownMenuItem(
                              value: "Femenino", child: Text("Femenino")),
                          DropdownMenuItem(value: "Otro", child: Text("Otro")),
                        ],
                        onChanged: (selectedValue) {
                          gender.value = selectedValue; // Actualizamos el valor
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 20),

                  // Campo de Objetivo
                  TextFormField(
                    controller: goal,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "se debe completar este campo";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(labelText: "Objetivo"),
                  ),

                  // Campo de Contraseña
                  PasswordFieldSignUp(
                    obscureText: _obscureTextPassword,
                    controller: _passwordController,
                    title: "Contraseña",
                    onIconPressed: () {
                      setState(() {
                        _obscureTextPassword = !_obscureTextPassword;
                      });
                    },
                    validator: (value) {
                      print(password);
                      print(value);

                      if (value == null || value.isEmpty) {
                        print("completar");
                        return "Se debe completar este campo";
                      }
                      if (value.length < 8) {
                        return "La contraseña debe tener al menos 8 caracteres";
                      } else {
                        print("null");
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 20),

                  // Campo de Confirmar Contraseña
                  PasswordFieldSignUp(
                    obscureText: _obscureTextConfirmPassword,
                    controller: _confirmPasswordController,
                    title: "Confirmar Contraseña",
                    onIconPressed: () {
                      setState(() {
                        _obscureTextConfirmPassword =
                            !_obscureTextConfirmPassword;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Se debe completar este campo";
                      }
                      if (value != _passwordController.text) {
                        return "Las contraseñas no coinciden";
                      } else {
                        return null;
                      }
                    },
                  ),

                  const SizedBox(height: 30),
                  // Botón de Registro
                  ElevatedButton(
                    onPressed: () {
                      // Lógica de registro
                      print(password);
                      print(confirmPassword);
                      if (formKey.currentState!.validate()) {
                        
                        final db = DbAuthentication();
                        db
                            .signup(User(
                                name: name.text,
                                email: email.text,
                                //pendiente metodo edad
                                //age: calculateAge(_dateController as DateTime),
                                age: 0,
                    
                                weight: double.parse(weight.text),
                                height: double.parse(height.text),
                                gender: gender.value,
                                goal: goal.text,
                                password: _passwordController.text))
                            .whenComplete(() {
                          // ignore: use_build_context_synchronously
                          Fluttertoast.showToast(
                            msg: "Registro exitoso!",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Colors.black,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                          Navigator.pushReplacementNamed(context, 'login');
                          print(age);
                        });
                      }
                    },
                    child: const Text("Registrar"),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("¿Ya tienes una cuenta?"),
                      TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, 'login');
                          },
                          child: const Text("Inicia Sesión"))
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

  int calculateAge(DateTime birthDate) {
    DateTime today = DateTime.now();
    int age = today.year - birthDate.year;
    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      age--; // Si no ha cumplido años este año, se resta uno
    }
    return age;
  }
}
