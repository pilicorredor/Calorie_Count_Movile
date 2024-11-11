import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:pedometer/pedometer.dart';

class StepCounterWidget extends StatefulWidget {
  const StepCounterWidget({super.key});


@override
  State<StepCounterWidget> createState() => _StepCounterWidgetState();

  }

class _StepCounterWidgetState extends State<StepCounterWidget> {
  String _stepCount = '0';
  final Logger _logger = Logger();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  void initPlatformState() {
    Pedometer.stepCountStream.listen(
      (event) {
        _logger.d("Número de pasos detectados: ${event.steps}");
        setState(() => _stepCount = event.steps.toString());
      },
      onError: (error) {
        _logger.e("Error en el sensor de pasos: $error");
      },
      onDone: () {
        _logger.d("El stream del pedómetro se ha detenido");
      },
    );

    Pedometer.pedestrianStatusStream.listen(
      (status) {
        _logger.d("Estado del sensor de pasos: $status");
      },
      onError: (error) {
        _logger.e("Error en el estado del sensor: $error");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.3),
            blurRadius: 10,
            spreadRadius: 1,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.directions_walk,
            size: 60,
            color: Colors.white,
          ),
          SizedBox(height: 20),
          Text(
            'Pasos registrados:',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 10),
          Text(
            _stepCount != '0' ? _stepCount : 'Sensor no disponible o sin actividad',
            style: TextStyle(
              color: Colors.white,
              fontSize: 48,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}