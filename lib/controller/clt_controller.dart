import 'package:cltxpj/utils/salary_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:cltxpj/services/storage_service.dart';
import 'package:cltxpj/model/calculate_model.dart';

class CltController extends ChangeNotifier {
  final cltSalaryController = MoneyMaskedTextController(
    leftSymbol: 'R\$ ',
    decimalSeparator: ',',
    thousandSeparator: '.',
  );

  final cltBenefitsController = MoneyMaskedTextController(
    leftSymbol: 'R\$ ',
    decimalSeparator: ',',
    thousandSeparator: '.',
  );

  double netSalary = 0.0;
  double inss = 0.0;
  double irrf = 0.0;
  double benefits = 0.0;

  bool get hasValidInput => netSalary > 0;

  CltController() {
    _loadData();
  }

  void calculate() {
    final salary = cltSalaryController.numberValue;
    benefits = cltBenefitsController.numberValue;

    inss = calculateInss(salary);
    irrf = calculateIrrf(salary);
    netSalary = salary - inss - irrf + benefits;

    _saveData(salary, benefits);
    notifyListeners();
  }

  Future<void> _loadData() async {
    final model = await StorageService.loadData();
    cltSalaryController.updateValue(model.salaryClt);
    cltBenefitsController.updateValue(model.benefits);
    calculate();
  }

  Future<void> _saveData(double salary, double benefits) async {
    final model = CalculatorModel(
      salaryClt: salary,
      benefits: benefits,
      salaryPj: 0,
      taxesPj: 0,
      accountantFee: 0,
      inssPj: 0,
    );
    await StorageService.saveData(model);
  }

  @override
  void dispose() {
    cltSalaryController.dispose();
    cltBenefitsController.dispose();
    super.dispose();
  }
}
