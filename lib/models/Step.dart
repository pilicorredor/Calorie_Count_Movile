class Step {
  int? id;
  int stepCount;
  String date;

  Step({this.id, required this.stepCount, required this.date});

  // Convertir Step a Map para almacenar en la base de datos
  Map<String, dynamic> toJson() => {
        'id': id,
        'stepCount': stepCount,
        'date': date,
      };

  // Crear un Step a partir de un Map obtenido de la base de datos
  factory Step.fromJson(Map<String, dynamic> json) => Step(
        id: json['id'],
        stepCount: json['stepCount'],
        date: json['date'],
      );
}
