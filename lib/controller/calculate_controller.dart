import 'package:cltxpj/model/calculate_model.dart';
import 'package:flutter/material.dart';
import '../services/storage_service.dart';

class CalculatorController extends ChangeNotifier {
  CalculatorModel model = CalculatorModel(
    salaryClt: 0,
    salaryPj: 0,
    benefits: 0,
    taxesPj: 0,
  );

  double get totalClt => model.salaryClt + model.benefits;

  double get totalPj {
    final tax = model.salaryPj * (model.taxesPj / 100);
    return model.salaryPj - tax;
  }

  String get bestOption {
    if (totalClt > totalPj) {
      final diff = totalClt - totalPj;
      return "CLT is better by ${diff.toStringAsFixed(2)}";
    } else if (totalPj > totalClt) {
      final diff = totalPj - totalClt;
      return "PJ is better by ${diff.toStringAsFixed(2)}";
    } else {
      return "It's a tie";
    }
  }

  void updateValues({
    required double salaryClt,
    required double salaryPj,
    required double benefits,
    required double taxesPj,
  }) {
    model = CalculatorModel(
      salaryClt: salaryClt,
      salaryPj: salaryPj,
      benefits: benefits,
      taxesPj: taxesPj,
    );
    StorageService.saveData(model);
    notifyListeners();
  }

  Future<void> loadData() async {
    model = await StorageService.loadData();
    notifyListeners();
  }
}
