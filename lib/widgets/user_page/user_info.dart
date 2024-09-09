import 'package:calorie_counter/widgets/user_page/user_info_row.dart';
import 'package:flutter/material.dart';

class UserInfo extends StatelessWidget {
  final String email;
  final int age;
  final double weight;
  final double height;
  final String gender;
  final String goal;
  
  const UserInfo({
    super.key,
    required this.email,
    required this.age,
    required this.weight,
    required this.height,
    required this.gender,
    required this.goal,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UserInfoRow(
          icon: Icons.email,
          label: 'Correo:',
          value: email,
        ),
        UserInfoRow(
          icon: Icons.cake,
          label: 'Edad:',
          value: '$age años',
        ),
        UserInfoRow(
          icon: Icons.monitor_weight,
          label: 'Peso:',
          value: '$weight kg',
        ),
        UserInfoRow(
          icon: Icons.height,
          label: 'Altura:',
          value: '${height.toStringAsFixed(2)} m',
        ),
        UserInfoRow(
          icon: gender == 'Femenino' ? Icons.female : Icons.male,
          label: 'Género:',
          value: gender,
        ),
        UserInfoRow(
          icon: Icons.fitness_center,
          label: 'Objetivo:',
          value: goal,
        ),
      ],
    );
  }
}