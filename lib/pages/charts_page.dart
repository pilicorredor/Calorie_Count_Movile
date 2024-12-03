import 'package:calorie_counter/widgets/charts_page/custom_linear_chart.dart';
import 'package:calorie_counter/widgets/charts_page/custom_title_card.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ChartsPage extends StatelessWidget {
  const ChartsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi progreso'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomTitleCard(label: 'Cronología de tu peso'),
              const SizedBox(height: 16.0),
              CustomLinearChart(spotsList: weightData),
              const SizedBox(height: 16.0),
              const CustomTitleCard(label: 'Calorías consumidas diariamente'),
              const SizedBox(height: 16.0),
              CustomLinearChart(spotsList: caloriesConsumedData),
              const SizedBox(height: 16.0),
              const CustomTitleCard(label: 'Calorías gastadas diariamente'),
              const SizedBox(height: 16.0),
              CustomLinearChart(spotsList: caloriesBurnedData),
              const SizedBox(height: 16.0),
              const CustomTitleCard(label: 'Historial de pasos diarios'),
              const SizedBox(height: 16.0),
              CustomLinearChart(spotsList: stepsData),
            ],
          ),
        ),
      ),
    );
  }

  // Datos para el peso
  List<FlSpot> get weightData => [
        const FlSpot(1, 58.3),
        const FlSpot(2, 59),
        const FlSpot(3, 58),
        const FlSpot(4, 58),
        const FlSpot(5, 57.3),
        const FlSpot(6, 57),
        const FlSpot(7, 57.2),
      ];

  // Datos de calorías consumidas
  List<FlSpot> get caloriesConsumedData => [
        const FlSpot(1, 1500),
        const FlSpot(2, 1800),
        const FlSpot(3, 1650),
        const FlSpot(4, 1720),
        const FlSpot(5, 1900),
        const FlSpot(6, 1400),
        const FlSpot(7, 1750),
      ];

  // Datos de calorías gastadas
  List<FlSpot> get caloriesBurnedData => [
        const FlSpot(1, 1800),
        const FlSpot(2, 1700),
        const FlSpot(3, 1600),
        const FlSpot(4, 1650),
        const FlSpot(5, 1850),
        const FlSpot(6, 1500),
        const FlSpot(7, 1700),
      ];

  // Datos de pasos diarios
  List<FlSpot> get stepsData => [
        const FlSpot(1, 8000),
        const FlSpot(2, 10000),
        const FlSpot(3, 9500),
        const FlSpot(4, 8700),
        const FlSpot(5, 12000),
        const FlSpot(6, 11000),
        const FlSpot(7, 10500),
      ];
}