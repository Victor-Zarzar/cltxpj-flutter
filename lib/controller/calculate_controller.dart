import 'package:cltxpj/model/calculate_model.dart';
import 'package:cltxpj/utils/salary_helper.dart';
import 'package:flutter/material.dart';
import '../services/storage_service.dart';

class CalculatorController extends ChangeNotifier {
  CalculatorModel model = CalculatorModel(
    salaryClt: 0,
    salaryPj: 0,
    benefits: 0,
    taxesPj: 0,
  );

  double get totalClt {
    final inss = calculateInss(model.salaryClt);
    final irrf = calculateIrrf(model.salaryClt);
    return model.salaryClt - inss - irrf + model.benefits;
  }

  double get totalPj {
    final taxPj = model.salaryPj * (model.taxesPj / 100);
    final inss = model.salaryPj * model.inssPj;
    final accountantFee = model.accountantFee;

    final totalDiscounts = taxPj + inss + accountantFee;
    final netPj = model.salaryPj - totalDiscounts;

    return netPj;
  }

  String get bestOption {
    final diff = (totalClt - totalPj).abs();

    if (totalClt > totalPj) {
      return "CLT é melhor por R\$ ${diff.toStringAsFixed(2)}";
    } else if (totalPj > totalClt) {
      return "PJ é melhor por R\$ ${diff.toStringAsFixed(2)}";
    } else {
      return "Empate perfeito";
    }
  }

  void updateValues({
    required double salaryClt,
    required double salaryPj,
    required double benefits,
    required double taxesPj,
    double accountantFee = 189.0,
    double inssPj = 0.11,
  }) {
    model = CalculatorModel(
      salaryClt: salaryClt,
      salaryPj: salaryPj,
      benefits: benefits,
      taxesPj: taxesPj,
      accountantFee: accountantFee,
      inssPj: inssPj,
    );
    StorageService.saveData(model);
    notifyListeners();
  }

  Future<void> loadData() async {
    model = await StorageService.loadData();
    notifyListeners();
  }
}
