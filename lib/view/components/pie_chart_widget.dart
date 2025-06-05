import 'package:cltxpj/features/app_theme.dart';
import 'package:cltxpj/features/theme_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

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
    final notifier = context.watch<UiProvider>();
    if (dataMap.isEmpty) {
      return Center(
        child: Text(
          "no_data_display".tr(),
          style: GoogleFonts.roboto(
            textStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color:
                  notifier.isDark
                      ? TextColor.primaryColor
                      : TextColor.fourthColor,
            ),
          ),
        ),
      );
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

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: PieChart(
            PieChartData(
              sections: sections,
              sectionsSpace: 2,
              centerSpaceRadius: size / 5,
              startDegreeOffset: -90,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 20,
          runSpacing: 8,
          children:
              dataMap.entries.map((entry) {
                final index = dataMap.keys.toList().indexOf(entry.key);
                final color = colorList[index % colorList.length];

                return Indicator(color: color, text: entry.key);
              }).toList(),
        ),
      ],
    );
  }
}

class Indicator extends StatelessWidget {
  final Color color;
  final String text;

  const Indicator({super.key, required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Consumer<UiProvider>(
      builder: (context, notifier, child) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(shape: BoxShape.circle, color: color),
            ),
            const SizedBox(width: 6),
            Text(
              text,
              style: GoogleFonts.roboto(
                textStyle: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color:
                      notifier.isDark
                          ? TextColor.primaryColor
                          : TextColor.fourthColor,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
