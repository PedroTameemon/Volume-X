class Workout {
  final String id;
  final String exerciseName;
  final int series;
  final int repetitions;
  final double weight;
  final double volume;
  final DateTime date;

  Workout({
    required this.id,
    required this.exerciseName,
    required this.series,
    required this.repetitions,
    required this.weight,
    required this.volume,
    required this.date,
  });

  // Método auxiliar para calcular volume rapidamente
  static double calculateVolume(int s, int r, double w) => s * r * w;
}