import 'dart:async';
import 'package:calorie_counter/providers/db_steps.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:pedometer/pedometer.dart';
import 'package:intl/intl.dart';

class StepCounterWidget extends StatefulWidget {
  final String date;

  const StepCounterWidget({super.key, required this.date});

  @override
  State<StepCounterWidget> createState() => _StepCounterWidgetState();
}

class _StepCounterWidgetState extends State<StepCounterWidget> {
  int _stepCount = 0;
  int _stepsSinceLastSave = 0;
  final Logger _logger = Logger();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _loadStepsForDate(widget.date);
    if (_isToday(widget.date)) {
      _initializeStepListener();
      _startPeriodicSave();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  bool _isToday(String date) {
    final today = DateFormat('dd/MM/yyyy').format(DateTime.now());
    return date == today;
  }

  Future<void> _loadStepsForDate(String date) async {
    final stepsForDate = await StepsDatabase.instance.getStepsByDate(date);
    if (stepsForDate.isNotEmpty) {
      setState(() => _stepCount = stepsForDate.first.stepCount);
    }
  }

  Future<void> _initializeStepListener() async {
    Pedometer.stepCountStream.listen(
      (event) {
        _logger.d("Número de pasos detectados: ${event.steps}");

        // Calcular pasos desde la última actualización
        int newSteps = event.steps - _stepCount;
        _stepsSinceLastSave += newSteps;

        setState(() => _stepCount = event.steps);
      },
      onError: (error) {
        _logger.e("Error en el sensor de pasos: $error");
      },
    );
  }

  void _startPeriodicSave() {
    _timer = Timer.periodic(Duration(minutes: 5), (timer) async {
      if (_stepsSinceLastSave > 0) {
        await _saveSteps();
        _stepsSinceLastSave = 0; // Reinicia el conteo de pasos desde la última guardada
      }
    });
  }

  Future<void> _saveSteps() async {
    String today = DateFormat('dd/MM/yyyy').format(DateTime.now());
    await StepsDatabase.instance.updateStepsForDate(today, _stepCount);
    _logger.d("Pasos guardados en la base de datos: $_stepCount");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.3),
            blurRadius: 10,
            spreadRadius: 1,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            Icons.directions_walk,
            size: 60,
            color: Colors.white,
          ),
          const SizedBox(height: 20),
          const Text(
            'Pasos diarios:',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            _stepCount > 0 ? '$_stepCount' : 'Sensor no disponible o sin actividad',
            style: const TextStyle(
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
