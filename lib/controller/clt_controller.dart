import 'dart:async';
import 'package:cltxpj/utils/salary_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:cltxpj/services/storage_service.dart';
import 'package:cltxpj/model/calculate_model.dart';

class CltController extends ChangeNotifier {
  final salaryController = MoneyMaskedTextController(
    leftSymbol: 'R\$ ',
    decimalSeparator: ',',
    thousandSeparator: '.',
  );

  final benefitsController = MoneyMaskedTextController(
    leftSymbol: 'R\$ ',
    decimalSeparator: ',',
    thousandSeparator: '.',
  );

  double netSalary = 0.0;
  double inss = 0.0;
  double irrf = 0.0;
  double benefits = 0.0;

  bool showChart = false;
  Timer? _debounce;

  CltController() {
    _loadData();
  }

  void calculate() {
    final salary = salaryController.numberValue;
    benefits = benefitsController.numberValue;

    inss = calculateInss(salary);
    irrf = calculateIrrf(salary);
    netSalary = salary - inss - irrf + benefits;

    showChart = salary > 0 || benefits > 0;

    _saveData(salary, benefits);
    notifyListeners();
  }

  void calculateDebounced() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 800), () {
      calculate();
    });
  }

  Future<void> _loadData() async {
    final model = await StorageService.loadData();
    salaryController.updateValue(model.salaryClt);
    benefitsController.updateValue(model.benefits);
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
}
