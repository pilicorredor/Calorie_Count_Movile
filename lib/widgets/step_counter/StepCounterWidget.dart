import 'dart:async';
import 'package:flutter/material.dart';

class StepCounterWidget extends StatelessWidget {
  final Future<int> futureSteps;

  const StepCounterWidget({super.key, required this.futureSteps});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int>(
      future: futureSteps,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildCard(
            child: const Text(
              'Contando pasos...',
              style: TextStyle(fontSize: 18, color: Colors.blueGrey),
            ),
          );
        } else if (snapshot.hasError) {
          return _buildCard(
            child: const Text(
              'Error al obtener los pasos',
              style: TextStyle(fontSize: 18, color: Colors.redAccent),
            ),
          );
        } else {
          final stepsForDay = snapshot.data ?? 0;
          return _buildCard(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.directions_walk,
                  color: Colors.blueAccent,
                  size: 40,
                ),
                const SizedBox(height: 8),
                Text(
                  'Pasos del día seleccionado: ',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '$stepsForDay',
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
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Center(child: child),
    );
  }
}
