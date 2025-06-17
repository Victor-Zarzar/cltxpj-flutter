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

  final taxController = TextEditingController(text: '10');
  final inssController = TextEditingController(text: '11');

  double netSalary = 0.0;
  double tax = 0.0;
  double accountantFee = 0.0;
  double inss = 0.0;

  bool showChart = false;
  Timer? _debounce;

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

    showChart =
        salary > 0 && accountantFee > 0 && taxPercent >= 0 && inssPercent >= 0;

    _saveData(salary, taxPercent, accountantFee, inssPercent);
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
