import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import '../models/budget.dart';

class BudgetController {
  final storage = Hive.box("storage");

  RxList budgetList;

  BudgetController() : budgetList = [].obs {
    if (storage.get('budgetList') == null) {
      storage.put('budgetList', []);
    }
    budgetList.value = storage
        .get('budgetList')
        .map(
          (budget) => Budget.fromJson(budget),
        )
        .toList();
  }
  void _save() {
    storage.put(
      'budgetList',
      budgetList.map((budget) => budget.toJson()).toList(),
    );
  }

  void add(Budget budget) {
    budgetList.add(budget);
    _save();
  }

  void delete(Budget budget) {
    budgetList.remove(budget);
    budgetList.refresh();
    _save();
  }

  void edit(Budget budget) {
    int index = budgetList.indexWhere((expense) => expense.id == budget.id);
    budgetList[index] = budget;
    budgetList.refresh();
    _save();
  }

  get size => budgetList.length;
}
