import 'package:flutter/material.dart';
import '../controllers/budget_controller.dart';
import '../controllers/spending_controller.dart';
import 'package:get/get.dart';
import '../widgets/custom_scaffold_widget.dart';

class StatisticScreen extends StatelessWidget {
  final BudgetController budgetController = Get.find<BudgetController>();
  final SpendingController spendingController = Get.find<SpendingController>();

  double get totalIncome {
    return budgetController.budgetList
        .map((obj) => obj.amount)
        .fold(0, (previousValue, amount) => previousValue + amount);
  }

  double get totalExpenses {
    return spendingController.spendingList
        .map((obj) => obj.amount)
        .fold(0, (previousValue, amount) => previousValue + amount);
  }

  double get largestExpense {
    if (spendingController.spendingList.isEmpty) return 0;
    return spendingController.spendingList
        .map((obj) => obj.amount)
        .reduce((x, y) => x > y ? x : y);
  }

  double get surplus {
    return totalIncome - totalExpenses;
  }

  double get percentageSpent {
    if (totalIncome == 0) return 0;
    return (totalExpenses / totalIncome) * 100;
  }

  String get surplusDeficit {
    return surplus >= 0 ? 'Surplus' : 'Deficit';
  }

  double get savingsRate {
    if (totalIncome == 0) return 0;
    return ((totalIncome - totalExpenses) / totalIncome) * 100;
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBar(title: const Text("Expense tracker ✨")),
            const SizedBox(height: 30),
            Text("Total income: $totalIncome€",
                style: const TextStyle(fontSize: 21)),
            Text("Total expenses: $totalExpenses",
                style: const TextStyle(fontSize: 21)),
            surplus >= 0
                ? Text("Total surplus: $surplus€",
                    style: const TextStyle(fontSize: 21, color: Colors.green))
                : Text("Total deficit: $surplus€",
                    style: const TextStyle(fontSize: 21, color: Colors.red)),
            const SizedBox(height: 30),
            Text("Percentage of income spent: $percentageSpent%",
                style: const TextStyle(fontSize: 21)),
            Text("Savings rate: $savingsRate%",
                style: const TextStyle(fontSize: 21)),
            Text("Largest expense: $largestExpense€",
                style: const TextStyle(fontSize: 21)),
          ],
        ),
      ),
    );
  }
}
