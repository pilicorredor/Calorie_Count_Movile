import 'package:flutter/material.dart';

class CaloriesDisplayWidget extends StatelessWidget {
  final Future<double> futureCalories;
  final Icon icon; 
  final String text;

  // Constructor que recibe el Future como parámetro
  const CaloriesDisplayWidget({super.key, required this.futureCalories, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<double>(
      future: futureCalories,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildCard(
            child: const Text(
              'Calculando calorías...',
              style: TextStyle(fontSize: 18, color: Colors.blueGrey),
            ),
          );
        } else if (snapshot.hasError) {
          return _buildCard(
            child: const Text(
              'Error al obtener las calorías',
              style: TextStyle(fontSize: 18, color: Colors.redAccent),
            ),
          );
        } else {
          final caloriesForDay = snapshot.data ?? 0.0;
          return _buildCard(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon,
                const SizedBox(height: 8),
                Text(
                  text,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${caloriesForDay.toStringAsFixed(1)} kcal',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  // Método para construir la tarjeta con un diseño moderno
  Widget _buildCard({required Widget child}) {
    return Container(
      padding:const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 10,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Center(child: child),
    );
  }
}
