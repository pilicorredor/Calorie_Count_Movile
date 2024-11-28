import 'package:calorie_counter/models/user.dart';
import 'package:calorie_counter/pages/edit_profile_page.dart';
import 'package:calorie_counter/pages/home_page.dart';
import 'package:calorie_counter/pages/login_page.dart';
import 'package:calorie_counter/widgets/user_page/user_info.dart';
import 'package:calorie_counter/widgets/user_page/user_profile_header.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UserPage extends StatefulWidget {
  final User? user;

  const UserPage({Key? key, this.user}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  late User? currentUser;

  @override
  void initState() {
    super.initState();
    currentUser = widget.user;
    print('Usuario inicializado en UserPage: $currentUser');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            print('Detalles del usuario regreso home: $currentUser');
            Navigator.pop(context, currentUser); // Vuelve a la pantalla anterior
          },
        ),
      ),
      body: Column(
        children: [
          UserProfileHeader(
            username: currentUser?.name ?? 'Guest',
            profileImageUrl:
                'https://static.semrush.com/persona/personas/4436574', // Sección del encabezado
          ),
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
                    userId: currentUser?.userId ?? 0,
                    name: currentUser?.name ?? 'Guest',
                    email: currentUser?.email ?? 'Guest',
                    age: currentUser?.age ?? 1,
                    weight: currentUser?.weight ?? 0,
                    height: currentUser?.height ?? 0,
                    gender: currentUser?.gender ?? 'Guest',
                    goal: currentUser?.goal ?? 'Guest',
                    password: currentUser?.password ?? 'Guest',
                  ), // Sección de información
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: () async {
                      // Navegar a la página de edición de perfil y esperar el retorno del usuario actualizado
                      final updatedUser = await Navigator.push<User>(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditProfilePage(
                              user: currentUser!), // Pasa el objeto currentUser
                        ),
                      );

                      if (updatedUser != null) {
                        // Si se ha editado el perfil, muestra el mensaje y actualiza el usuario

                        Fluttertoast.showToast(msg: "Perfil actualizado");
                        setState(() {
                          currentUser =
                              updatedUser; // Actualiza el estado con el nuevo usuario
                          print(
                              'Detalles del usuario Perfil actualizado: $currentUser');
                        });
                      } else {
                        currentUser = currentUser;
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(156, 40, 177, 1.0),
                      foregroundColor: Colors.white,
                    ),
                    icon: const Icon(Icons.edit),
                    label: const Text('Editar Perfil'),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: () {
                      currentUser = null;
                      print('Detalles del usuario signout: $currentUser');

                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const LoginPage()), // Reemplaza LoginPage con tu pantalla de login
                        (Route<dynamic> route) =>
                            false, // Esta condición asegura que todas las rutas anteriores sean eliminadas
                      );
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
