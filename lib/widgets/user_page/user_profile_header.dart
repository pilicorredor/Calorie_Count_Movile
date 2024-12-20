import 'package:flutter/material.dart';

class UserProfileHeader extends StatelessWidget {
  final String username;
  final String profileImageUrl;

  const UserProfileHeader({
    super.key,
    required this.username,
    required this.profileImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // Ocupa todo el ancho
      padding: const EdgeInsets.symmetric(
          horizontal: 20.0, vertical: 26.0), // Espacio superior agregado
      decoration: const BoxDecoration(
        color: Color.fromRGBO(111, 40, 176, 1.0), // Color morado
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(
              height: 20), // Espacio extra para mover la foto hacia abajo
          CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage(profileImageUrl),
          ),
          const SizedBox(height: 20),
          Text(
            '¡Bienvenida $username!',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
