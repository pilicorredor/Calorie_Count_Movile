import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class CustomLinearChart extends StatelessWidget {
  final List<FlSpot> spotsList;
  const CustomLinearChart({super.key, required this.spotsList});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2.0,
      child: LineChart(
        LineChartData(
          lineBarsData: [
            LineChartBarData(
              spots: spotsList,
              isCurved: true,
              gradient: const LinearGradient(
                colors: [Color.fromRGBO(156, 40, 177, 1.0), Color(0xFF6F28B0)],
              ),
            ),
          ],
        ),
      ),
    );
  }
}