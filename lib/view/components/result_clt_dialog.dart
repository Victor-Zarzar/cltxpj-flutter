import 'package:cltxpj/controller/clt_controller.dart';
import 'package:cltxpj/features/app_theme.dart';

import 'package:cltxpj/utils/chart_clt_data_helper.dart';
import 'package:cltxpj/view/components/pie_chart_widget.dart';
import 'package:cltxpj/view/widgets/responsive_extension.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResultCltDialog extends StatelessWidget {
  const ResultCltDialog({super.key, required this.currencyFormat});

  final NumberFormat currencyFormat;

  static void show(BuildContext context, NumberFormat currencyFormat) {
    showDialog(
      context: context,
      builder: (_) => ResultCltDialog(currencyFormat: currencyFormat),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorList = [
      ChartColor.primaryColor,
      ChartColor.secondaryColor,
      ChartColor.thirdColor,
      ChartColor.fourthColor,
    ];

    return Consumer<CltController>(
      builder: (context, ctrl, _) {
        final chartData = CltChartDataHelper.buildResultChartData(
          netSalary: ctrl.netSalary,
          inss: ctrl.inss,
          irrf: ctrl.irrf,
          benefits: ctrl.benefits,
        );

        return AlertDialog(
          title: Text('result'.tr()),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                PieChartWidget(
                  dataMap: chartData,
                  colorList: colorList,
                  size: 180,
                ),
                const SizedBox(height: 30),
                Text(
                  '${'net_salary'.tr()}: ${currencyFormat.format(ctrl.netSalary)}',
                  style: context.bodySmallDarkBold,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('close'.tr(), style: context.bodySmallDarkBold),
            ),
          ],
        );
      },
    );
  }
}
