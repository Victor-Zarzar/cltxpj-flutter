import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:cltxpj/services/storage_service.dart';
import 'package:cltxpj/model/calculate_model.dart';

class PjController extends ChangeNotifier {
  final salaryController = MoneyMaskedTextController(
    leftSymbol: 'R\$ ',
    decimalSeparator: ',',
    thousandSeparator: '.',
  );

  final accountantController = MoneyMaskedTextController(
    leftSymbol: 'R\$ ',
    decimalSeparator: ',',
    thousandSeparator: '.',
    initialValue: 189.0,
  );

  final taxController = TextEditingController();
  final inssController = TextEditingController();

  double netSalary = 0.0;
  double tax = 0.0;
  double accountantFee = 189.0;
  double inss = 0.11;

  bool get hasValidInput => netSalary > 0 && tax > 0 && inss > 0;

  PjController() {
    _loadData();
  }

  void calculate() {
    final salary = salaryController.numberValue;
    final taxPercent =
        double.tryParse(taxController.text.replaceAll(',', '.')) ?? 0;
    final inssPercent =
        double.tryParse(inssController.text.replaceAll(',', '.')) ?? 0;

    accountantFee = accountantController.numberValue;
    tax = salary * (taxPercent / 100);
    inss = salary * (inssPercent / 100);

    final totalDiscount = tax + inss + accountantFee;
    netSalary = salary - totalDiscount;

    _saveData(salary, taxPercent, accountantFee, inssPercent);
    notifyListeners();
  }

  Future<void> _loadData() async {
    final model = await StorageService.loadData();

    salaryController.updateValue(model.salaryPj);
    accountantController.updateValue(model.accountantFee);
    taxController.text = model.taxesPj.toStringAsFixed(0);
    inssController.text = model.inssPj.toStringAsFixed(0);

    calculate();
  }

  Future<void> _saveData(
    double salary,
    double taxPercent,
    double accountant,
    double inssPercent,
  ) async {
    final model = CalculatorModel(
      salaryClt: 0,
      benefits: 0,
      salaryPj: salary,
      taxesPj: taxPercent,
      accountantFee: accountant,
      inssPj: inssPercent,
    );
    await StorageService.saveData(model);
  }
}
