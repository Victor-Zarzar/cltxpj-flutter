import 'package:cltxpj/controller/pj_controller.dart';
import 'package:cltxpj/features/app_theme.dart';
import 'package:cltxpj/utils/chart_pj_data_helper.dart';
import 'package:cltxpj/view/components/pie_chart_widget.dart';
import 'package:cltxpj/view/widgets/responsive_extension.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResultPjtDialog extends StatelessWidget {
  const ResultPjtDialog({super.key, required this.currencyFormat});

  final NumberFormat currencyFormat;

  static void show(BuildContext context, NumberFormat currencyFormat) {
    showDialog(
      context: context,
      builder: (_) => ResultPjtDialog(currencyFormat: currencyFormat),
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

    return Consumer<PjController>(
      builder: (context, ctrl, _) {
        final chartData = PjChartDataHelper.buildResultChartData(
          tax: ctrl.tax,
          inss: ctrl.inss,
          accountantFee: ctrl.accountantFee,
          netSalary: ctrl.netSalary,
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
