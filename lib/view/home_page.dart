import 'package:cltxpj/controller/calculate_controller.dart';
import 'package:cltxpj/features/app_theme.dart';
import 'package:cltxpj/features/theme_provider.dart';
import 'package:cltxpj/view/widgets/body_container.dart';
import 'package:cltxpj/view/widgets/responsive_extension.dart';
import 'package:cltxpj/view/widgets/responsive_scaffold.dart';
import 'package:cltxpj/view/widgets/show_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final salaryCltController = TextEditingController();
  final salaryPjController = TextEditingController();
  final benefitsController = TextEditingController();
  final taxesPjController = TextEditingController();
  final accountantFeeController = TextEditingController();
  final inssPjController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final currencyFormat = NumberFormat.currency(
    locale: 'pt_BR',
    symbol: '',
    decimalDigits: 2,
  );

  @override
  void initState() {
    super.initState();
    final controller = context.read<CalculatorController>();
    controller.loadData().then((_) {
      salaryCltController.text = formatNumber(controller.model.salaryClt);
      salaryPjController.text = formatNumber(controller.model.salaryPj);
      benefitsController.text = formatNumber(controller.model.benefits);
      accountantFeeController.text = formatNumber(
        controller.model.accountantFee,
      );
      inssPjController.text = (controller.model.inssPj * 100).toStringAsFixed(
        2,
      );

      taxesPjController.text = controller.model.taxesPj.toString();
    });
  }

  @override
  void dispose() {
    salaryCltController.dispose();
    salaryPjController.dispose();
    benefitsController.dispose();
    taxesPjController.dispose();
    accountantFeeController.dispose();
    inssPjController.dispose();

    super.dispose();
  }

  void _formatCurrency(TextEditingController controller) {
    String text = controller.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (text.isEmpty) return;

    double value = double.parse(text) / 100;
    controller.value = TextEditingValue(
      text: currencyFormat.format(value),
      selection: TextSelection.collapsed(
        offset: currencyFormat.format(value).length,
      ),
    );
  }

  String formatNumber(double number) {
    return currencyFormat.format(number);
  }

  double parseCurrency(String value) {
    String cleaned = value.replaceAll(RegExp(r'[^0-9]'), '');
    if (cleaned.isEmpty) return 0.0;

    return double.parse(cleaned) / 100;
  }

  String? _validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'required_field'.tr();
    }
    return null;
  }

  void _showResult() {
    ResultDialog.show(context, currencyFormat);
  }

  void _onCalculatePressed() {
    if (_formKey.currentState!.validate()) {
      final controller = context.read<CalculatorController>();
      controller.updateValues(
        salaryClt: parseCurrency(salaryCltController.text),
        salaryPj: parseCurrency(salaryPjController.text),
        benefits: parseCurrency(benefitsController.text),
        taxesPj: double.parse(taxesPjController.text.replaceAll(',', '.')),
        accountantFee: parseCurrency(accountantFeeController.text),
        inssPj: double.parse(inssPjController.text.replaceAll(',', '.')) / 100,
      );
      _showResult();
    }
  }

  Widget _buildMobileLayout() => _buildFormLayout(padding: 16);

  Widget _buildTabletLayout() => _buildFormLayout(padding: 30);

  Widget _buildDesktopLayout() => _buildFormLayout(padding: 50);

  Widget _buildFormLayout({required double padding}) {
    return Consumer<UiProvider>(
      builder: (context, notifier, child) {
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
            salaryCltController: salaryCltController,
            salaryPjController: salaryPjController,
            benefitsController: benefitsController,
            taxesPjController: taxesPjController,
            accountantFeeController: accountantFeeController,
            inssPjController: inssPjController,
            formatCurrency: _formatCurrency,
            parseCurrency: parseCurrency,
            validator: _validator,
            onCalculatePressed: _onCalculatePressed,
            padding: padding,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveScaffold(
      mobile: _buildMobileLayout,
      tablet: _buildTabletLayout,
      desktop: _buildDesktopLayout,
    );
  }
}
