import 'package:calorie_counter/widgets/charts_page/custom_linear_chart.dart';
import 'package:calorie_counter/widgets/charts_page/custom_title_card.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ChartsPage extends StatelessWidget {
  const ChartsPage({super.key});

  @override
  Widget build(BuildContext context) 
 {
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
              const CustomTitleCard( label: 'Cronología de tu peso',),
              const SizedBox(height: 16.0),
              CustomLinearChart(spotsList: weightData),
              const SizedBox(height: 16.0),
              const CustomTitleCard( label: 'Calorías consumidad diariamente',),
              const SizedBox(height: 16.0),
              CustomLinearChart(spotsList: caloriesData),

            ],
          ),
        ),
      ),
    );
  }

  List<FlSpot> get weightData {
    return [
    const FlSpot(1, 58.3),
    const FlSpot(2, 59),
    const FlSpot(3, 58),
    const FlSpot(4, 58),
    const FlSpot(5, 57.3),
    const FlSpot(6, 57),
    const FlSpot(7, 57.2),
  ];
  }
  
  List<FlSpot> get caloriesData {
    return [
    const FlSpot(1, 1500), // Día 1, 1500 calorías
    const FlSpot(2, 1800), // Día 2, 1800 calorías
    const FlSpot(3, 1650), // Día 3, 1650 calorías
    const FlSpot(4, 1720), // Día 4, 1720 calorías
    const FlSpot(5, 1900), // Día 5, 1900 calorías
    const FlSpot(6, 1400), // Día 6, 1400 calorías
   const FlSpot(7, 1750), // Día 7, 1750 calorías
    const FlSpot(8, 1600), // Día 8, 1600 calorías
  ];
  }

}