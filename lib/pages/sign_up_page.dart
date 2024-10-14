
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SignUpPage extends StatefulWidget {
  
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
   final TextEditingController _dateController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  bool _obscureText = true;
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
        _dateController.text = DateFormat('dd/MM/yyyy').format(selectedDate); // Actualiza el controlador
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
                  decoration: const InputDecoration(labelText: "Nombre"),
                ),
                const SizedBox(height: 20),

                // Campo de Correo
                TextFormField(
                  decoration: const InputDecoration(labelText: "Correo"),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 20),

                // Campo de Fecha de Cumpleaños
                TextFormField(
                  readOnly: true, // Hace que el campo sea solo de lectura
                  controller: _dateController, // Muestra la fecha seleccionada
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
                  decoration: const InputDecoration(labelText: "Altura (cm)"),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 20),

                // Campo de Género
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: "Género"),
                  items: const [
                    DropdownMenuItem(value: "Masculino", child: Text("Masculino")),
                    DropdownMenuItem(value: "Femenino", child: Text("Femenino")),
                    DropdownMenuItem(value: "Otro", child: Text("Otro")),
                  ],
                  onChanged: (value) {},
                ),
                const SizedBox(height: 20),

                // Campo de Objetivo
                TextFormField(
                  decoration: const InputDecoration(labelText: "Objetivo"),
                ),
                const SizedBox(height: 30),

                // Botón de Registro
                ElevatedButton(
                  onPressed: () {
                    // Lógica de registro
                  },
                  child: const Text("Registrar"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}