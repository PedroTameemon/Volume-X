import 'package:flutter/material.dart';
import 'package:app_fitness/features/home/workout/workout.dart';
import 'package:app_fitness/features/home/workout/workout_page.dart';

class WorkoutPage extends StatefulWidget {
  const WorkoutPage({super.key});

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  final List<Workout> _myWorkouts = [];

  void _addWorkout(Workout workout) {
    setState(() {
      _myWorkouts.add(workout);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        title: const Text('Meus Treinos', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF1E293B),
        elevation: 0,
      ),
      body: _myWorkouts.isEmpty
          ? const Center(child: Text('Nenhum treino registrado.', style: TextStyle(color: Colors.white70)))
          : ListView.builder(
              itemCount: _myWorkouts.length,
              itemBuilder: (context, index) {
                final workout = _myWorkouts[index];
                return Card(
                  color: const Color(0xFF1E293B),
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: Colors.orangeAccent,
                      child: Icon(Icons.fitness_center, color: Colors.white),
                    ),
                    title: Text(workout.exerciseName, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    subtitle: Text('${workout.series}x${workout.repetitions} - ${workout.weight}kg', style: const TextStyle(color: Colors.white70)),
                    trailing: Text('Vol: ${workout.volume.toStringAsFixed(1)}', 
                      style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.orangeAccent)),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddWorkoutDialog(context),
        backgroundColor: Colors.orangeAccent,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddWorkoutDialog(BuildContext context) {
    final nameController = TextEditingController();
    final seriesController = TextEditingController();
    final repsController = TextEditingController();
    final weightController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E293B),
        title: const Text('Novo Exercício', style: TextStyle(color: Colors.white)),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildTextField(nameController, 'Exercício (ex: Supino)'),
              _buildTextField(seriesController, 'Séries', isNumber: true),
              _buildTextField(repsController, 'Repetições', isNumber: true),
              _buildTextField(weightController, 'Peso (kg)', isNumber: true),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar', style: TextStyle(color: Colors.white70))),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.orangeAccent),
            onPressed: () {
              final name = nameController.text;
              final s = int.tryParse(seriesController.text) ?? 0;
              final r = int.tryParse(repsController.text) ?? 0;
              final w = double.tryParse(weightController.text) ?? 0.0;

              if (name.isNotEmpty && s > 0 && r > 0) {
                final newWorkout = Workout(
                  id: DateTime.now().toString(),
                  exerciseName: name,
                  series: s,
                  repetitions: r,
                  weight: w,
                  volume: Workout.calculateVolume(s, r, w),
                  date: DateTime.now(),
                );
                _addWorkout(newWorkout);
                Navigator.pop(context);
              }
            },
            child: const Text('Salvar'),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, {bool isNumber = false}) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white70),
        enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.white24)),
      ),
    );
  }
}