import 'package:calorie_counter/widgets/user_page/user_info.dart';
import 'package:calorie_counter/widgets/user_page/user_profile_header.dart';
import 'package:flutter/material.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const UserProfileHeader(
            username: 'Lucia',
            profileImageUrl: 'https://static.semrush.com/persona/personas/4436574'), // Sección del encabezado
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  const UserInfo(
                    userId: 0,
                    name: "Andrea",
                    email: 'lucia123@example.com',
                    age: 23,
                    weight: 65,
                    height: 1.65,
                    gender: 'Femenino',
                    goal: 'Bajar peso',
                    password: "",
                  ), // Sección de información
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: () {
                      // Acción de editar perfil
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(156, 40, 177, 1.0),
                      foregroundColor: Colors.white,
                    ),
                    icon: const Icon(Icons.edit),
                    label: const Text('Editar Perfil'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
