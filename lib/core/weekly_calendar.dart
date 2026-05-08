import 'package:flutter/material.dart';

class WeeklyCalendar extends StatefulWidget {
  final Function(DateTime) onDaySelected;
  final List<DateTime> workoutDays;

  const WeeklyCalendar({
    super.key,
    required this.onDaySelected,
    this.workoutDays = const [],
  });

  @override
  State<WeeklyCalendar> createState() => _WeeklyCalendarState();
}

class _WeeklyCalendarState extends State<WeeklyCalendar> {
  late DateTime _selectedDay;
  late List<DateTime> _weekDays;

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now();
    _weekDays = _getWeekDays(_selectedDay);
  }

  List<DateTime> _getWeekDays(DateTime date) {
    final startOfWeek = date.subtract(Duration(days: date.weekday - 1));
    return List.generate(7, (index) => startOfWeek.add(Duration(days: index)));
  }

  bool _isSameDay(DateTime day1, DateTime day2) {
    return day1.year == day2.year &&
        day1.month == day2.month &&
        day1.day == day2.day;
  }

  @override
  Widget build(BuildContext context) {
    // Adicionando um fundo colorido temporário para depuração
    return Container(
      height: 100,
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B), // Cor de fundo do card
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: _weekDays.map((day) {
          final isSelected = _isSameDay(day, _selectedDay);
          final hasWorkout = widget.workoutDays.any((wd) => _isSameDay(wd, day));
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedDay = day;
              });
              widget.onDaySelected(day);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _getWeekdayName(day.weekday),
                  style: TextStyle(
                    color: isSelected ? Colors.orangeAccent : Colors.white70,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Colors.orangeAccent
                        : hasWorkout
                            ? Colors.green.withOpacity(0.3)
                            : Colors.transparent,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected ? Colors.orangeAccent : Colors.white24,
                    ),
                  ),
                  child: Text(
                    day.day.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  String _getWeekdayName(int weekday) {
    switch (weekday) {
      case 1: return 'S';
      case 2: return 'T';
      case 3: return 'Q';
      case 4: return 'Q';
      case 5: return 'S';
      case 6: return 'S';
      case 7: return 'D';
      default: return '';
    }
  }
}