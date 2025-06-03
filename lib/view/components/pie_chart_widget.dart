import 'package:cltxpj/features/app_theme.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PieChartWidget extends StatelessWidget {
  final Map<String, double> dataMap;
  final List<Color> colorList;
  final double size;

  const PieChartWidget({
    super.key,
    required this.dataMap,
    required this.colorList,
    this.size = 150,
  });

  @override
  Widget build(BuildContext context) {
    if (dataMap.isEmpty) {
      return const Center(child: Text("Sem dados para exibir"));
    }

    final sections =
        dataMap.entries.map((entry) {
          final index = dataMap.keys.toList().indexOf(entry.key);
          final color = colorList[index % colorList.length];

          return PieChartSectionData(
            color: color,
            value: entry.value.abs(),
            title: entry.value.toStringAsFixed(0),
            titleStyle: TextStyle(
              fontSize: size / 9,
              fontWeight: FontWeight.bold,
              color: TextColor.primaryColor,
            ),
            radius: size / 2.6,
          );
        }).toList();

    return AspectRatio(
      aspectRatio: 1,
      child: PieChart(
        PieChartData(
          sections: sections,
          sectionsSpace: 2,
          centerSpaceRadius: size / 5,
          startDegreeOffset: -90,
        ),
      ),
    );
  }
}
