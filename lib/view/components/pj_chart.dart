import 'package:cltxpj/controller/calculate_controller.dart';
import 'package:cltxpj/controller/pj_controller.dart';
import 'package:cltxpj/features/app_theme.dart';
import 'package:cltxpj/features/theme_provider.dart';
import 'package:cltxpj/view/components/pie_chart_widget.dart';
import 'package:cltxpj/view/widgets/responsive_extension.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PjChart extends StatelessWidget {
  const PjChart({super.key});

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
        final notifier = context.watch<UiProvider>();
        if (!ctrl.showChart) {
          return Padding(
            padding: const EdgeInsets.only(top: 100),
            child: Column(
              children: <Widget>[
                Text(
                  'fill_fields_to_see_chart'.tr(),
                  style: context.h1,
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: CircularProgressIndicator(
                    color:
                        notifier.isDark
                            ? LoadingColor.primaryColor
                            : TabBarColor.secondaryColor,
                  ),
                ),
              ],
            ),
          );
        }

        return Column(
          children: [
            Text(
              '${'net_salary'.tr()}: ${currencyFormat.format(ctrl.netSalary)}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 0),
            PieChartWidget(
              dataMap: {
                'taxes'.tr(): ctrl.tax,
                'accountant'.tr(): ctrl.accountantFee,
                'inss'.tr(): ctrl.inss,
                'net'.tr(): ctrl.netSalary,
              },
              colorList: colorList,
              size: 180,
            ),
          ],
        );
      },
    );
  }
}
