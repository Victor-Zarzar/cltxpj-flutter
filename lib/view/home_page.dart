import 'package:cltxpj/controller/calculate_controller.dart';
import 'package:cltxpj/features/app_theme.dart';
import 'package:cltxpj/features/theme_provider.dart';
import 'package:cltxpj/utils/chart_data_hepler.dart';
import 'package:cltxpj/view/components/input_field.dart';
import 'package:cltxpj/view/components/pie_chart_widget.dart';
import 'package:cltxpj/view/widgets/responsive_scaffold.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
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
    String text = controller.text.replaceAll('.', '').replaceAll(',', '');
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
    return double.tryParse(
          value
              .replaceAll('.', '')
              .replaceAll(',', '.')
              .replaceAll(' ', '')
              .trim(),
        ) ??
        0.0;
  }

  String? _validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'required_field'.tr();
    }
    return null;
  }

  void _showResult() {
    final controller = context.read<CalculatorController>();
    final totalClt = controller.totalClt;
    final totalPj = controller.totalPj;
    final difference = (totalClt - totalPj).abs();

    final chartData = ChartDataHelper.buildResultChartData(
      cltNet: totalClt,
      pjNet: totalPj,
    );

    final colorList = [Colors.blue, Colors.green];

    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: Text('result'.tr()),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                PieChartWidget(
                  dataMap: chartData,
                  colorList: colorList,
                  size: 180,
                ),
                const SizedBox(height: 16),
                Text(
                  'clt_net'.tr(
                    namedArgs: {'amount': currencyFormat.format(totalClt)},
                  ),
                ), // Changed
                Text(
                  'pj_net'.tr(
                    namedArgs: {'amount': currencyFormat.format(totalPj)},
                  ),
                ), // Changed
                const SizedBox(height: 8),
                Text(
                  'difference'.tr(
                    namedArgs: {'amount': currencyFormat.format(difference)},
                  ), // Changed
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  controller.bestOption,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('close'.tr()),
              ),
            ],
          ),
    );
  }

  Widget _buildMobileLayout() => _buildFormLayout(padding: 16);

  Widget _buildTabletLayout() => _buildFormLayout(padding: 30);

  Widget _buildDesktopLayout() => _buildFormLayout(padding: 50);

  Widget _buildFormLayout({required double padding}) {
    final controller = context.watch<CalculatorController>();

    return Consumer<UiProvider>(
      builder: (context, notifier, child) {
        return Scaffold(
          appBar: GFAppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            backgroundColor:
                notifier.isDark
                    ? AppBarColor.fourthColor
                    : AppBarColor.secondaryColor,
            title: Text(
              'app_bar_title'.tr(),
              style: GoogleFonts.roboto(
                textStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: TextColor.primaryColor,
                ),
              ),
            ),
          ),
          backgroundColor:
              notifier.isDark
                  ? BackGroundColor.fourthColor
                  : BackGroundColor.primaryColor,
          body: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(
                padding,
                padding + 60,
                padding,
                padding,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    InputField(
                      label: 'salary_clt'.tr(),
                      controller: salaryCltController,
                      validator: _validator,
                      icon: Icons.money,
                      maxWidth: 600,
                      onChanged: (_) => _formatCurrency(salaryCltController),
                    ),
                    InputField(
                      label: 'salary_pj'.tr(),
                      controller: salaryPjController,
                      validator: _validator,
                      icon: Icons.money,
                      maxWidth: 600,
                      onChanged: (_) => _formatCurrency(salaryPjController),
                    ),
                    InputField(
                      label: 'benefits_clt'.tr(),
                      controller: benefitsController,
                      validator: _validator,
                      icon: Icons.card_giftcard,
                      maxWidth: 600,
                      onChanged: (_) => _formatCurrency(benefitsController),
                    ),
                    InputField(
                      label: 'accountant_fee'.tr(),
                      controller: accountantFeeController,
                      validator: _validator,
                      icon: Icons.receipt,
                      maxWidth: 600,
                      onChanged:
                          (_) => _formatCurrency(accountantFeeController),
                    ),

                    InputField(
                      label: 'inss_pj'.tr(),
                      controller: inssPjController,
                      validator: _validator,
                      icon: Icons.percent,
                      maxWidth: 600,
                    ),
                    InputField(
                      label: 'taxes_pj'.tr(),
                      controller: taxesPjController,
                      validator: _validator,
                      icon: Icons.percent,
                      maxWidth: 600,
                    ),
                    const SizedBox(height: 20),
                    GFButton(
                      color:
                          notifier.isDark
                              ? ButtonColor.fourthColor
                              : ButtonColor.primaryColor,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          controller.updateValues(
                            salaryClt: parseCurrency(salaryCltController.text),
                            salaryPj: parseCurrency(salaryPjController.text),
                            benefits: parseCurrency(benefitsController.text),
                            taxesPj: double.parse(
                              taxesPjController.text.replaceAll(',', '.'),
                            ),
                            accountantFee: parseCurrency(
                              accountantFeeController.text,
                            ),
                            inssPj:
                                double.parse(
                                  inssPjController.text.replaceAll(',', '.'),
                                ) /
                                100,
                          );
                          _showResult();
                        }
                      },
                      child: Text('calculate'.tr()),
                    ),
                  ],
                ),
              ),
            ),
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
