import 'package:cltxpj/controller/calculate_controller.dart';
import 'package:cltxpj/features/app_theme.dart';
import 'package:cltxpj/view/components/input_field.dart';
import 'package:cltxpj/view/widgets/responsive_scaffold.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
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

  final _formKey = GlobalKey<FormState>();
  final regex = RegExp(r'^\d*\.?\d*$');

  final currencyFormat = NumberFormat.currency(
    locale: 'pt_BR',
    symbol: 'R\$',
    decimalDigits: 2,
  );

  @override
  void initState() {
    super.initState();
    final controller = context.read<CalculatorController>();
    controller.loadData().then((_) {
      salaryCltController.text = controller.model.salaryClt.toString();
      salaryPjController.text = controller.model.salaryPj.toString();
      benefitsController.text = controller.model.benefits.toString();
      taxesPjController.text = controller.model.taxesPj.toString();
    });
  }

  @override
  void dispose() {
    salaryCltController.dispose();
    salaryPjController.dispose();
    benefitsController.dispose();
    taxesPjController.dispose();
    super.dispose();
  }

  String? _validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Required field';
    }
    final parsedValue = double.tryParse(value.replaceAll(',', '.'));
    if (parsedValue == null) {
      return 'Only valid numbers';
    }
    if (parsedValue <= 0) {
      return 'Value must be greater than zero';
    }
    return null;
  }

  void _showResult() {
    final controller = context.read<CalculatorController>();
    final totalClt = controller.totalClt;
    final totalPj = controller.totalPj;
    final difference = (totalClt - totalPj).abs();

    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text('Result'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('💼 CLT Net: ${currencyFormat.format(totalClt)}'),
                Text('🧑‍💻 PJ Net: ${currencyFormat.format(totalPj)}'),
                const SizedBox(height: 8),
                Text(
                  'Difference: ${currencyFormat.format(difference)}',
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
                child: const Text('Close'),
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

    return Scaffold(
      appBar: GFAppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: AppTheme.thirdColor,
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
      backgroundColor: BackGround.primaryColor,
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(padding),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                InputField(
                  label: 'CLT Salary',
                  controller: salaryCltController,
                  validator: _validator,
                ),
                InputField(
                  label: 'PJ Salary',
                  controller: salaryPjController,
                  validator: _validator,
                ),
                InputField(
                  label: 'CLT Benefits',
                  controller: benefitsController,
                  validator: _validator,
                ),
                InputField(
                  label: 'PJ Taxes (%)',
                  controller: taxesPjController,
                  validator: _validator,
                ),
                const SizedBox(height: 20),
                GFButton(
                  color: Button.primaryColor,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      controller.updateValues(
                        salaryClt: double.parse(
                          salaryCltController.text.replaceAll(',', '.'),
                        ),
                        salaryPj: double.parse(
                          salaryPjController.text.replaceAll(',', '.'),
                        ),
                        benefits: double.parse(
                          benefitsController.text.replaceAll(',', '.'),
                        ),
                        taxesPj: double.parse(
                          taxesPjController.text.replaceAll(',', '.'),
                        ),
                      );
                      _showResult();
                    }
                  },
                  child: const Text('Calculate'),
                ),
              ],
            ),
          ),
        ),
      ),
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
