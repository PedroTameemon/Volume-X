import 'package:flutter/material.dart';
import 'package:app_fitness/features/home/workout/workout_page.dart';
import 'package:app_fitness/core/weekly_calendar.dart';
import 'package:app_fitness/progreso/volume.dart'; // 👈 Certifique-se que a classe HomeVolumeChart está aqui
import 'package:app_fitness/progreso/progress_page.dart';
import 'package:app_fitness/progreso/home_volume.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  void _changeTab(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      HomeContent(onSeeProgress: () => _changeTab(2)),
      const WorkoutPage(),
      const ProgressPage(), // 👈 Substituí o Center pela sua ProgressPage real
      const Center(child: Text('Perfil em breve', style: TextStyle(color: Colors.white))),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF1E293B),
        selectedItemColor: Colors.orangeAccent,
        unselectedItemColor: Colors.white70,
        currentIndex: _currentIndex,
        onTap: _changeTab,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Início'),
          BottomNavigationBarItem(icon: Icon(Icons.fitness_center), label: 'Treino'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Progresso'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  final VoidCallback onSeeProgress;

  const HomeContent({super.key, required this.onSeeProgress});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 25),
            
            const Text('SUA SEMANA', style: TextStyle(color: Colors.orangeAccent, fontWeight: FontWeight.bold, fontSize: 14)),
            const SizedBox(height: 10),
            WeeklyCalendar(onDaySelected: (d) {}, workoutDays: [DateTime.now()]),
            
            const SizedBox(height: 25),

            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('EVOLUÇÃO', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      TextButton(
                        onPressed: onSeeProgress,
                        child: const Text('Ver mais', style: TextStyle(color: Colors.orangeAccent)),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  const HomeVolumeChart(), 
                ],
              ),
            ),

            const SizedBox(height: 25),
            _buildStats(),
            const SizedBox(height: 25),
            _buildShortcuts(),
            const SizedBox(height: 25),
            _buildHabits(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Colors.orangeAccent, Colors.deepOrange]),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Bem-vindo 👋', style: TextStyle(color: Colors.white70)),
          SizedBox(height: 8),
          Text('VolumeX', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white)),
          SizedBox(height: 6),
          Text('Continue evoluindo hoje 💪', style: TextStyle(color: Colors.white70)),
        ],
      ),
    );
  }

  Widget _buildStats() {
    return Row(
      children: [
        _buildStatCard('Treinos', '12', Icons.fitness_center),
        const SizedBox(width: 10),
        _buildStatCard('Volume', '2.4k', Icons.bar_chart),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: const Color(0xFF1E293B), borderRadius: BorderRadius.circular(16)),
        child: Column(
          children: [
            Icon(icon, color: Colors.orangeAccent),
            const SizedBox(height: 10),
            Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
            Text(title, style: const TextStyle(color: Colors.white70)),
          ],
        ),
      ),
    );
  }

  Widget _buildShortcuts() {
    return Row(
      children: [
        _buildShortcut(Icons.add, 'Novo treino'),
        const SizedBox(width: 10),
        _buildShortcut(Icons.show_chart, 'Progresso'),
      ],
    );
  }

  Widget _buildShortcut(IconData icon, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: const Color(0xFF1E293B), borderRadius: BorderRadius.circular(16)),
        child: Column(
          children: [
            Icon(icon, color: Colors.orangeAccent),
            const SizedBox(height: 8),
            Text(label, style: const TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }

  Widget _buildHabits() {
    return Column(
      children: [
        _buildHabitTile('Beber 2L de água', true),
        _buildHabitTile('Treinar', false),
      ],
    );
  }

  Widget _buildHabitTile(String title, bool done) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(color: const Color(0xFF1E293B), borderRadius: BorderRadius.circular(12)),
      child: CheckboxListTile(
        value: done,
        onChanged: (_) {},
        title: Text(title, style: const TextStyle(color: Colors.white)),
        activeColor: Colors.orangeAccent,
      ),
    );
  }
}