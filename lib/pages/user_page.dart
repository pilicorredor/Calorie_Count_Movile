import 'package:calorie_counter/models/user.dart';
import 'package:calorie_counter/widgets/user_page/user_info.dart';
import 'package:calorie_counter/widgets/user_page/user_profile_header.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UserPage extends StatelessWidget {
  final User? user;

  const UserPage({Key? key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          UserProfileHeader(
              username: user?.name ?? 'Guest',
              profileImageUrl:
                  'https://static.semrush.com/persona/personas/4436574'), // Sección del encabezado
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
                  UserInfo(
                    userId: user?.userId ?? 0,
                    name: user?.name ?? 'Guest',
                    email: user?.email ?? 'Guest',
                    age: user?.age ?? 0,
                    weight: user?.weight ?? 0,
                    height: user?.height ?? 0,
                    gender: user?.gender ?? 'Guest',
                    goal: user?.goal ?? 'Guest',
                    password: user?.password ?? 'Guest',
                  ), // Sección de información
                  const SizedBox(height: 10),
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

                  const SizedBox(height: 10),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, 'login');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(156, 40, 177, 1.0),
                      foregroundColor: Colors.white,
                    ),
                    icon: const Icon(Icons.output_outlined),
                    label: const Text('Cerrar Sesión'),
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
