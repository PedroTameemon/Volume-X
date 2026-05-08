import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class HomeVolumeChart extends StatelessWidget {
  const HomeVolumeChart({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: LineChart(
        LineChartData(
          gridData: const FlGridData(show: false),
          titlesData: const FlTitlesData(show: false),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: const [
                FlSpot(0, 1),
                FlSpot(1, 2.5),
                FlSpot(2, 2),
                FlSpot(3, 4.5),
                FlSpot(4, 3.5),
                FlSpot(5, 5.2),
                FlSpot(6, 4.8),
              ],
              isCurved: true,
              gradient: const LinearGradient(
                colors: [Colors.orangeAccent, Colors.deepOrange],
              ),
              barWidth: 3,
              isStrokeCapRound: true,
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  colors: [
                    Colors.orangeAccent.withOpacity(0.1),
                    Colors.transparent,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}