import 'package:cltxpj/model/calculate_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static Future<void> saveData(CalculatorModel model) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setDouble('salaryClt', model.salaryClt);
    prefs.setDouble('salaryPj', model.salaryPj);
    prefs.setDouble('benefits', model.benefits);
    prefs.setDouble('taxesPj', model.taxesPj);
  }

  static Future<CalculatorModel> loadData() async {
    final prefs = await SharedPreferences.getInstance();
    return CalculatorModel(
      salaryClt: prefs.getDouble('salaryClt') ?? 0,
      salaryPj: prefs.getDouble('salaryPj') ?? 0,
      benefits: prefs.getDouble('benefits') ?? 0,
      taxesPj: prefs.getDouble('taxesPj') ?? 0,
    );
  }
}
