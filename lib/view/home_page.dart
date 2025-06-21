import 'package:cltxpj/controller/calculate_controller.dart';
import 'package:cltxpj/features/app_theme.dart';
import 'package:cltxpj/features/theme_provider.dart';
import 'package:cltxpj/utils/currency_format_helper.dart';
import 'package:cltxpj/view/widgets/body_home_container.dart';
import 'package:cltxpj/view/widgets/responsive.dart';
import 'package:cltxpj/view/widgets/responsive_extension.dart';
import 'package:cltxpj/view/components/show_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    final controller = context.read<CalculatorController>();
    controller.loadData();
  }

  void _onCalculatePressed() {
    if (_formKey.currentState!.validate()) {
      final controller = context.read<CalculatorController>();
      controller.calculate();
      ResultDialog.show(context, currencyFormat);
    }
  }

  Widget _buildContent(
    BuildContext context, {
    required double maxWidth,
    required double minHeight,
    required double padding,
  }) {
    return Consumer2<UiProvider, CalculatorController>(
      builder: (context, notifier, controller, child) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor:
                notifier.isDark
                    ? AppBarColor.fourthColor
                    : AppBarColor.secondaryColor,
            title: Text('app_bar_title'.tr(), style: context.h1),
          ),
          backgroundColor:
              notifier.isDark
                  ? BackGroundColor.fourthColor
                  : BackGroundColor.primaryColor,
          body: BodyContainer(
            formKey: _formKey,
            salaryCltController: controller.salaryCltController,
            salaryPjController: controller.salaryPjController,
            benefitsController: controller.benefitsController,
            taxesPjController: controller.taxesPjController,
            accountantFeeController: controller.accountantFeeController,
            inssPjController: controller.inssPjController,
            onCalculatePressed: _onCalculatePressed,
            padding: padding,
            maxWidth: maxWidth,
            minHeight: minHeight,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: _buildContent(
        context,
        maxWidth: 320,
        padding: 20,
        minHeight: 550,
      ),
      tablet: _buildContent(
        context,
        maxWidth: 600,
        minHeight: 600,
        padding: 30,
      ),
      desktop: _buildContent(
        context,
        maxWidth: 700,
        minHeight: 570,
        padding: 50,
      ),
    );
  }
}
